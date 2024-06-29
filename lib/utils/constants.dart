import 'package:flutter/material.dart';
import 'package:mentalwellness/agent/model/agent.model.dart';

String googleIcon = 'assets/Google_Icons-09-128.png';

String defaultProfileImage = 'https://iili.io/dFRrrOX.png';


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



    AgentModel defaultAgent = AgentModel(
                uid: '000000',
                name: 'Sophia Green',
                description: 'Sophia is dedicated to helping individuals build and maintain healthy relationships, fostering strong social connections, and creating a sense of community. With her guidance, users can develop the skills necessary to navigate social dynamics effectively and enhance their social well-being.', 
                imageUrl: 'https://i.pravatar.cc/300?u=sophia.green@socialwellbeing.com',
                rating: {1: 10, 2: 20, 3: 10, 4: 20, 5: 50},
                createdBy: '@abdibrokhim',
                systemPrompt: "You are a social well-being guide dedicated to supporting individuals in building and maintaining healthy relationships, social connections, and a sense of community. Your task is to support users by providing practical advice on social skills, relationship dynamics, and community engagement. Use a warm, inclusive, and encouraging tone to make the content relatable and easy to follow. Ensure user privacy and handle any personal data with care.",
                category: ['Social Well-being'],
                conversationCount: 10,
                conversationStarters: [
                    "Hi, I'm here to help you build strong and healthy relationships.",
                    "Hello! Let's talk about ways to enhance your social connections.",
                    "Hi there! How can I assist you in creating a supportive community around you?"
                ],
                skills: ["Relationship building", "Communication skills", "Community engagement"],
                createdAt: DateTime.now(),
              );


List<String> quickInfo = [
  "1. Changes (e.g., edit chat title, delete chat, etc.) might take up to 4 seconds to reflect.",
  "2. Make sure you have a stable internet connection.",
];

String email = "abdibrokhim@gmail.com";