
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/toast.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';

class SignUpService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<User?> registerOrganization(String firstName, String lastName, String email, String password) async {
    print('Registering user');

    try {
      // Register the new user
      final UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: firstName,
          id: userCredential.user!.uid,
          imageUrl: userCredential.user!.photoURL,
          lastName: lastName,
        ),
      );

      final User? user = userCredential.user;
      if (user != null) {
          AppLog.log().i('User ID: ${user.uid}');

        showToast(message: 'User registered successfully', bgColor: getColor(AppColors.success));

        return user;
      }
      else {
        showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
        return Future.error('An error occurred');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showToast(message: 'The password provided is too weak.', bgColor: getColor(AppColors.error));
        return Future.error('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        showToast(message: 'The account already exists for that email. Please, Sign In', bgColor: getColor(AppColors.error));
        return Future.error('The account already exists for that email.');
      }
      showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
      return Future.error('An error occurred');
    } catch (e) {
      showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
      return Future.error('An error occurred');
    }
  }
}
