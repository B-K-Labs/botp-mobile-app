import 'package:flutter/material.dart';
import 'dart:math';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
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

  String generateRandomHCMUTAccount() {
    return getRandom(emailNameList) +
        // String.fromCharCodes(
        //     List.generate(len, (index) => r.nextInt(33) + 89)) +
        "@" +
        getRandom(emailDomainList);
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
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Column(children: [
      Container(
        height: 200,
        alignment: const Alignment(0.0, 0.0),
        child: const Text(
          "Authentication",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25.00),
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
        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              // shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(40)),
              elevation: 16,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  const SizedBox(height: 20),
                  const Center(child: Text('Authentication info')),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Text(account)),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Card(
            child: ListTile(
          leading: Image.network("https://bit.ly/3nQWmts",
              scale: 1, fit: BoxFit.fitWidth),
          title: Container(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                account + " account",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          subtitle: Column(children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(generateRandomHCMUTAccount(),
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF3D3D3D),
                        )))),
          ]),
          trailing: const Icon(Icons.navigate_next),
        )),
      ),
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
