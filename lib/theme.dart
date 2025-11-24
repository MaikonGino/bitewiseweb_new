import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color terracotta = Color(0xFFD35400);
  static const Color coffee = Color(0xFF5D4037);
  static const Color sand = Color(0xFFFFF8E1);
  static const Color olive = Color(0xFF117A65);
  static const Color darkBg = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
}

ThemeData buildLightTheme() {
  final base = ThemeData.light();
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.terracotta,
    brightness: Brightness.light,
    primary: AppColors.coffee,
    secondary: AppColors.terracotta,
    background: AppColors.sand,
    surface: Colors.white,
    onSurface: AppColors.coffee,
  );
  return base.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.sand,
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)
        .apply(bodyColor: AppColors.coffee, displayColor: AppColors.coffee),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.sand,
        foregroundColor: AppColors.coffee,
        elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey[500]),
    ),
    chipTheme: ChipThemeData(
        backgroundColor: Colors.white,
        labelStyle: TextStyle(color: AppColors.coffee),
        side: BorderSide(color: Colors.grey.withOpacity(0.2))),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terracotta,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  );
}

ThemeData buildDarkTheme() {
  final base = ThemeData.dark();
  final colorScheme = ColorScheme.fromSeed(
    seedColor: AppColors.terracotta,
    brightness: Brightness.dark,
    primary: AppColors.terracotta,
    secondary: AppColors.sand,
    background: AppColors.darkBg,
    surface: AppColors.darkSurface,
    onSurface: Colors.white,
  );
  return base.copyWith(
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.darkBg,
    textTheme: GoogleFonts.poppinsTextTheme(base.textTheme)
        .apply(bodyColor: Colors.white, displayColor: Colors.white),
    appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkBg,
        foregroundColor: Colors.white,
        elevation: 0),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      hintStyle: TextStyle(color: Colors.grey[400]),
      labelStyle: const TextStyle(color: Colors.white),
    ),
    chipTheme: ChipThemeData(
        backgroundColor: AppColors.darkSurface,
        labelStyle: const TextStyle(color: Colors.white),
        side: BorderSide.none),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.terracotta,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
    ),
  );
}
