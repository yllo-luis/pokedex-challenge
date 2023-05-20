import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xFFDC0A2D),
    snackBarTheme: const SnackBarThemeData(
      closeIconColor: Colors.white,
      showCloseIcon: true,
      backgroundColor: Color(0xFFDC0A2D)
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 24,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 10,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 12,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 14,
      ),
    ),
  );
}