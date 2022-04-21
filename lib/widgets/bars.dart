import 'package:botp_auth/constants/theme.dart';
import "package:flutter/material.dart";

class AppBarWidget {
  static AppBar generate(BuildContext context,
      {AppBarType? type,
      String? title,
      String? avatarUrl,
      VoidCallback? onPressedAvatar}) {
    switch (type) {
      case AppBarType.normal:
        return AppBar(
          title: title != null ? Text(title) : null,
          // titleTextStyle: Theme.of(context).textTheme.headline6,
          elevation: 0,
          backgroundColor: null,
        );
      case AppBarType.authenticator:
        return AppBar(
          automaticallyImplyLeading: false,
          title: title != null ? Text(title) : null,
          titleTextStyle: Theme.of(context).textTheme.headline6,
          elevation: 0,
          backgroundColor: null,
          actions: [
            IconButton(
              icon: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(100)),
                  child: avatarUrl != null ? Image.network(avatarUrl) : null),
              onPressed: onPressedAvatar,
            ),
            const SizedBox(width: 10.0),
          ],
          actionsIconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
        );
      case AppBarType.history:
        return AppBar();
      default: // Normal
        return AppBar(
          title: title != null ? Text(title) : null,
          // titleTextStyle: Theme.of(context).textTheme.headline6,
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        );
    }
  }
}
