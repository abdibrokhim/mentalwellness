import 'package:flutter/material.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';

String googleIcon = 'assets/Google_Icons-09-128.png';

String defaultProfileImage = 'https://cdn4.iconfinder.com/data/icons/glyphs/24/icons_user-128.png';


enum AppColors {
  primary,
  secondary,
  accent,
  error,
  warning,
  info,
  success,
}

Map<String, Color?> colors = {
  'primary': const Color(0xFF3F51B5),
  'secondary': const Color(0xFF303F9F),
  'accent': const Color(0xFFFFC107),
  'error': Colors.red[900],
  'warning': const Color(0xFFFFA000),
  'info': const Color(0xFF1976D2),
  'success': Colors.green[900],
};


Color getColor(AppColors color) {
  switch (color) {
    case AppColors.primary:
      return colors['primary']!;
    case AppColors.secondary:
      return colors['secondary']!;
    case AppColors.accent:
      return colors['accent']!;
    case AppColors.error:
      return colors['error']!;
    case AppColors.warning:
      return colors['warning']!;
    case AppColors.info:
      return colors['info']!;
    case AppColors.success:
      return colors['success']!;
  }
}



// Colors

Color primaryBgColor = Color(0x313338);
Color secondaryBgColor = Color(0x404249);
Color accentBgColor = Color.fromARGB(255, 23, 24, 28);
Color primaryInputFieldTextColor = Color(0x000000);
Color secondaryInputFieldTextColor = Color(0xDDDDDD);
Color inputFieldColor = Color(0xC3C3C3);
Color errorInputFieldColor = Color(0xFFFFCBCB);
Color mentionInputFieldColor = Color(0xFFFFEDCB);
Color infoInputFieldColor = Color(0xFFCBF3FF);
Color grayColor = Color(0xFFDDDDDD);



    final AgentModel universalAgent = AgentModel(
                uid: '1',
                name: 'John Doe',
                description: 'A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent A very good agent', 
                imageUrl: 'https://i.pravatar.cc/300?u=brooks.white@armstrong.biz',
                rating: {1: 10, 2: 20, 3: 10, 4: 20, 5: 50},
                createdBy: 'admin',
                systemPrompt: "You are an emotional well-being guide dedicated to supporting individuals in managing their emotions, coping with stress, and developing emotional resilience. Your task is to support users and answer their questions about a holistic approach to emotional well-being, emphasizing practical strategies and daily habits. Use a warm, empathetic, and encouraging tone to make the content relatable and easy to follow. Remember to prioritize the privacy of users, ensuring that any personal data or specific scenarios are anonymized and handled with care.",
                category: ['category1'],
                conversationCount: 10,
                conversationStarters: ['Hello A very good agent', 'Hi A very good agent A very good agent A very good agent', 'A very good agent A very good agent A very good agent'],
                skills: ['skill1', 'skill2'],
                createdAt: DateTime.now(),
              );