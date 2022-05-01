import 'package:botp_auth/constants/common.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';

class ScreenWidget extends StatelessWidget {
  final bool hasAppBar;
  final AppBarType? appBarType;
  final bool appBarImplyLeading;
  final String? appBarTitle;
  final String? appBarAvatarUrl;
  final VoidCallback? appBarOnPressedAvatar;
  final double appBarElevation;
  final BottomNavigationBar? bottomNavigationBar;
  final Widget body;

  /// Scaffold with colored SafeArea
  const ScreenWidget(
      {Key? key,
      this.hasAppBar = true,
      this.bottomNavigationBar,
      this.appBarType,
      this.appBarImplyLeading = true,
      this.appBarTitle,
      this.appBarAvatarUrl,
      this.appBarOnPressedAvatar,
      this.appBarElevation = 1,
      required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppBar? _appBar;
    // AppBar theme
    // - Colors
    final Color _appbarBackgroundColor =
        Theme.of(context).scaffoldBackgroundColor;

    if (hasAppBar) {
      switch (appBarType) {
        case AppBarType.blank:
          _appBar = AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: appBarElevation,
            backgroundColor: _appbarBackgroundColor,
          );
          break;
        case AppBarType.authenticator:
          _appBar = AppBar(
            automaticallyImplyLeading: false,
            title: const Text("BOTP Authenticator"),
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
            elevation: appBarElevation,
            backgroundColor: _appbarBackgroundColor,
            actions: [
              AvatarWidget(
                  avatarUrl: appBarAvatarUrl, onPressed: appBarOnPressedAvatar),
              const SizedBox(width: 10.0),
            ],
            actionsIconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          );
          break;
        case AppBarType.history:
          _appBar = AppBar(
            automaticallyImplyLeading: false,
            title: const Text("History"),
            titleTextStyle: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
            // centerTitle: true,
            elevation: appBarElevation,
            // backgroundColor: Colors.transparent,
            backgroundColor: _appbarBackgroundColor,
          );
          break;
        case AppBarType.normal:
        default:
          _appBar = AppBar(
            automaticallyImplyLeading: appBarImplyLeading,
            title: appBarTitle != null ? Text(appBarTitle!) : null,
            titleTextStyle: Theme.of(context).textTheme.headline6,
            centerTitle: true,
            elevation: appBarElevation,
            // backgroundColor: Colors.transparent,
            backgroundColor: _appbarBackgroundColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
      }
    } else {
      _appBar = null;
    }
    // Status bar: Use SystemChrome/Annotated region
    // Safe area: inside scaffold
    return AnnotatedRegion(
        value: SystemUiOverlayStyle(
          // Background color
          statusBarColor: Theme.of(context).scaffoldBackgroundColor,
          // Icon color - each below is applied for Android and iOS, respectively
          statusBarBrightness: Theme.of(context).brightness == Brightness.light
              ? Brightness.dark
              : Brightness.light,
          statusBarIconBrightness:
              Theme.of(context).brightness == Brightness.light
                  ? Brightness.dark
                  : Brightness.light,
        ),
        child: Scaffold(
            appBar: _appBar,
            bottomNavigationBar: bottomNavigationBar,
            body: SafeArea(child: body)));
  }
}

// Avatar
class AvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final VoidCallback? onPressed;

  const AvatarWidget({Key? key, this.avatarUrl, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(100)),
          child: avatarUrl != null
              ? Image.network(avatarUrl!, scale: 1, fit: BoxFit.contain)
              : Image.asset("assets/images/temp/botp_temp.png",
                  scale: 1, fit: BoxFit.contain)),
      onPressed: onPressed,
    );
  }
}

// Decorated icon
class DecoratedIconWidget extends StatelessWidget {
  final IconData iconData;
  final DecoratedIconSize size;
  final ColorType colorType;

  const DecoratedIconWidget(
      {Key? key,
      required this.colorType,
      required this.size,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Decorated icon theme
    // - Color
    final Color _onColorContainer;
    final Color _colorContainer;
    switch (colorType) {
      case ColorType.error:
        _onColorContainer = Theme.of(context).colorScheme.onErrorContainer;
        _colorContainer = Theme.of(context).colorScheme.errorContainer;
        break;
      case ColorType.secondary:
        _onColorContainer = Theme.of(context).colorScheme.onSecondaryContainer;
        _colorContainer = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case ColorType.tertiary:
        _onColorContainer = Theme.of(context).colorScheme.onTertiaryContainer;
        _colorContainer = Theme.of(context).colorScheme.tertiaryContainer;
        break;
      case ColorType.primary:
      default:
        _onColorContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        _colorContainer = Theme.of(context).colorScheme.primaryContainer;
        break;
    }
    // - Size
    final _containerSize = size == DecoratedIconSize.normal ? 48.0 : 36.0;
    final _onContainerSize = size == DecoratedIconSize.normal ? 24.0 : 18.0;

    return Container(
        decoration: BoxDecoration(
            color: _colorContainer, borderRadius: BorderRadius.circular(100)),
        width: _containerSize,
        height: _containerSize,
        child: Center(
            child: Icon(iconData,
                color: _onColorContainer, size: _onContainerSize)));
  }
}

// Divider
class DividerWidget extends StatelessWidget {
  final EdgeInsets? padding;
  final double height;
  final double? thickness;
  final Color? color;
  const DividerWidget(
      {Key? key, this.height = 1.0, this.thickness, this.color, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _color = color ?? Theme.of(context).colorScheme.outline;
    return padding != null
        ? Container(
            padding: padding,
            child: Divider(height: height, color: _color, thickness: thickness))
        : Divider(
            height: height,
            color: _color,
            thickness: thickness,
          );
  }
}

class ReminderWidget extends StatelessWidget {
  final IconData iconData;
  final ColorType colorType;
  final String title;
  final String? description;
  final VoidCallback? onTap;
  final Widget? child;

  const ReminderWidget(
      {Key? key,
      required this.iconData,
      required this.colorType,
      required this.title,
      this.description,
      this.child,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Reminder theme
    // - Color
    final Color _onContainer;
    final Color _container;
    final Color _primary;
    switch (colorType) {
      case ColorType.secondary:
        _onContainer = Theme.of(context).colorScheme.onSecondaryContainer;
        _container = Theme.of(context).colorScheme.secondaryContainer;
        _primary = Theme.of(context).colorScheme.secondary;
        break;
      case ColorType.tertiary:
        _onContainer = Theme.of(context).colorScheme.onTertiaryContainer;
        _container = Theme.of(context).colorScheme.tertiaryContainer;
        _primary = Theme.of(context).colorScheme.tertiary;
        break;
      case ColorType.error:
        _onContainer = Theme.of(context).colorScheme.onErrorContainer;
        _container = Theme.of(context).colorScheme.errorContainer;
        _primary = Theme.of(context).colorScheme.error;
        break;
      case ColorType.primary:
      default:
        _onContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        _container = Theme.of(context).colorScheme.primaryContainer;
        _primary = Theme.of(context).colorScheme.primary;
        break;
    }
    // - Text
    final _titleStyle = Theme.of(context)
        .textTheme
        .bodyText2
        ?.copyWith(color: _onContainer, fontWeight: FontWeight.bold);
    final _descriptionStyle =
        Theme.of(context).textTheme.caption?.copyWith(color: _onContainer);
    // - Border
    final _borderRadius = BorderRadius.circular(BorderRadiusSize.normal);
    return Container(
        decoration: BoxDecoration(
            color: _container,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
                  blurRadius: boxShadowBlurRadius,
                  color: Theme.of(context)
                      .shadowColor
                      .withOpacity(boxShadowOpacity))
            ],
            borderRadius: _borderRadius),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: _borderRadius,
                onTap: onTap,
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 24.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Row(
                                  children: [
                                    Icon(iconData, color: _onContainer),
                                    const SizedBox(width: 8.0),
                                    Text(title, style: _titleStyle),
                                  ],
                                ),
                                description != null
                                    ? Column(children: [
                                        const SizedBox(height: 12.0),
                                        Row(children: [
                                          Expanded(
                                              child: Text(
                                            description!,
                                            style: _descriptionStyle,
                                          ))
                                        ])
                                      ])
                                    : Container(),
                                child != null
                                    ? Column(children: [
                                        const SizedBox(height: 12.0),
                                        Row(children: [Expanded(child: child!)])
                                      ])
                                    : Container()
                              ])),
                          onTap != null
                              ? Row(children: [
                                  const SizedBox(
                                      width: kAppPaddingBetweenItemNormalSize),
                                  Container(
                                      width: 36.0,
                                      height: 36.0,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      child: Icon(Icons.navigate_next_outlined,
                                          color: _primary))
                                ])
                              : Container()
                        ])))));
  }
}
