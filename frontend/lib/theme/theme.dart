import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme { LIGHT, DARK }

String enumName(AppTheme anyEnum) {
  return anyEnum.toString();
}

final appThemeData = {
  AppTheme.LIGHT: ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 24,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w600,
        ),
      ),
      titleMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w400,
        ),
      ),
      titleSmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w600,
        ),
      ),
      bodyLarge: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w400,
        ),
      ),
      bodyMedium: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w400,
        ),
      ),
      bodySmall: GoogleFonts.poppins(
        textStyle: const TextStyle(
          fontSize: 12,
          color: Color(0xff383F51),
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
  AppTheme.DARK: ThemeData()
};
