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

enum ButtonType {
  primary,
  primaryOutlined,
  secondary,
  secondaryOutlined,
  error,
  errorOutlined,
  disabled,
}

class ColorPalette {
  // 1. Docs
  // Rule: https://m3.material.io/styles/color/the-color-system/key-colors-tones (reference only, this color palette is not suitable)
  // Main palette tool: https://material.io/design/color/the-color-system.html#tools-for-picking-colors
  // Other palette tool: https://colors.dopely.top/color-toner
  // 2. Key colors
  // Logo color: 034266 and abe0f9

  // Color palettes
  // Blue
  static const blue50 = Color(0xffe3f0f3);
  static const blue100 = Color(0xffb9d9e4);
  static const blue200 = Color(0xff91c2d4);
  static const blue300 = Color(0xff6caac3);
  static const blue400 = Color(0xff5199b9);
  static const blue500 = Color(0xff378ab1);
  static const blue600 = Color(0xff2b7ea6);
  static const blue700 = Color(0xff1d6d95);
  static const blue800 = Color(0xff135d84);
  static const blue900 = Color(0xff034266);
  // Green
  static const green50 = Color(0xffe7f6ea);
  static const green100 = Color(0xffc7e9cc);
  static const green200 = Color(0xffa2dbab);
  static const green300 = Color(0xff7cce8a);
  static const green400 = Color(0xff5dc370);
  static const green500 = Color(0xff3eb857);
  static const green600 = Color(0xff35a94d);
  static const green700 = Color(0xff299741);
  static const green800 = Color(0xff1e8537);
  static const green900 = Color(0xff036623);
  // Yellow
  static const yellow50 = Color(0xfff5f6e3);
  static const yellow100 = Color(0xffe7e9ba);
  static const yellow200 = Color(0xffd6db8e);
  static const yellow300 = Color(0xffc6cd62);
  static const yellow400 = Color(0xffbac442);
  static const yellow500 = Color(0xffafbb1d);
  static const yellow600 = Color(0xffa3aa18);
  static const yellow700 = Color(0xff939611);
  static const yellow800 = Color(0xff827f0b);
  static const yellow900 = Color(0xff665B03);
  // Red
  static const red50 = Color(0xfff9e1e1);
  static const red100 = Color(0xffefb4b3);
  static const red200 = Color(0xffe28483);
  static const red300 = Color(0xffd25856);
  static const red400 = Color(0xffc43c38);
  static const red500 = Color(0xffb6291c);
  static const red600 = Color(0xffa9231d);
  static const red700 = Color(0xff971b1e);
  static const red800 = Color(0xff85111d);
  static const red900 = Color(0xff66031c);
  // Neutral
  static const white = Color(0xffffffff);
  static const gray10 = Color(0xfffefefe);
  static const gray50 = Color(0xfffafafa);
  static const gray100 = Color(0xfff4f4f4);
  static const gray200 = Color(0xffededed);
  static const gray300 = Color(0xffdfdfdf);
  static const gray400 = Color(0xffbcbcbc);
  static const gray500 = Color(0xff9c9c9c);
  static const gray600 = Color(0xff747474);
  static const gray700 = Color(0xff606060);
  static const gray800 = Color(0xff414141);
  static const gray900 = Color(0xff202020);
  static const black = Color(0xff000000);
}
