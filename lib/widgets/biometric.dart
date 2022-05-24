import 'package:botp_auth/constants/common.dart';
import "package:flutter/material.dart";

class BiometricSetupStatusWidget extends StatelessWidget {
  final bool isSuccess;
  final String message;
  const BiometricSetupStatusWidget(
      {Key? key, required this.isSuccess, required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Theme
    final Color _color = isSuccess
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;
    final TextStyle? _titleStyle =
        Theme.of(context).textTheme.headline5?.copyWith(color: _color);
    final TextStyle? _textStyle = Theme.of(context).textTheme.bodyText2;

    final _matchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_success.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Setup biometric successfully", style: _titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text(message, style: _textStyle),
    ]);
    final _unmatchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_failed.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Failed to setup biometric", style: _titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text(message, style: _textStyle),
    ]);
    return isSuccess ? _matchedStatus : _unmatchedStatus;
  }
}
