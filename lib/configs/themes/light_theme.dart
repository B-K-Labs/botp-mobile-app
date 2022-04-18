import 'package:botp_auth/configs/themes/text_theme.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:flutter/material.dart';

final lightThemeData =
    ThemeData(textTheme: textTheme, colorScheme: lightColorSchemes);

const lightColorSchemes = ColorScheme(
    brightness: Brightness.light,
    // Primary
    primary: ColorPalette.blue600,
    onPrimary: ColorPalette.white,
    primaryContainer: ColorPalette.blue100,
    onPrimaryContainer: ColorPalette.blue900,
    // Secondary
    secondary: ColorPalette.green600,
    onSecondary: ColorPalette.white,
    secondaryContainer: ColorPalette.green100,
    onSecondaryContainer: ColorPalette.green900,
    // Tertiary
    tertiary: ColorPalette.yellow600,
    onTertiary: ColorPalette.white,
    tertiaryContainer: ColorPalette.yellow100,
    onTertiaryContainer: ColorPalette.yellow900,
    // Error
    error: ColorPalette.red600,
    onError: ColorPalette.white,
    errorContainer: ColorPalette.red100,
    onErrorContainer: ColorPalette.red900,
    // Neutral & neutral variant
    background: ColorPalette.gray10,
    onBackground: ColorPalette.gray900,
    surface: ColorPalette.gray10,
    onSurface: ColorPalette.gray900,
    surfaceVariant: ColorPalette.gray100,
    onSurfaceVariant: ColorPalette.gray700,
    outline: ColorPalette.gray500);
