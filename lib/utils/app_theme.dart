import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color _lightPrimary = Colors.deepPurple;
  static const Color _darkPrimary = Color(0xFF05637D);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: _lightPrimary,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: Colors.white,

    appBarTheme: const AppBarTheme(
      backgroundColor: _lightPrimary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: Colors.black87),

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.nunito(color: Colors.black, fontWeight: FontWeight.w700),
      bodyMedium: GoogleFonts.nunito(color: Colors.black87),
      labelLarge: GoogleFonts.nunito(color: Colors.black45),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: _lightPrimary,
      brightness: Brightness.light,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    primaryColor: _darkPrimary,
    scaffoldBackgroundColor: const Color(0xFF121212),
    canvasColor: const Color(0xFF1E1E1E),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    iconTheme: const IconThemeData(color: Colors.white),

    textTheme: TextTheme(
      bodyLarge: GoogleFonts.nunito(color: Colors.white, fontWeight: FontWeight.w700),
      bodyMedium: GoogleFonts.nunito(color: Colors.white70),
      labelLarge: GoogleFonts.nunito(color: Colors.white54),
    ),

    colorScheme: ColorScheme.fromSeed(
      seedColor: _darkPrimary,
      brightness: Brightness.dark,
      surface: const Color(0xFF1E1E1E),
    ),
  );
}