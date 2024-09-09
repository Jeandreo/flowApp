import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1C222A),
      primary: Colors.blue,
      secondary: Colors.green,
      inversePrimary: const Color(0xFF1C222A),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: Color.fromARGB(255, 32, 40, 50),
    useMaterial3: true,
  );
}
