import 'package:botp_auth/configs/themes/color_palette.dart';
import 'package:flutter/material.dart';

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
    outline: ColorPalette.gray400);
