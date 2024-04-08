// Text theme
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Text theme
// https://material.io/design/typography/the-type-system.html#type-scale
// https://api.flutter.dev/flutter/material/TextTheme-class.html
final textTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
      fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  displayMedium: GoogleFonts.roboto(
      fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  displaySmall: GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
  // headline4: GoogleFonts.roboto(
  //     fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  // headline5: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
  // headline6: GoogleFonts.roboto(
  //     fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  headlineMedium: GoogleFonts.roboto(
      fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: 0.25),
  headlineSmall: GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w700),
  titleLarge: GoogleFonts.roboto(
      fontSize: 20, fontWeight: FontWeight.w700, letterSpacing: 0.15),
  titleMedium: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w700, letterSpacing: 0.15),
  titleSmall: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyLarge: GoogleFonts.roboto(
      fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyMedium: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  labelLarge: GoogleFonts.roboto(
      fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  bodySmall: GoogleFonts.roboto(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  labelSmall: GoogleFonts.roboto(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);
