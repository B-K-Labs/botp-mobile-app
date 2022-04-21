import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';

class AuthenticatorBody extends StatefulWidget {
  const AuthenticatorBody({Key? key}) : super(key: key);

  @override
  State<AuthenticatorBody> createState() => _AuthenticatorBodyState();
}

class _AuthenticatorBodyState extends State<AuthenticatorBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
            horizontal: kAppPaddingHorizontalAndBottomSize),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _reminder(),
              _filter(),
              _transactionItemsList(),
            ]));
  }

  // 1. Reminder
  Widget _reminder() {
    return Container();
  }

  // 2. Transaction filter
  Widget _filter() {
    return Container(
        padding: EdgeInsets.symmetric(
            vertical: kAppPaddingBetweenItemHorizontalSize));
  }

  // 3. Transaction list
  Widget _transactionItemsList() {
    return Stack(children: [
      _generateShadowTransactionItemsList(),
      _generateTransationItemsList()
    ]);
  }

  Widget _generateTransationItemsList() {
    return Column(children: [_generateTransactionItem()]);
  }

  Widget _generateTransactionItem() {
    return GestureDetector(
        onTap: () {
          Application.router.navigateTo(context, "/botp/transaction");
        },
        child: TransactionItemWidget(
            isNewest: false,
            agentName: "Shopee",
            agentAvatarUrl:
                "https://senyumpeople.com/wp-content/uploads/2015/10/shopee.png",
            agentIsVerified: true,
            date: "123",
            notifyMessage: "123",
            transactionStatus: TransactionStatus.requesting));
  }

  Widget _generateShadowTransactionItemsList() {
    return Column(children: [_generateBoxShadow()]);
  }

  Widget _generateBoxShadow() {
    return const ShadowTransactionItemWidget();
  }
}
