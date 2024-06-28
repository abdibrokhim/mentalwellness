import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/utils/constants.dart';
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
}
