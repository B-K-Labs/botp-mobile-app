import 'package:flutter/material.dart';

// Font sizes from
// 1. https://api.flutter.dev/flutter/material/TextTheme-class.html
// 2. https://material.io/design/typography/the-type-system.html#type-scale
// @@ deprecated
// class AppFontSizes {
//   static const headline4 = 32.0;
//   static const headline5 = 25.0;
//   static const headline6 = 20.0;
//   static const body1 = 16.0;
//   static const body2 = 14.0;
// }

// Color
class AppColors {
  // Blue (main color)
  static const primaryColor = Color(0xFF034368);
  static const primaryColorLight = Color(0xFFABE0F9);
  // Red
  static const redColor = Color(0xFFD44C3D);
  static const redColorLight = Color(0xFFFACDC8);
  // Green
  static const greenColor = Color(0xFF0AB059);
  static const greenColorLight = Color(0xFFA2FACC);
  // Gray
  static const grayColor01 = Color(0xFFF6F6F6);
  static const grayColor02 = Color(0xFFE8E8E8);
  static const grayColor03 = Color(0xFFBDBDBD);
  static const grayColor04 = Color(0xFF666666);
  // Neutral
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
}

// Border radius
class AppBorderRadiusCircular {
  static const large = 8.0;
  static const medium = 6.0;
  static const small = 4.0;
}

// Safe area
const kPaddingSafeArea = 20.0;

// Shadow
const kShadowBlur = 10.0;
const kShadowSpread = 0.0;
const kShadowOffsetX = 0.0, kShadowOffsetY = 4.0;
