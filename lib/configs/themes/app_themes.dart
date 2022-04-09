import 'package:botp_auth/configs/themes/dark_theme.dart';
import 'package:botp_auth/configs/themes/light_theme.dart';
import 'package:botp_auth/constants/storage.dart';
import 'package:flutter/material.dart';

// Create color scheme: https://m3.material.io/styles/color/the-color-system/color-roles
// Theme data maping
final mapAppThemeData = {
  AppTheme.light: lightThemeData,
  AppTheme.dark: darkThemeData,
};

final colorScheme = ColorScheme.highContrastDark();
