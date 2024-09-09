import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screens/financial/dashboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: buildThemeData(),
      home: const Dashboard(),
    );
  }
}
