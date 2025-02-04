import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color.fromARGB(255, 0, 86, 166);
  static const borderColor = Color.fromRGBO(227, 227, 227, 1);
  static const backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFFFFF), // #ffffff
      Color(0xFFA6C4E0), // #a6c4e0
      Color(0xFF79A6D0), // #79a6d0
      Color(0xFF0056A6), // #0056a6
    ],
  );

  static const secondaryColor = Color.fromRGBO(245, 245, 245, 1);
  static const mutedColor = Color.fromRGBO(245, 245, 245, 1);

  static const primaryForegroundColor = Color.fromRGBO(230, 236, 255, 1);
  static const secondaryForegroundColor = Color.fromRGBO(23, 23, 23, 1);
  static const mutedForegroundColor = Color.fromRGBO(115, 115, 115, 1);

  static ThemeData themeData = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.cairo().fontFamily, // Global Cairo font
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontSize: 18,
        color: secondaryForegroundColor,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: mutedForegroundColor,
      ),
      headlineLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      foregroundColor: primaryForegroundColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        fontSize: 16,
        color: secondaryForegroundColor,
      ),
      hintStyle: const TextStyle(
        fontSize: 14,
        color: mutedForegroundColor,
      ),
      filled: true,
      fillColor: secondaryColor,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderColor),
      ),
      contentPadding:
          const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
    ),
  );
}
