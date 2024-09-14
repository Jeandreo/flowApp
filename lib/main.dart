// lib/main.dart
import 'package:dream_flow/routes/app_routes.dart';
import 'package:dream_flow/screens/auth/login.dart';

import 'theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DreamFlow',
      theme: buildThemeData(context),
      onGenerateRoute: AppRoutes.generateRoute,
      home:  const LoginScreen(),
    );
  }
}