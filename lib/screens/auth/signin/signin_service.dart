
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mentalwellness/screens/auth/components/secure_storage.dart';
import 'package:mentalwellness/store/app_logs.dart';
import 'package:mentalwellness/utils/constants.dart';
import 'package:mentalwellness/utils/toast.dart';

class SignInService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<User> signIn(String email, String password) async {
    print('Signing in');

    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        await _addUserId(user.uid);
        await _getUserId().then((value) {
          AppLog.log().i('User ID: $value');
        });
        showToast(message: 'Signed in successfully', bgColor: getColor(AppColors.success));
        return user;
      } else {
        showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
        return Future.error('An error occurred');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showToast(message: 'No user found for that email.', bgColor: getColor(AppColors.error));
        return Future.error('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showToast(message: 'Wrong password provided for that user.', bgColor: getColor(AppColors.error));
        return Future.error('Wrong password provided for that user.');
      }
      showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
      return Future.error('An error occurred');
    } catch (e) {
      showToast(message: 'An error has occurred', bgColor: getColor(AppColors.error));
      return Future.error('An error occurred');
    }
  }

  static Future<void> signOut() async {
    print('Signing out');

    showToast(message: 'Signed out successfully', bgColor: getColor(AppColors.success));

    await _firebaseAuth.signOut();
  }

  static Future<void> _addUserId(String uuid) async {
    await StorageService.addNewItemToKeyChain('uuid', uuid);
  }

  static Future<String?> _getUserId() async {
    return await StorageService.readItemsFromToKeyChain().then((value) {
      return value['uuid'];
    });
  }
}
