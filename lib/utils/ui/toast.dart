import 'package:botp_auth/constants/theme.dart';
import 'package:flutter/material.dart';

void showSnackBar(context, message, [SnackBarType type = SnackBarType.error]) {
  final Color _backgroundColor;
  switch (type) {
    case SnackBarType.info:
      _backgroundColor = Theme.of(context).colorScheme.primary;
      break;
    case SnackBarType.success:
      _backgroundColor = Theme.of(context).colorScheme.secondary;
      break;
    case SnackBarType.error:
      _backgroundColor = Theme.of(context).colorScheme.error;
      break;
    default: // Error
      _backgroundColor = Theme.of(context).colorScheme.error;
  }
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: _backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.small),
    ),
    margin: const EdgeInsets.only(
        bottom: kAppPaddingHorizontalAndBottomSize,
        right: kAppPaddingHorizontalAndBottomSize,
        left: kAppPaddingHorizontalAndBottomSize),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
