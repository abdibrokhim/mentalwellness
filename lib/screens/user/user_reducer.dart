import 'package:mentalwellness/agent/model/agent.model.dart';
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
]);