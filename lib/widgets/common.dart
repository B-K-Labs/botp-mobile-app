import 'package:botp_auth/constants/common.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class AppBarWidget {
  static AppBar generate(BuildContext context,
      {AppBarType? type,
      bool implyLeading = true,
      String? title,
      String? avatarUrl,
      VoidCallback? onPressedAvatar}) {
    switch (type) {
      case AppBarType.blank:
        return AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        );
      case AppBarType.authenticator:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text("BOTP Authenticator"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            AvatarWidget(avatarUrl: avatarUrl, onPressed: onPressedAvatar),
            const SizedBox(width: 10.0),
          ],
          actionsIconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        );
      case AppBarType.history:
        return AppBar(
          automaticallyImplyLeading: false,
          title: const Text("History"),
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
          // centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
        );
      case AppBarType.normal:
      default:
        return AppBar(
          automaticallyImplyLeading: implyLeading,
          title: title != null ? Text(title) : null,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
    }
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
              ? Image.network(avatarUrl!)
              : Image.asset("assets/images/temp/botp_temp.png",
                  scale: 1, fit: BoxFit.fitWidth)),
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
