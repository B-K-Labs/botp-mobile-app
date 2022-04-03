import 'package:botp_auth/configs/themes/dark_theme.dart';
import 'package:botp_auth/configs/themes/light_theme.dart';

enum AppTheme {
  light,
  dark,
}

// Theme data maping
final mapAppThemeData = {
  AppTheme.light: lightThemeData,
  AppTheme.dark: darkThemeData,
};
