import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum AppTheme { LIGHT, DARK }

String enumName(AppTheme anyEnum) {
  return anyEnum.toString();
}

final appThemeData = {
  AppTheme.LIGHT: ThemeData(
    textTheme: TextTheme(
      titleLarge: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 30,
          color: Color(0xff925FBA),
          fontWeight: FontWeight.w700,
        ),
      ),
      titleMedium: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 34,
          color: Color(0xff925FBA),
          fontWeight: FontWeight.w700,
        ),
      ),
      titleSmall: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 34,
          color: Color(0xff925FBA),
          fontWeight: FontWeight.w700,
        ),
      ),
      bodyLarge: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 22,
          color: Color(0xff000000),
          fontWeight: FontWeight.w600,
        ),
      ),
      bodyMedium: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Color(0xff000000),
          fontWeight: FontWeight.w600,
        ),
      ),
      bodySmall: GoogleFonts.quicksand(
        textStyle: const TextStyle(
          fontSize: 18,
          color: Color(0xff262626),
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  ),
  AppTheme.DARK: ThemeData()
};
