import 'dart:isolate';

import 'package:mentalwellness/agent/model/agent.model.dart';
import 'package:mentalwellness/screens/chat/model/chat.model.dart';
import 'package:mentalwellness/screens/user/model/user.model.dart';
import 'package:redux/redux.dart';
import 'package:firebase_auth/firebase_auth.dart';



class UserState {
  final bool isLoading;
  final bool isLoggedIn;
  final bool isSignedUp;
  final String? accessToken;
  final String? refreshToken;
  final String message;
  final List<String?> errors;
  final User? user;
  final List<AgentModel> agentsList;
  final bool isFetchingAgentsList;
  final bool isGettingAnswer;
  final List<ChatMessageModel> messages;
  final String answer;
  final String selectedAgentId;
  final bool isFetchingUserChats;
  final List<ChatModel> userChats;
  final bool isAddingMessageToChat;
  final ChatModel? currentChat;
  final bool isCreatingNewChat;
  final List<AgentModel> mostRatedAgents;
  final bool isFetchingMostRatedAgents;
  final bool isFetchingAgentById;
  final AgentModel? currentAgent;
  final bool isDeletingChatById;
  final bool isUpdatingChatTitle;
  final List<String> genTitles;
  final bool isGeneratingTitles;
  final UserMetaInfo? userMetaInfo;
  final bool isFetchingUserMetaInfo;

  UserState({
    this.isLoading = false,
    this.isLoggedIn = false,
    this.isSignedUp = false,
    this.accessToken = '',
    this.refreshToken = '',
    this.message = '',
    this.errors = const [],
    this.user,
    this.agentsList = const [],
    this.isFetchingAgentsList = false,
    this.isGettingAnswer = false,
    this.messages = const [],
    this.answer = '',
    this.selectedAgentId = '',
    this.isFetchingUserChats = false,
    this.userChats = const [],
    this.isAddingMessageToChat = false,
    this.currentChat,
    this.isCreatingNewChat = false,
    this.mostRatedAgents = const [],
    this.isFetchingMostRatedAgents = false,
    this.isFetchingAgentById = false,
    this.currentAgent,
    this.isDeletingChatById = false,
    this.isUpdatingChatTitle = false,
    this.genTitles = const [],
    this.isGeneratingTitles = false,
    this.userMetaInfo,
    this.isFetchingUserMetaInfo = false,
  });

  UserState copyWith({
    bool? isLoading,
    bool? isLoggedIn,
    bool? isSignedUp,
    String? accessToken,
    String? refreshToken,
    String? message,
    List<String?>? errors,
    User? user,
    List<AgentModel>? agentsList,
    bool? isFetchingAgentsList,
    bool? isGettingAnswer,
    List<ChatMessageModel>? messages,
    String? answer,
    String? selectedAgentId,
    bool? isFetchingUserChats,
    List<ChatModel>? userChats,
    bool? isAddingMessageToChat,
    ChatModel? currentChat,
    bool? isCreatingNewChat,
    List<AgentModel>? mostRatedAgents,
    bool? isFetchingMostRatedAgents,
    bool? isFetchingAgentById,
    AgentModel? currentAgent,
    bool? isDeletingChatById,
    bool? isUpdatingChatTitle,
    List<String>? genTitles,
    bool? isGeneratingTitles,
    UserMetaInfo? userMetaInfo,
    bool? isFetchingUserMetaInfo,
  }) {
    return UserState(
      isLoading: isLoading ?? this.isLoading,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isSignedUp: isSignedUp ?? this.isSignedUp,
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      message: message ?? this.message,
      errors: errors ?? this.errors,
      user: user ?? this.user,
      agentsList: agentsList ?? this.agentsList,
      isFetchingAgentsList: isFetchingAgentsList ?? this.isFetchingAgentsList,
      isGettingAnswer: isGettingAnswer ?? this.isGettingAnswer,
      messages: messages ?? this.messages,
      answer: answer ?? this.answer,
      selectedAgentId: selectedAgentId ?? this.selectedAgentId,
      isFetchingUserChats: isFetchingUserChats ?? this.isFetchingUserChats,
      userChats: userChats ?? this.userChats,
      isAddingMessageToChat: isAddingMessageToChat ?? this.isAddingMessageToChat,
      currentChat: currentChat ?? this.currentChat,
      isCreatingNewChat: isCreatingNewChat ?? this.isCreatingNewChat,
      mostRatedAgents: mostRatedAgents ?? this.mostRatedAgents,
      isFetchingMostRatedAgents: isFetchingMostRatedAgents ?? this.isFetchingMostRatedAgents,
      isFetchingAgentById: isFetchingAgentById ?? this.isFetchingAgentById,
      currentAgent: currentAgent ?? this.currentAgent,
      isDeletingChatById: isDeletingChatById ?? this.isDeletingChatById,
      isUpdatingChatTitle: isUpdatingChatTitle ?? this.isUpdatingChatTitle,
      genTitles: genTitles ?? this.genTitles,
      isGeneratingTitles: isGeneratingTitles ?? this.isGeneratingTitles,
      userMetaInfo: userMetaInfo ?? this.userMetaInfo,
      isFetchingUserMetaInfo: isFetchingUserMetaInfo ?? this.isFetchingUserMetaInfo,
    );
  }
}


// ========== SignInWithGoogle reducers ========== //


class SignInWithGoogle {
  SignInWithGoogle();
}

UserState signInWithGoogleReducer(UserState state, SignInWithGoogle action) {
  return state.copyWith(isLoading: true);
}

class SignInWithGoogleSuccessAction {
  final User user;

  SignInWithGoogleSuccessAction(
    this.user,
  );
}

UserState signInWithGoogleSuccessReducer(UserState state, SignInWithGoogleSuccessAction action) {
  return state.copyWith(
    isLoading: false,
    isLoggedIn: true,
    user: action.user,
  );
}


// ========== SignUp reducers ========== //

class SignUpAction {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  SignUpAction(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );
}

UserState signUpReducer(UserState state, SignUpAction action) {
  return state.copyWith(isLoading: true);
}

class SignUpResponseAction {
  final User? user;
  
  SignUpResponseAction(this.user);
}

UserState signUpSuccessReducer(
  UserState state,
  SignUpResponseAction action,
) {
  return state.copyWith(
    isLoading: false,
    isSignedUp: true,
    user: action.user,
  );
}


// ========== Login reducers ========== //

class LoginAction {
  String email;
  String password;

  LoginAction(
    this.email,
    this.password,
  );
}


UserState loginReducer(UserState state, LoginAction action) {
  return state.copyWith(isLoading: true);
}

class LoginSuccessAction {
  final User? user;

  LoginSuccessAction(
    this.user,
  );
}

UserState loginSuccessReducer(UserState state, LoginSuccessAction action) {
  return state.copyWith(
    isLoggedIn: true, 
    isLoading: false,
    user: action.user,
  );
}


// ========== SignOut reducers ========== //

class SignOutAction {
  SignOutAction();
}

UserState signOutReducer(UserState state, SignOutAction action) {
  return state.copyWith(isLoading: true);
}

class SignOutResponseAction {
  SignOutResponseAction();
}

UserState signOutResponseReducer(UserState state, SignOutResponseAction action) {
  return state.copyWith(
    isLoading: false,
    isLoggedIn: false,
  );
}


// fetch agents list
class FetchAgentsListAction {
  FetchAgentsListAction();
}

UserState fetchAgentsListReducer(UserState state, FetchAgentsListAction action) {
  return state.copyWith(isFetchingAgentsList: true);
}

class FetchAgentsListSuccessAction {
  final List<AgentModel> agentsList;

  FetchAgentsListSuccessAction(this.agentsList);
}

UserState fetchAgentsListSuccessReducer(UserState state, FetchAgentsListSuccessAction action) {
  return state.copyWith(
    isFetchingAgentsList: false,
    agentsList: action.agentsList,
  );
}


// ========== GetAnswerAction ========== //

class GetAnswerAction {
  final List<String> messages;

  GetAnswerAction(this.messages);
}

UserState getAnswerReducer(UserState state, GetAnswerAction action) {
  return state.copyWith(isGettingAnswer: true);
}

// ========== GetAnswerSuccessAction ========== //

class GetAnswerSuccessAction {
  final String content;

  GetAnswerSuccessAction(this.content);
}

UserState getAnswerSuccessReducer(UserState state, GetAnswerSuccessAction action) {
  return state.copyWith(
    isGettingAnswer: false,
    answer: action.content,
  );
}


// select agent
class SelectAgentAction {
  final String agentId;

  SelectAgentAction(this.agentId);
}

UserState selectAgentReducer(UserState state, SelectAgentAction action) {
  return state.copyWith(
    selectedAgentId: action.agentId,
  );
}

// GetUserChatsAction
// GetUserChatsSuccessAction

// get user chats
class GetUserChatsAction {
  final String userId;

  GetUserChatsAction(this.userId);
}

UserState getUserChatsReducer(UserState state, GetUserChatsAction action) {
  return state.copyWith(isFetchingUserChats: true);
}

class GetUserChatsSuccessAction {
  final List<ChatModel> userChats;

  GetUserChatsSuccessAction(this.userChats);
}

UserState getUserChatsSuccessReducer(UserState state, GetUserChatsSuccessAction action) {
  return state.copyWith(
    isFetchingUserChats: false,
    userChats: action.userChats,
  );
}

// add new message to the chat


class AddMessageToChatAction {
  final String chatId;
  final ChatMessageModel newMessage;

  AddMessageToChatAction(this.chatId, this.newMessage);
}

UserState addMessageToChatReducer(UserState state, AddMessageToChatAction action) {
  return state.copyWith(isAddingMessageToChat: true, currentChat: state.currentChat!.copyWith(messages: [...state.currentChat!.messages, action.newMessage]));
}

class AddMessageToChatSuccessAction {
  final List<ChatMessageModel> messages;

  AddMessageToChatSuccessAction(this.messages);
}

UserState addMessageToChatSuccessReducer(UserState state, AddMessageToChatSuccessAction action) {
  return state.copyWith(
    isAddingMessageToChat: false,
    currentChat: state.currentChat!.copyWith(messages: action.messages),
  );
}



class OnSelectChatAction {
  final ChatModel chat;

  OnSelectChatAction(this.chat);
}

UserState onSelectChatReducer(UserState state, OnSelectChatAction action) {
  return state.copyWith(
    currentChat: action.chat,
  );
}

// create new chat
// CreateNewChatAction
// CreateNewChatSuccessAction


class CreateNewChatAction {
  final ChatModel chat;

  CreateNewChatAction(this.chat);
}

UserState createNewChatReducer(UserState state, CreateNewChatAction action) {
  return state.copyWith(isCreatingNewChat: true);
}

class CreateNewChatSuccessAction {
  final ChatModel chat;

  CreateNewChatSuccessAction(this.chat);
}

UserState createNewChatSuccessReducer(UserState state, CreateNewChatSuccessAction action) {
  return state.copyWith(
    isCreatingNewChat: false,
    currentChat: action.chat,
  );
}

// get most rated agent
// GetMostRatedAgentAction
// GetMostRatedAgentSuccessAction

class GetMostRatedAgentAction {
  final int count;

  GetMostRatedAgentAction(this.count);
}

UserState getMostRatedAgentReducer(UserState state, GetMostRatedAgentAction action) {
  // print('getMostRatedAgentReducer');
  return state.copyWith(isFetchingMostRatedAgents: true);
}

class GetMostRatedAgentSuccessAction {
  final List<AgentModel> agents;

  GetMostRatedAgentSuccessAction(this.agents);
}

UserState getMostRatedAgentSuccessReducer(UserState state, GetMostRatedAgentSuccessAction action) {
  return state.copyWith(
    isFetchingMostRatedAgents: false,
    mostRatedAgents: action.agents,
  );
}

// GetAgentByIdAction
// GetAgentByIdSuccessAction

class GetAgentByIdAction {
  final String agentId;

  GetAgentByIdAction(this.agentId);
}

UserState getAgentByIdReducer(UserState state, GetAgentByIdAction action) {
  return state.copyWith(isFetchingAgentById: true);
}

class GetAgentByIdSuccessAction {
  final AgentModel agent;

  GetAgentByIdSuccessAction(this.agent);
}

UserState getAgentByIdSuccessReducer(UserState state, GetAgentByIdSuccessAction action) {
  return state.copyWith(
    isFetchingAgentById: false,
    currentAgent: action.agent,
  );
}


// delete chat by id
// DeleteChatByIdAction
// DeleteChatByIdSuccessAction

class DeleteChatByIdAction {
  final String chatId;

  DeleteChatByIdAction(this.chatId);
}

UserState deleteChatByIdReducer(UserState state, DeleteChatByIdAction action) {
  return state.copyWith(isDeletingChatById: true);
}

class DeleteChatByIdSuccessAction {
  DeleteChatByIdSuccessAction();
}

UserState deleteChatByIdSuccessReducer(UserState state, DeleteChatByIdSuccessAction action) {
  return state.copyWith(
    isDeletingChatById: false,
  );
}

// UpdateConversationCountAction
// UpdateConversationCountSuccessAction

class UpdateConversationCountAction {
  final String agentId;

  UpdateConversationCountAction(this.agentId);
}

UserState updateConversationCountReducer(UserState state, UpdateConversationCountAction action) {
  return state.copyWith();
}

class UpdateConversationCountSuccessAction {
  UpdateConversationCountSuccessAction();
}

UserState updateConversationCountSuccessReducer(UserState state, UpdateConversationCountSuccessAction action) {
  return state.copyWith();
}


// UpdateRatingAction
// UpdateRatingSuccessAction

class UpdateRatingAction {
  final String agentId;
  final Map<int, int> rating;

  UpdateRatingAction(this.agentId, this.rating);
}

UserState updateRatingReducer(UserState state, UpdateRatingAction action) {
  return state.copyWith();
}

class UpdateRatingSuccessAction {
  UpdateRatingSuccessAction();
}

UserState updateRatingSuccessReducer(UserState state, UpdateRatingSuccessAction action) {
  return state.copyWith();
}

// UpdateConversationTitleAction
// UpdateConversationTitleSuccessAction

class UpdateConversationTitleAction {
  final String chatId;
  final String title;

  UpdateConversationTitleAction(this.chatId, this.title);
}

UserState updateConversationTitleReducer(UserState state, UpdateConversationTitleAction action) {
  return state.copyWith(isUpdatingChatTitle: true);
}

class UpdateConversationTitleSuccessAction {
  UpdateConversationTitleSuccessAction();
}

UserState updateConversationTitleSuccessReducer(UserState state, UpdateConversationTitleSuccessAction action) {
  return state.copyWith(isUpdatingChatTitle: false);
}

// GenerateTitlesAction
// GenerateTitlesSuccessAction

class GenerateTitlesAction {
  final List<ChatMessageModel> messages;

  GenerateTitlesAction(this.messages);
}

UserState generateTitlesReducer(UserState state, GenerateTitlesAction action) {
  return state.copyWith(isGeneratingTitles: true);
}

class GenerateTitlesSuccessAction {
  final List<String> titles;

  GenerateTitlesSuccessAction(this.titles);
}

UserState generateTitlesSuccessReducer(UserState state, GenerateTitlesSuccessAction action) {
  return state.copyWith(
    isGeneratingTitles: false,
    genTitles: action.titles,
  );
}

class GetUserMetaInfoAction {
  final String userId;
  
  GetUserMetaInfoAction(this.userId);
}

UserState getUserMetaInfoReducer(UserState state, GetUserMetaInfoAction action) {
  return state.copyWith(isFetchingUserMetaInfo: true);
}

class GetUserMetaInfoSuccessAction {
  final UserMetaInfo userMetaInfo;
  
  GetUserMetaInfoSuccessAction(this.userMetaInfo);
}

UserState getUserMetaInfoSuccessReducer(UserState state, GetUserMetaInfoSuccessAction action) {
  return state.copyWith(
    isFetchingUserMetaInfo: false,
    userMetaInfo: action.userMetaInfo,
  );
}


// ========== simulations ========== //



// ========== Handle Generic Error ========== //

class HandleGenericErrorAction {
  final String errorMessage;
  
  HandleGenericErrorAction(this.errorMessage);
}

UserState handleGenericErrorReducer(
    UserState state, HandleGenericErrorAction action) {
  return state.copyWith(
    isLoading: false,
    errors: [...state.errors, action.errorMessage],
  );
}

// ========== Clear Generic Error ========== //

class ClearGenericErrorAction {
  ClearGenericErrorAction();
}

UserState clearGenericErrorReducer(
    UserState state, ClearGenericErrorAction action) {
  return state.copyWith(
    errors: [],
  );
}


// ========== Combine all reducers ========== //

Reducer<UserState> userReducer = combineReducers<UserState>([
  TypedReducer<UserState, SignInWithGoogle>(signInWithGoogleReducer),
  TypedReducer<UserState, SignInWithGoogleSuccessAction>(signInWithGoogleSuccessReducer),
  TypedReducer<UserState, SignOutAction>(signOutReducer),
  TypedReducer<UserState, SignOutResponseAction>(signOutResponseReducer),
  TypedReducer<UserState, SignUpAction>(signUpReducer),
  TypedReducer<UserState, SignUpResponseAction>(signUpSuccessReducer),
  TypedReducer<UserState, LoginAction>(loginReducer),
  TypedReducer<UserState, LoginSuccessAction>(loginSuccessReducer),
  TypedReducer<UserState, HandleGenericErrorAction>(handleGenericErrorReducer),
  TypedReducer<UserState, ClearGenericErrorAction>(clearGenericErrorReducer),
  TypedReducer<UserState, FetchAgentsListAction>(fetchAgentsListReducer),
  TypedReducer<UserState, FetchAgentsListSuccessAction>(fetchAgentsListSuccessReducer),
  TypedReducer<UserState, GetAnswerAction>(getAnswerReducer),
  TypedReducer<UserState, GetAnswerSuccessAction>(getAnswerSuccessReducer),
  TypedReducer<UserState, SelectAgentAction>(selectAgentReducer),
  TypedReducer<UserState, GetUserChatsAction>(getUserChatsReducer),
  TypedReducer<UserState, GetUserChatsSuccessAction>(getUserChatsSuccessReducer),
  TypedReducer<UserState, AddMessageToChatAction>(addMessageToChatReducer),
  TypedReducer<UserState, AddMessageToChatSuccessAction>(addMessageToChatSuccessReducer),
  TypedReducer<UserState, OnSelectChatAction>(onSelectChatReducer),
  TypedReducer<UserState, CreateNewChatAction>(createNewChatReducer),
  TypedReducer<UserState, CreateNewChatSuccessAction>(createNewChatSuccessReducer),
  TypedReducer<UserState, GetMostRatedAgentAction>(getMostRatedAgentReducer),
  TypedReducer<UserState, GetMostRatedAgentSuccessAction>(getMostRatedAgentSuccessReducer),
  TypedReducer<UserState, GetAgentByIdAction>(getAgentByIdReducer),
  TypedReducer<UserState, GetAgentByIdSuccessAction>(getAgentByIdSuccessReducer),
  TypedReducer<UserState, DeleteChatByIdAction>(deleteChatByIdReducer),
  TypedReducer<UserState, DeleteChatByIdSuccessAction>(deleteChatByIdSuccessReducer),
  TypedReducer<UserState, UpdateConversationCountAction>(updateConversationCountReducer),
  TypedReducer<UserState, UpdateConversationCountSuccessAction>(updateConversationCountSuccessReducer),
  TypedReducer<UserState, UpdateRatingAction>(updateRatingReducer),
  TypedReducer<UserState, UpdateRatingSuccessAction>(updateRatingSuccessReducer),
  TypedReducer<UserState, UpdateConversationTitleAction>(updateConversationTitleReducer),
  TypedReducer<UserState, UpdateConversationTitleSuccessAction>(updateConversationTitleSuccessReducer),
  TypedReducer<UserState, GenerateTitlesAction>(generateTitlesReducer),
  TypedReducer<UserState, GenerateTitlesSuccessAction>(generateTitlesSuccessReducer),
  TypedReducer<UserState, GetUserMetaInfoAction>(getUserMetaInfoReducer),
  TypedReducer<UserState, GetUserMetaInfoSuccessAction>(getUserMetaInfoSuccessReducer),

]);