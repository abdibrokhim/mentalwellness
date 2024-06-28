import 'package:flutter/material.dart';

class AppRoutes {
  static const String init = '/';
  static const String home = '/home';
  static const String signIn = '/signIn';
  static const String signUp = '/signUp';
  static const String agentProfile = '/agentProfile';
  static const String exploreAgents = '/exploreAgents';
  static const String forgotPassword = '/forgotPassword';

  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
    };
  }
}
