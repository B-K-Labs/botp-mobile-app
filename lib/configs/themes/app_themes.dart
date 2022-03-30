import 'package:botp_auth/constants/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:botp_auth/constants/app_constants.dart';

// Test theme
TextTheme _appTheme = TextTheme(
  bodyText1: GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontSize: AppFontSizes.body1,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal)),
  bodyText2: GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontSize: AppFontSizes.body2,
          fontWeight: FontWeight.normal,
          fontStyle: FontStyle.normal)),
  headline4: GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontSize: AppFontSizes.headline4,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal)),
  headline5: GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontSize: AppFontSizes.headline5,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal)),
  headline6: GoogleFonts.roboto(
      textStyle: const TextStyle(
          fontSize: AppFontSizes.headline6,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.normal)),
);

// Theme data maping
final mapAppThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
    textTheme: _appTheme,
  ),
  AppTheme.dark: ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColorLight,
    textTheme: _appTheme,
  ),
};
