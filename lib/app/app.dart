import 'package:flutter/material.dart';
import 'package:online_learning_app/features/auth/screens/login_screen.dart';

class OnlineLearningApp extends StatelessWidget {
  const OnlineLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(), // ✅ START FROM LOGIN
    );
  }
}