import 'dart:math';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/modules/botp/transaction/screens/transaction_details_screen.dart';
import 'package:botp_auth/widgets/bars.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import "package:flutter_bloc/flutter_bloc.dart";

class AuthenticatorScreen extends StatefulWidget {
  const AuthenticatorScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticatorScreen> createState() => _AuthenticatorScreenState();
}

class _AuthenticatorScreenState extends State<AuthenticatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, type: AppBarType.authenticator),
        body: const SafeArea(bottom: true, child: AuthenticatorMainBody()));
  }
}

class AuthenticatorMainBody extends StatefulWidget {
  const AuthenticatorMainBody({Key? key}) : super(key: key);

  @override
  State<AuthenticatorMainBody> createState() => _AuthenticatorMainBodyState();
}

class _AuthenticatorMainBodyState extends State<AuthenticatorMainBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
        child: _buildAccountList(),
      )
    ]);
  }

  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  final accountList = [
    'Netflix',
    'Shopee',
    'Lazada',
    'The Coffee House',
    'Steam',
    'Google',
    'Facebook'
  ];
  final notifyMessagesList = [
    'Facebook need your confirmation to your account password change. Date: 20/04/2022',
    'Shopee need your confirmation to your account password change. Date: 20/04/2022',
    'Lazada need your confirmation to your account password change. Date: 20/04/2022',
    'Transfer money from Khim to Hien. Total: 10 USD',
  ];

  void createAlertDialog(BuildContext context) {
    //     setState(() {
    //       // This call to setState tells the Flutter framework that something has
    //       // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
  }

  T getRandom<T>(_list) {
    final _random = Random();
    return _list[_random.nextInt(_list.length)];
  }

  String generateRandomAgentImage() {
    return getRandom([
      "https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/Facebook_Logo_%282019%29.png/1200px-Facebook_Logo_%282019%29.png",
      "https://cdn.chanhtuoi.com/uploads/2020/06/logo-lazada-2.png",
      "https://senyumpeople.com/wp-content/uploads/2015/10/shopee.png",
      "http://static.ybox.vn/2019/5/5/1559293422415-53327481_2294812427459437_7857033109093482496_n.jpg"
    ]);
  }

  String generateRandomNotifyMessage() {
    return getRandom(notifyMessagesList);
  }

  TransactionStatus generateRandomTransactionStatus() {
    return getRandom(TransactionStatus.values);
  }

  String generateRandomOTPCode({int len = 6}) {
    var r = Random();
    return String.fromCharCodes(
            List.generate(len ~/ 2, (index) => r.nextInt(10) + 48)) +
        " " +
        String.fromCharCodes(
            List.generate(len ~/ 2, (index) => r.nextInt(10) + 48));
  }

  Widget _buildAccountList() {
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(getRandom(accountList));
        });
  }

  Widget _buildRow(String account) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const TransactionDetailsScreen()));
      },
      child: TransactionItemWidget(
          isNewest: false,
          agentName: account,
          agentAvatarUrl: generateRandomAgentImage(),
          agentIsVerified: true,
          timestamp: "11:45 - 21/02/2022",
          notifyMessage: generateRandomNotifyMessage(),
          transactionStatus: generateRandomTransactionStatus()),
    );
  }
}
