import 'dart:async';
import 'package:mentalwellness/screens/auth/firebase_auth_service.dart';
import 'package:mentalwellness/screens/auth/signin/signin_service.dart';
import 'package:mentalwellness/screens/auth/signup/signup_service.dart';
import 'package:mentalwellness/screens/user/user_reducer.dart';
import 'package:mentalwellness/store/app_store.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';


Stream<dynamic> googleAuthEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is SignInWithGoogle) 
      .asyncMap((action) => FirebaseAuthService.signInWithGoogle())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            SignInWithGoogleSuccessAction(value),
          ]),)
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('Error while signing in with google'),
          ]),);
}

Stream<dynamic> signInWithEmailEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is LoginAction)
      .asyncMap((action) => SignInService.signIn(action.email, action.password))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            LoginSuccessAction(value),
          ]),)
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('Error while signing in with email'),
          ]),);
}

Stream<dynamic> signUpWithEmailEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is SignUpAction)
      .asyncMap((action) => SignUpService.registerOrganization(action.firstName, action.lastName, action.email, action.password))
      .flatMap<dynamic>((value) => Stream.fromIterable([
            SignUpResponseAction(value),
          ]),)
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('Error while signing up with email'),
          ]),);
}


Stream<dynamic> signOutEpic(Stream<dynamic> actions, EpicStore<GlobalState> store) {
  return actions
      .where((action) => action is SignOutAction)
      .asyncMap((action) => SignInService.signOut())
      .flatMap<dynamic>((value) => Stream.fromIterable([
            SignOutResponseAction(),
          ]),)
      .onErrorResume((error, stackTrace) => Stream.fromIterable([
            HandleGenericErrorAction('Error while signing out'),
          ]),);
}



List<Stream<dynamic> Function(Stream<dynamic>, EpicStore<GlobalState>)> authEffects = [
  googleAuthEpic,
  signInWithEmailEpic,
  signUpWithEmailEpic,
  signOutEpic,
];
