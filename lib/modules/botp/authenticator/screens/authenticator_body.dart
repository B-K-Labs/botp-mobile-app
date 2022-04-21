import 'dart:math';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/transaction/screens/transaction_details_screen.dart';
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
              Expanded(
                child: Container(),
              )
            ]));
  }

  Widget _generateTransactionItemsList() {
    return Container();
  }

  Widget _generateTransactionItem() {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const TransactionDetailsScreen()));
        },
        child: TransactionItemWidget(
            isNewest: false,
            agentName: "Shopee",
            agentAvatarUrl:
                "https://senyumpeople.com/wp-content/uploads/2015/10/shopee.png",
            agentIsVerified: true,
            timestamp: "123",
            notifyMessage: "123",
            transactionStatus: TransactionStatus.requesting));
  }

  Widget _generateBoxShadow() {
    return Container(
      width: double.infinity,
      height: 94,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: const Offset(0.0, 2.0),
              blurRadius: 30.0,
              color: Theme.of(context).shadowColor.withOpacity(0.05))
        ],
      ),
    );
  }
}
