import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApodTheme {
  // 1
  static TextTheme lightTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
        fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
    displayLarge: GoogleFonts.openSans(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    displayMedium: GoogleFonts.openSans(
        fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.black),
    displaySmall: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
  );

  // 2
  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(
        fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    displayLarge: GoogleFonts.openSans(
        fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.openSans(
        fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.white),
    displaySmall: GoogleFonts.openSans(
        fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
  );

  // 3
  static light() {
    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
        brightness: Brightness.light,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        selectionColor: Colors.green,
      ),
      textTheme: lightTextTheme,
    );
  }

  // 4
  static dark() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.purple,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.purple[300],
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: Colors.purple,
        secondary: Colors.purpleAccent,
        brightness: Brightness.dark,
      ),
      textTheme: darkTextTheme,
    );
  }
}
