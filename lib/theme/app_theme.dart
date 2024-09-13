import 'package:flutter/material.dart';

ThemeData buildThemeData() {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 10, 12, 15),
      primary: Colors.blue,
      secondary: Colors.green,
      inversePrimary: const Color(0xFF1C222A),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      brightness: Brightness.light,
    ),
    cardTheme: CardTheme(
      elevation: 5,  // Ajuste a elevação
      shadowColor: Colors.black.withOpacity(0.1),  // Cor da sombra
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),  // Borda arredondada
      ),
    ),

    scaffoldBackgroundColor: const Color.fromARGB(255, 32, 40, 50),
    useMaterial3: true,
    fontFamily: 'Jost',
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontFamily: 'Jost',
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Jost',
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Jost',
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Jost',
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Jost',
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
