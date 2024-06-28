import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mentalwellness/screens/auth/components/secure_storage.dart';
import 'package:mentalwellness/screens/auth/signin/signin_screen.dart';
import 'package:mentalwellness/screens/mainlayout/main_layout_screen.dart';
import 'package:mentalwellness/store/app_store.dart';


class Bridge extends StatelessWidget {
  
  const Bridge({Key? key}) : super(key: key);

  static Future<bool> _getOrganizationId() async {
    return await StorageService.readItemsFromToKeyChain().then((value) {
      if (value['uuid'] != null) {
        return true;
      }
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isO = false;

    return StoreConnector<GlobalState, bool>(
        converter: (store) => store.state.appState.userState.isLoggedIn,
        builder: (context, isLoggedIn) {
          return (isLoggedIn || isO) ? const MainLayout() : const SignInScreen();
        }
    );
  }
}