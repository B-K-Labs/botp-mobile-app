// App padding
const kAppPaddingHorizontalAndBottomSize = 24.0;
const kAppPaddingBetweenItemSmallSize = 12.0;
const kAppPaddingBetweenItemNormalSize = 24.0;
const kAppPaddingBetweenItemLargeSize = 36.0;
const kAppPaddingBetweenItemVeryLargeSize = 48.0;
const kAppPaddingTopSize = 48.0;
const kAppPaddingTopWithoutAppBarSize = 104.0;

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

// Settings

enum SettingsOptionType {
  textNormalValue,
  textMultilineValue,
  textCustomWidgetValue,
  buttonToggleable,
  buttonTextOneSide,
  buttonNavigable,
  buttonSelectable
}
