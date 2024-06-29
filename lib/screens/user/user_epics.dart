import 'dart:async';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/screens/user/user_service.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


Stream<dynamic> fetchAgentsListEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is FetchAgentsListAction)
      .asyncMap((action) => UserService.fetchAgentsList())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            FetchAgentsListSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> gptEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetAnswerAction)
      .asyncMap((action) => UserService.gpt(action.messages))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetAnswerSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> getUserChatsEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetUserChatsAction)
      .asyncMap((action) => UserService.getUserChats(action.userId))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetUserChatsSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> addMessageToChatEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is AddMessageToChatAction)
      .asyncMap((action) => UserService.addMessageToChat(action.chatId, action.newMessage))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            AddMessageToChatSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> createNewChatEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is CreateNewChatAction)
      .asyncMap((action) => UserService.createNewChat(action.chat))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            CreateNewChatSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> getMostRatedAgentEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetMostRatedAgentAction)
      .asyncMap((action) => UserService.getMostRatedAgent(action.count))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetMostRatedAgentSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> getAgentByIdEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GetAgentByIdAction)
      .asyncMap((action) => UserService.getAgentById(action.agentId))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GetAgentByIdSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> deleteChatByIdEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is DeleteChatByIdAction)
      .asyncMap((action) => UserService.deleteChatById(action.chatId))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            DeleteChatByIdSuccessAction(),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> updateConversationCountEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is UpdateConversationCountAction)
      .asyncMap((action) => UserService.updateConversationCount(action.agentId))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            UpdateConversationCountSuccessAction(),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> updateRatingEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is UpdateRatingAction)
      .asyncMap((action) => UserService.updateRating(action.agentId, action.rating))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            UpdateRatingSuccessAction(),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> updateConversationTitleEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is UpdateConversationTitleAction)
      .asyncMap((action) => UserService.updateConversationTitle(action.chatId, action.title))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            UpdateConversationTitleSuccessAction(),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}

Stream<dynamic> generateTitlesEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is GenerateTitlesAction)
      .asyncMap((action) => UserService.generateTitles(action.messages))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            GenerateTitlesSuccessAction(value),
          ]))
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('an error occurred'),
          ]));
}




List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> userEffects = [
  fetchAgentsListEpic,
  gptEpic,
  getUserChatsEpic,
  addMessageToChatEpic,
  createNewChatEpic,
  getMostRatedAgentEpic,
  getAgentByIdEpic,
  deleteChatByIdEpic,
  updateConversationCountEpic,
  updateRatingEpic,
  updateConversationTitleEpic,
  generateTitlesEpic,
];

