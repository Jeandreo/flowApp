import 'package:flutter/material.dart';

ThemeData buildThemeData(context) {
  return ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color.fromARGB(255, 0, 0, 0),
      primary: const Color.fromARGB(255, 2, 39, 123),
      secondary: const Color.fromARGB(255, 238, 7, 161),
      inversePrimary: const Color(0xFF1C222A),
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 0, 153, 209),
    useMaterial3: true,
    fontFamily: 'Jost',
    textTheme: const TextTheme(
      titleSmall: TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.normal,
          color: Color(0xff18202b)),
      bodySmall: TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.normal,
          color: Colors.black54),
      bodyMedium: TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.normal,
          fontSize: 20,
          color: Color(0xff18202b)),
      labelSmall: TextStyle(
          fontFamily: 'Jost',
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xff7e8299)),
    ),
    // inputDecorationTheme: const InputDecorationTheme(
    //   filled: true,
    //   fillColor: Colors.white,
    //   contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(30)),
    //     borderSide: BorderSide.none,
    //   ),
    //   focusedBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.all(Radius.circular(20)),
    //     borderSide: BorderSide.none,
    //   ),
    // ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color.fromARGB(255, 236, 236, 236),
      contentPadding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide.none,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: Colors.white, // Defina a cor de fundo padrão aqui
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.amber,
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        foregroundColor: Colors.white,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Jost',
        ),
      ),
    ),
  );
}
