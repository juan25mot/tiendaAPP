import 'package:flutter/material.dart';

class AppTheme {
  // Colores para tema claro
  static const Color primaryColorLight = Color(0xFF01579B);
  static const Color secondaryColorLight = Color(0xFF4FC3F7);
  static const Color accentColorLight = Color(0xFFFFB74D);
  static const Color bgColorLight = Color(0xFFF0F8FF);
  static const Color cardColorLight = Colors.white;
  static const Color textPrimaryLight = Color(0xFF1A1A1A);
  static const Color textSecondaryLight = Color(0xFF757575);

  // Colores para tema oscuro
  static const Color primaryColorDark = Color(0xFF0D47A1);
  static const Color secondaryColorDark = Color(0xFF81D4FA);
  static const Color accentColorDark = Color(0xFFFFB74D);
  static const Color bgColorDark = Color(0xFF121212);
  static const Color cardColorDark = Color(0xFF1E1E1E);
  static const Color textPrimaryDark = Colors.white;
  static const Color textSecondaryDark = Color(0xFFB0BEC5);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColorLight,
      secondary: secondaryColorLight,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: bgColorLight,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColorLight,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(
      color: cardColorLight,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorLight,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColorLight, width: 2),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textPrimaryLight),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColorDark,
      secondary: secondaryColorDark,
      brightness: Brightness.dark,
    ),
    scaffoldBackgroundColor: bgColorDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColorDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(
      color: cardColorDark,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColorDark,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: primaryColorDark, width: 2),
      ),
      filled: true,
      fillColor: Colors.grey[800],
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: textPrimaryDark),
    ),
  );
}