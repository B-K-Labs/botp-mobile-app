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
    final Color color = isSuccess
        ? Theme.of(context).colorScheme.secondary
        : Theme.of(context).colorScheme.error;
    final TextStyle? titleStyle =
        Theme.of(context).textTheme.headlineSmall?.copyWith(color: color);
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;

    final matchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_success.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Setup biometric successfully", style: titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text(message, style: textStyle),
    ]);
    final unmatchedStatus = Column(children: [
      const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
      SizedBox(
        height: 80.0,
        width: 80.0,
        child: Image.asset("assets/images/status/status_failed.png",
            scale: 1, fit: BoxFit.contain),
      ),
      const SizedBox(height: kAppPaddingBetweenItemNormalSize),
      Text("Failed to setup biometric", style: titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
      Text(message, style: textStyle),
    ]);
    return isSuccess ? matchedStatus : unmatchedStatus;
  }
}
