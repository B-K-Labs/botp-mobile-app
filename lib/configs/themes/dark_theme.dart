import 'package:botp_auth/configs/themes/text_theme.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:flutter/material.dart';

final darkThemeData = ThemeData(
  textTheme: textTheme,
  colorScheme: darkColorScheme,
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  // Primary
  primary: ColorPalette.blue200,
  onPrimary: ColorPalette.blue800,
  primaryContainer: ColorPalette.blue700,
  onPrimaryContainer: ColorPalette.blue100,
  // Secondary
  secondary: ColorPalette.green200,
  onSecondary: ColorPalette.green800,
  secondaryContainer: ColorPalette.green700,
  onSecondaryContainer: ColorPalette.green100,
  // Tertiary
  tertiary: ColorPalette.yellow200,
  onTertiary: ColorPalette.yellow800,
  tertiaryContainer: ColorPalette.yellow700,
  onTertiaryContainer: ColorPalette.yellow100,
  // Error
  error: ColorPalette.red200,
  onError: ColorPalette.red800,
  errorContainer: ColorPalette.red700,
  onErrorContainer: ColorPalette.red100,
  // Neutral & neutral variant
  background: ColorPalette.gray900,
  onBackground: ColorPalette.gray100,
  surface: ColorPalette.gray900,
  onSurface: ColorPalette.gray100,
  surfaceVariant: ColorPalette.gray700,
  onSurfaceVariant: ColorPalette.gray200,
  outline: ColorPalette.gray400,
);
