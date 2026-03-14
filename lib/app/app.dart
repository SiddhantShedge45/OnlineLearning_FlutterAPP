import 'package:flutter/material.dart';
import '../features/auth/screens/login_screen.dart';
import '../core/theme/app_theme.dart';

class OnlineLearningApp extends StatelessWidget {
  const OnlineLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Online Learning App",
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(),
    );
  }
}