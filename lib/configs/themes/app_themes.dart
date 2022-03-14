import 'package:botp_auth/constants/app_constants.dart';
import 'package:flutter/material.dart';

enum AppTheme {
  light,
  dark,
}

final appThemeData = {
  AppTheme.light: ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primaryColor,
  ),
};
