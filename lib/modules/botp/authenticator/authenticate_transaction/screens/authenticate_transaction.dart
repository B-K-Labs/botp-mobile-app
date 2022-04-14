import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/button.dart';
import "package:flutter/material.dart";

class AuthenticateTransactionScreen extends StatelessWidget {
  const AuthenticateTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Authenticate transaction")),
        body: const AuthenticateTransactionBody());
  }
}

class AuthenticateTransactionBody extends StatefulWidget {
  const AuthenticateTransactionBody({Key? key}) : super(key: key);

  @override
  State<AuthenticateTransactionBody> createState() =>
      _AuthenticateTransactionBodyState();
}

class _AuthenticateTransactionBodyState
    extends State<AuthenticateTransactionBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_transactionInfo(), _buttons()]);
  }

  Widget _transactionInfo() {
    return Text("transaction");
  }

  Widget _buttons() {
    return Expanded(
        child: Row(children: [
      NormalButtonWidget(
          text: "Reject",
          press: () {},
          primary: AppColors.redColor,
          backgroundColor: AppColors.whiteColor),
      NormalButtonWidget(
          text: "Confirm",
          press: () {},
          primary: AppColors.whiteColor,
          backgroundColor: AppColors.greenColor)
    ]));
  }
}
