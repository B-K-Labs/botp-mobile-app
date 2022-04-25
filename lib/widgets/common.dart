import 'package:botp_auth/constants/common.dart';
import "package:flutter/material.dart";

class AppBarWidget {
  static AppBar generate(BuildContext context,
      {AppBarType? type,
      bool implyLeading = true,
      String? title,
      String? avatarUrl,
      VoidCallback? onPressedAvatar}) {
    switch (type) {
      case AppBarType.normal:
        return AppBar(
          automaticallyImplyLeading: implyLeading,
          title: title != null ? Text(title) : null,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.normal),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
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
          title: title != null ? Text(title) : null,
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
          title: title != null ? Text(title) : null,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.normal),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
      default: // Normal
        return AppBar(
          automaticallyImplyLeading: implyLeading,
          title: title != null ? Text(title) : null,
          titleTextStyle: Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(fontWeight: FontWeight.normal),
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
  final Color colorContainer;
  final Color onColorContainer;
  final IconData iconData;
  const DecoratedIconWidget(
      {Key? key,
      required this.colorContainer,
      required this.onColorContainer,
      required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: colorContainer, borderRadius: BorderRadius.circular(100)),
        width: 48.0,
        height: 48.0,
        child:
            Center(child: Icon(iconData, color: onColorContainer, size: 24)));
  }
}
