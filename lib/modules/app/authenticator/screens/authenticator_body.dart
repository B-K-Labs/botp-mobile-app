// import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AuthenticatorBody extends StatefulWidget {
  const AuthenticatorBody({Key? key}) : super(key: key);

  @override
  _AuthenticatorBodyState createState() => _AuthenticatorBodyState();
}

class _AuthenticatorBodyState extends State<AuthenticatorBody> {
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
  final emailNameList = ['hien.itgenius', 'hkneee', 'ureshii'];
  final emailDomainList = ['gmail.com', 'edu.com', 'outlook.com'];
  // int _counter = 0;

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

  String generateRandomHCMUTAccount() {
    return getRandom(emailNameList) +
        // String.fromCharCodes(
        //     List.generate(len, (index) => r.nextInt(33) + 89)) +
        "@" +
        getRandom(emailDomainList);
  }

  int generateRandomTransactionStatus() {
    return getRandom([0, 1, 2, 3]);
  }

  String generateRandomOTPCode({int len = 6}) {
    var r = Random();
    return String.fromCharCodes(
            List.generate(len ~/ 2, (index) => r.nextInt(10) + 48)) +
        " " +
        String.fromCharCodes(
            List.generate(len ~/ 2, (index) => r.nextInt(10) + 48));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 200,
        alignment: const Alignment(0.0, 0.0),
        child: Text(
          "Authenticator",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: AppColors.primaryColor),
        ),
      ),
      Expanded(
        child: _buildAccountList(),
      )
    ]));
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
        // Application.router.navigateTo(context, "/")
      },
      child: TransactionItemWidget(
          isLasted: false,
          agentName: account,
          timestamp: "11:45 - 21/02/2022",
          email: generateRandomHCMUTAccount(),
          urlImage: generateRandomAgentImage(),
          transStatus: generateRandomTransactionStatus()),
    );
  }
}

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            child,
          ],
        ));
  }
}
