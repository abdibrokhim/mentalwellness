
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mentalwellness/screens/auth/components/secure_storage.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/toast.dart';

class FirebaseAuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static final GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
      }

      final User? user = _firebaseAuth.currentUser;

      if (user != null) {
        final String? email = user.email;
        final String? name = user.displayName;

        await StorageService.storeAccess(user.uid);
        AppLog.log().e('User uid: ${user.uid}');

        showToast(message: 'Successfully Signed In with Google', bgColor: colors['success']!,);
        return user;
      } else {
        showToast(message: 'Error while signing in with Google. Please try to Sign In entering username and password', bgColor: colors['error']!,);
        return Future.error('Error while signing in with google');
      }
    } catch (e) {
      showToast(message: 'Error while signing in with Google. Please try to Sign In entering username and password', bgColor: colors['error']!,);
      AppLog.log().e('Error while signing in with google: $e');
      return Future.error('Error while signing in with google');
    }
  }
}
