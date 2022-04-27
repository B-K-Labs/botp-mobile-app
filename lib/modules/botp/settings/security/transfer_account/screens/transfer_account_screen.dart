import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";

class SecurityTransferAccountScreen extends StatelessWidget {
  const SecurityTransferAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(
        appBarTitle: "Transfer Account", body: SecurityTransferAccountBody());
  }
}

class SecurityTransferAccountBody extends StatelessWidget {
  const SecurityTransferAccountBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Transfer account theme
    final _titleStyle = Theme.of(context)
        .textTheme
        .headline5
        ?.copyWith(color: Theme.of(context).colorScheme.primary);

    return Column(children: [
      const SizedBox(height: kAppPaddingVerticalSize),
      Text("Transfer your account", style: _titleStyle),
      const SizedBox(height: kAppPaddingBetweenItemSmallSize),
    ]);
  }
}
