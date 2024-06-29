import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/screens/chat/model/chat.model.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/env.dart';
import 'package:mentalwellness/utils/toast.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserService {

  static Future<List<AgentModel>> fetchAgentsList() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      AppLog.log().i('Fetching agents list');

      List<AgentModel> agentsList = [];

      QuerySnapshot querySnapshot = await db.collection("agents").get();
      for (var doc in querySnapshot.docs) {
        print("doc id: ${doc.id} => data: ${doc.data()}");

        Map<String, Object?> agentData = Map<String, Object?>.from(doc.data() as Map);

        agentData['uid'] = doc.id;

        // Convert Timestamp to DateTime
        if (agentData['createdAt'] is Timestamp) {
          agentData['createdAt'] = (agentData['createdAt'] as Timestamp).toDate().toString();
        }

        print('agentData: $agentData');

        AgentModel agent = AgentModel.fromJson(agentData);
        agentsList.add(agent);
      }

      print('agentsList: $agentsList');

      return agentsList;
    } catch (e) {
      AppLog.log().e('Error while fetching agents list: $e');
      return Future.error('Error while fetching agents list');
    }
  }

  static Future<String> gpt(List<Map<String, String>> messages) async {
    try {
      final response = await http.post(
        Uri.parse('${Environments.backendServiceBaseUrl}/api/gpt4o'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({'messages': messages}),
      );
      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);
        print('Generated (GPT ): $data');

        String content = data;
        return content;
      } else {
        return Future.error('Failed to generate (GPT)');
      }
    } catch (e) {
      showToast(message: 'An error has occured', bgColor: getColor(AppColors.error));
      AppLog.log().e('Failed to generate (GPT ): $e');
      return Future.error('Failed to generate (GPT )');
    }
  }


  static Future<List<ChatModel>> getUserChats(String userId) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      AppLog.log().i('Fetching user chats');

      List<ChatModel> userChats = [];

      QuerySnapshot querySnapshot = await db.collection('chats').where('userId', isEqualTo: userId).get();
      for (var doc in querySnapshot.docs) {
        print("doc id: ${doc.id} => data: ${doc.data()}");

        Map<String, Object?> chatData = Map<String, Object?>.from(doc.data() as Map);

        chatData['uid'] = doc.id;

        // Ensure 'chatMessages' is a List
        if (chatData['chatMessages'] == null || chatData['chatMessages'] is! List) {
          chatData['chatMessages'] = [];
        }

        // Convert each message in the list to ChatMessageModel
        List<ChatMessageModel> messages = (chatData['chatMessages'] as List)
            .map((e) => ChatMessageModel.fromJson(e as Map<String, dynamic>))
            .toList();

        chatData['chatMessages'] = messages;

        print('chatData: $chatData');

        ChatModel chat = ChatModel(
          uid: chatData['uid'] as String,
          userId: chatData['userId'] as String,
          agentId: chatData['agentId'] as String,
          messages: messages,
          title: chatData['title'] as String,
        );

        userChats.add(chat);
      }

      print('userChats: $userChats');

      return userChats;
    } catch (e) {
      AppLog.log().e('Error while fetching user chats: $e');
      return Future.error('Error while fetching user chats');
    }
  }

  static Future<List<ChatMessageModel>> addMessageToChat(String chatId, ChatMessageModel newMessage) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      AppLog.log().i('Adding new message to chat $chatId');

      DocumentReference chatDocRef = db.collection('chats').doc(chatId);

      return await db.runTransaction((transaction) async {
        DocumentSnapshot snapshot = await transaction.get(chatDocRef);

        if (!snapshot.exists) {
          throw Exception("Chat does not exist!");
        }

        List<dynamic> messages = snapshot.get('chatMessages') as List<dynamic>? ?? [];

        messages.add(newMessage.toJson());

        // Prepare messages for GPT request
        List<Map<String, String>> messageContents = messages.map((msg) {
          var messageMap = msg as Map<String, dynamic>;
          return {
            'role': messageMap['role'] as String,
            'content': messageMap['content'] as String,
          };
        }).toList();

        // Send request to GPT to get the response
        String gptResponse = await gpt(messageContents);

        // Create a new ChatMessageModel for the GPT response
        ChatMessageModel gptMessage = ChatMessageModel(
          role: 'assistant',
          content: gptResponse,
        );

        // Add GPT response to messages
        messages.add(gptMessage.toJson());

        // Update Firestore with both messages
        transaction.update(chatDocRef, {'chatMessages': messages});

        // Convert dynamic list to List<ChatMessageModel>
        List<ChatMessageModel> updatedMessages = messages.map((msg) => ChatMessageModel.fromJson(msg as Map<String, dynamic>)).toList();

        return updatedMessages;
      });
    } catch (e) {
      AppLog.log().e('Error while adding message to chat: $e');
      return Future.error('Error while adding message to chat');
    }
  }


  static Future<ChatModel> createNewChat(ChatModel chat) async {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      AppLog.log().i('Creating a new chat');

      DocumentReference chatDocRef = db.collection('chats').doc();

      Map<String, dynamic> chatData = chat.toJson();
      chatData['uid'] = chatDocRef.id;

      await chatDocRef.set(chatData);

      // Fetch the created chat document to return it
      DocumentSnapshot createdChatSnapshot = await chatDocRef.get();

      ChatModel createdChat = ChatModel.fromJson(createdChatSnapshot.data() as Map<String, dynamic>);
      return createdChat;
    } catch (e) {
      AppLog.log().e('Error while creating new chat: $e');
      return Future.error('Error while creating new chat');
    }
  }

  static Future<List<AgentModel>> getMostRatedAgent(int count) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    try {
      AppLog.log().i('Fetching most rated agent');

      return db.collection('agents').orderBy('rating', descending: true).limit(count).get().then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          List<AgentModel> agents = querySnapshot.docs.map((doc) {
            Map<String, Object?> agentData = Map<String, Object?>.from(doc.data() as Map);

            agentData['uid'] = doc.id;

            // Convert Timestamp to DateTime
            if (agentData['createdAt'] is Timestamp) {
              agentData['createdAt'] = (agentData['createdAt'] as Timestamp).toDate().toString();
            }

            print('most rated agentData: $agentData');

            return AgentModel.fromJson(agentData);
          }).toList();

          return agents;

        } else {
          return Future.error('No agents found');
        }
      });
    } catch (e) {
      AppLog.log().e('Error while fetching most rated agent: $e');
      return Future.error('Error while fetching most rated agent');
    }
  }


}
