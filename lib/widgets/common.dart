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
    final AppBar? appBar;
    // AppBar theme
    // - Colors
    final Color appbarBackgroundColor =
        Theme.of(context).scaffoldBackgroundColor;

    if (hasAppBar) {
      switch (appBarType) {
        case AppBarType.blank:
          appBar = AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: appBarElevation,
            backgroundColor: appbarBackgroundColor,
          );
          break;
        case AppBarType.authenticator:
          appBar = AppBar(
            automaticallyImplyLeading: false,
            title: const Text("BOTP Authenticator"),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
            elevation: appBarElevation,
            backgroundColor: appbarBackgroundColor,
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
          appBar = AppBar(
            automaticallyImplyLeading: false,
            title: const Text("BOTP History"),
            titleTextStyle: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Theme.of(context).colorScheme.primary),
            // centerTitle: true,
            elevation: appBarElevation,
            // backgroundColor: Colors.transparent,
            backgroundColor: appbarBackgroundColor,
          );
          break;
        case AppBarType.normal:
        default:
          appBar = AppBar(
            automaticallyImplyLeading: appBarImplyLeading,
            title: appBarTitle != null ? Text(appBarTitle!) : null,
            titleTextStyle: Theme.of(context).textTheme.titleLarge,
            centerTitle: true,
            elevation: appBarElevation,
            // backgroundColor: Colors.transparent,
            backgroundColor: appbarBackgroundColor,
            iconTheme: IconThemeData(
              color: Theme.of(context).colorScheme.onSurface,
            ),
          );
      }
    } else {
      appBar = null;
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
            appBar: appBar,
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
    final Color onColorContainer;
    final Color colorContainer;
    switch (colorType) {
      case ColorType.error:
        onColorContainer = Theme.of(context).colorScheme.onErrorContainer;
        colorContainer = Theme.of(context).colorScheme.errorContainer;
        break;
      case ColorType.secondary:
        onColorContainer = Theme.of(context).colorScheme.onSecondaryContainer;
        colorContainer = Theme.of(context).colorScheme.secondaryContainer;
        break;
      case ColorType.tertiary:
        onColorContainer = Theme.of(context).colorScheme.onTertiaryContainer;
        colorContainer = Theme.of(context).colorScheme.tertiaryContainer;
        break;
      case ColorType.primary:
      default:
        onColorContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        colorContainer = Theme.of(context).colorScheme.primaryContainer;
        break;
    }
    // - Size
    final containerSize = size == DecoratedIconSize.normal ? 48.0 : 36.0;
    final onContainerSize = size == DecoratedIconSize.normal ? 24.0 : 18.0;

    return Container(
        decoration: BoxDecoration(
            color: colorContainer, borderRadius: BorderRadius.circular(100)),
        width: containerSize,
        height: containerSize,
        child: Center(
            child: Icon(iconData,
                color: onColorContainer, size: onContainerSize)));
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
    final color = this.color ?? Theme.of(context).colorScheme.outline;
    return padding != null
        ? Container(
            padding: padding,
            child: Divider(height: height, color: color, thickness: thickness))
        : Divider(
            height: height,
            color: color,
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
    final Color onContainer;
    final Color container;
    final Color primary;
    switch (colorType) {
      case ColorType.secondary:
        onContainer = Theme.of(context).colorScheme.onSecondaryContainer;
        container = Theme.of(context).colorScheme.secondaryContainer;
        primary = Theme.of(context).colorScheme.secondary;
        break;
      case ColorType.tertiary:
        onContainer = Theme.of(context).colorScheme.onTertiaryContainer;
        container = Theme.of(context).colorScheme.tertiaryContainer;
        primary = Theme.of(context).colorScheme.tertiary;
        break;
      case ColorType.error:
        onContainer = Theme.of(context).colorScheme.onErrorContainer;
        container = Theme.of(context).colorScheme.errorContainer;
        primary = Theme.of(context).colorScheme.error;
        break;
      case ColorType.primary:
      default:
        onContainer = Theme.of(context).colorScheme.onPrimaryContainer;
        container = Theme.of(context).colorScheme.primaryContainer;
        primary = Theme.of(context).colorScheme.primary;
        break;
    }
    // - Text
    final titleStyle = Theme.of(context)
        .textTheme
        .bodyMedium
        ?.copyWith(color: onContainer, fontWeight: FontWeight.bold);
    final descriptionStyle =
        Theme.of(context).textTheme.bodySmall?.copyWith(color: onContainer);
    // - Border
    final borderRadius = BorderRadius.circular(BorderRadiusSize.normal);
    return Container(
        decoration: BoxDecoration(
            color: container,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(boxShadowOffsetX, boxShadowOffsetY),
                  blurRadius: boxShadowBlurRadius,
                  color: Theme.of(context)
                      .shadowColor
                      .withOpacity(boxShadowOpacity))
            ],
            borderRadius: borderRadius),
        child: Material(
            color: Colors.transparent,
            child: InkWell(
                borderRadius: borderRadius,
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
                                    Icon(iconData, color: onContainer),
                                    const SizedBox(width: 8.0),
                                    Text(title, style: titleStyle),
                                  ],
                                ),
                                description != null
                                    ? Column(children: [
                                        const SizedBox(height: 12.0),
                                        Row(children: [
                                          Expanded(
                                              child: Text(
                                            description!,
                                            style: descriptionStyle,
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
                                          color: primary))
                                ])
                              : Container()
                        ])))));
  }
}
