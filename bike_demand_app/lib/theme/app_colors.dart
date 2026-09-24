import 'package:flutter/material.dart';
class AppColors {
  // Primary blue — used for buttons, active elements, accents
  static const Color primary = Color(0xFF2E5BFF);
  static const Color primaryDark = Color(0xFF1B3FCF);

  // Backgrounds
  static const Color background = Color(0xFFF7F8FC);
  static const Color cardBackground = Colors.white;

  // Text
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF8A8A9E);

  // Status / feedback colors (useful for demand levels later)
  static const Color success = Color(0xFF2ECC71); // high demand
  static const Color warning = Color(0xFFF5A623); // medium demand
  static const Color danger = Color(0xFFE74C3C); // low demand

  // Shadow used on cards
  static BoxShadow cardShadow = BoxShadow(
    color: Colors.black.withOpacity(0.06),
    blurRadius: 20,
    offset: const Offset(0, 8),
  );
}

/// App-wide theme, plugged into MaterialApp in main.dart
final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.background,
  primaryColor: AppColors.primary,
  fontFamily: 'Poppins', // optional — remove if you don't add the font
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
      minimumSize: const Size(double.infinity, 56),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      elevation: 0,
    ),
  ),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
      color: AppColors.textDark,
    ),
    bodyMedium: TextStyle(
      fontSize: 15,
      color: AppColors.textGrey,
    ),
  ),
);