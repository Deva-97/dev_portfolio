// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTheme {
  static final baseTextTheme = TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: 56,
      fontWeight: FontWeight.w700,
      letterSpacing: -1.5,
      height: 1.1,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: 42,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: 34,
      fontWeight: FontWeight.w600,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 22,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 1.7,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
  );

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: AppColors.flutterDarkBlue,
    scaffoldBackgroundColor: const Color(0xFFF8FAFC),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: AppColors.secondary),
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.secondary,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: baseTextTheme.apply(
      bodyColor: AppColors.lightModeText,
      displayColor: AppColors.lightModeText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.flutterDarkBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.flutterDarkBlue.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        textStyle: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.white.withOpacity(0.1);
          }
          return null;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.flutterDarkBlue,
        side: const BorderSide(color: AppColors.flutterDarkBlue, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 24),
        textStyle: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterDarkBlue.withOpacity(0.08);
          }
          return null;
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightModeHint,
        textStyle: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterDarkBlue.withOpacity(0.08);
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterDarkBlue;
          }
          return AppColors.lightModeHint;
        }),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderLight, width: 1),
      ),
    ),
    dividerColor: AppColors.borderLight,
    hintColor: AppColors.lightModeHint,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.flutterDarkBlue.withOpacity(0.4),
      cursorColor: AppColors.flutterDarkBlue,
      selectionHandleColor: AppColors.flutterDarkBlue,
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.flutterDarkBlue,
      secondary: AppColors.accent,
      surface: AppColors.surfaceLight,
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: AppColors.flutterLightBlue,
    scaffoldBackgroundColor: AppColors.darkBg,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkBg,
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    ),
    textTheme: baseTextTheme.apply(
      bodyColor: AppColors.darkModeText,
      displayColor: AppColors.darkModeText,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.flutterLightBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        shadowColor: AppColors.flutterLightBlue.withOpacity(0.4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
        textStyle: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return Colors.white.withOpacity(0.15);
          }
          return null;
        }),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.flutterLightBlue,
        side: const BorderSide(color: AppColors.flutterLightBlue, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 22),
        textStyle: GoogleFonts.poppins(
          fontSize: 17,
          fontWeight: FontWeight.w600,
        ),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterLightBlue.withOpacity(0.15);
          }
          return null;
        }),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.darkModeHint,
        textStyle: GoogleFonts.poppins(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ).copyWith(
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterLightBlue.withOpacity(0.15);
          }
          return null;
        }),
        foregroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.hovered)) {
            return AppColors.flutterLightBlue;
          }
          return AppColors.darkModeHint;
        }),
      ),
    ),
    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.darkCardBg,
      margin: const EdgeInsets.symmetric(vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.borderDark, width: 1),
      ),
    ),
    dividerColor: AppColors.borderDark,
    hintColor: AppColors.darkModeHint,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: AppColors.flutterDarkBlue.withOpacity(0.5),
      cursorColor: AppColors.flutterLightBlue,
      selectionHandleColor: AppColors.flutterLightBlue,
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.flutterLightBlue,
      secondary: AppColors.accent,
      surface: AppColors.surfaceDark,
    ),
  );
}
