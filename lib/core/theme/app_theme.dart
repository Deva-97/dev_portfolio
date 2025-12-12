import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final baseTextTheme = TextTheme(
    displayLarge: GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.bold),
    headlineMedium:
        GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w700),
    titleLarge: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: GoogleFonts.inter(fontSize: 16),
    bodyMedium: GoogleFonts.inter(fontSize: 14, color: AppColors.muted),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: baseTextTheme.apply(bodyColor: Colors.black87),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerColor: Colors.grey.shade200,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: const Color(0xFF0B1020),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0B1020),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: baseTextTheme.apply(bodyColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 2,
      color: const Color(0xFF0F1724),
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    dividerColor: Colors.grey.shade800,
  );
}
