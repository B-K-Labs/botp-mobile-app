import 'dart:math';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/modules/botp/settings/home/screens/settings_main_screen.dart';
import 'package:botp_auth/widgets/transaction.dart';
import 'package:flutter/material.dart';

class AuthenticatorHomeScreen extends StatefulWidget {
  const AuthenticatorHomeScreen({Key? key}) : super(key: key);

  @override
  State<AuthenticatorHomeScreen> createState() =>
      _AuthenticatorHomeScreenState();
}

class _AuthenticatorHomeScreenState extends State<AuthenticatorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("BOTP Authenticator"),
          // elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            IconButton(
              icon: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Image.network(
                  "https://www.printed.com/blog/wp-content/uploads/2016/06/quiz-serious-cat.png",
                ),
              ),
              onPressed: () {},
            ),
            const SizedBox(width: 10.0),
          ],
          titleTextStyle: Theme.of(context).textTheme.headline6,
          actionsIconTheme:
              IconThemeData(color: Theme.of(context).colorScheme.onSurface),
          toolbarHeight: 70,
        ),
        body: const SafeArea(
            minimum: EdgeInsets.all(kPaddingSafeArea),
            child: AuthenticatorMainBody()));
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
