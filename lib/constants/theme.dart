// App padding
const kAppPaddingHorizontalSize = 20.0;
const kAppPaddingBetweenItemSize = 12.0;
const kAppPaddingTopSize = 48.0;
const kAppPaddingTopWithoutAppBarSize = 104.0;

// Border radius
class BorderRadiusSize {
  static const normal = 8.0;
  static const small = 6.0;
}

// App bar
enum AppBarType { normal, authenticator, history }

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
enum ButtonIconType { primaryOutlined, secondaryGhost, error }
enum ButtonIconSize { big, normal }
enum ButtonIconShape { normal, round }
