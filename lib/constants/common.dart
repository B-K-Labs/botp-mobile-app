// App padding
const kAppPaddingHorizontalSize = 18.0;
const kAppPaddingTopSize = 24.0;
const kAppPaddingBottomSize = 24.0;
const kAppPaddingBetweenItemSmallSize = 12.0;
const kAppPaddingBetweenItemNormalSize = 24.0;
const kAppPaddingBetweenItemLargeSize = 36.0;
const kAppPaddingBetweenItemVeryLargeSize = 48.0;
const kAppPaddingTopWithoutAppBarSize = 80.0; // 56 + 24

// Border radius
class BorderRadiusSize {
  static const normal = 8.0;
  static const small = 6.0;
}

// App bar
enum AppBarType { normal, blank, authenticator, history }

// Button
enum ButtonNormalType {
  primary,
  primaryOutlined,
  primaryGhost,
  secondaryOutlined,
  secondaryGhost,
  error,
  errorOutlined,
  disabled,
}
enum ButtonNormalSize { full, normal, short }
enum ButtonTextType { primary, error }
enum ButtonIconType { primaryOutlined, secondaryGhost, error }
enum ButtonIconSize { big, normal }
enum ButtonIconShape { normal, round }

// Toast
enum SnackBarType {
  info,
  success,
  error,
}

// Box shadow
const boxShadowOffsetX = 0.0;
const boxShadowOffsetY = 2.0;
const boxShadowBlurRadius = 30.0;
const boxShadowOpacity = 0.05;
