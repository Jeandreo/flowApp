// lib/main.dart
import 'package:dream_flow/screens/auth/auth.dart';
import 'package:dream_flow/screens/financial/dashboard.dart';

import 'theme/app_theme.dart';
import 'screens/catalogs/catalogs.dart';
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
      theme: buildThemeData(),
      home:  const LoginScreen(),
    );
  }
}