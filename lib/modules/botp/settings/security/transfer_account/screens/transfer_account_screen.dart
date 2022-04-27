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
    return Column(
      children: [Text("Hello")],
    );
  }
}
