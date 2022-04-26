import 'package:botp_auth/constants/common.dart';
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
    default:
      _backgroundColor = Theme.of(context).colorScheme.error;
      break;
  }
  final snackBar = SnackBar(
    content: Text(message),
    behavior: SnackBarBehavior.floating,
    backgroundColor: _backgroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(BorderRadiusSize.small),
    ),
    margin: const EdgeInsets.only(
        bottom: kAppPaddingHorizontalSize,
        right: kAppPaddingHorizontalSize,
        left: kAppPaddingHorizontalSize),
  );
  ScaffoldMessenger.of(context).removeCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
