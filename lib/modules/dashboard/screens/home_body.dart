import 'package:flutter/material.dart';
import 'dart:math';

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);

  // int _counter = 0;

  void createAlertDialog(BuildContext context) {
    //     setState(() {
    //       // This call to setState tells the Flutter framework that something has
    //       // changed in this State, which causes it to rerun the build method below
    // so that the display can reflect the updated values. If we changed
    // _counter without calling setState(), then the build method would not be
    // called again, and so nothing would appear to happen.
  }

  String generateRandomHCMUTAccount(int len) {
    var r = Random();
    return "hientm177" +
        String.fromCharCodes(
            List.generate(len, (index) => r.nextInt(33) + 89)) +
        "@hcmut.edu.vn";
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
      body: _buildAccountList(),
    );
  }

  Widget _buildAccountList() {
    var accountList = [
      'Netflix',
      'Shopee',
      'Lazada',
      'The Coffee House',
      'Steam',
      'Google',
      'Facebook'
    ];
    final _random = Random();
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: /*1*/ (context, i) {
          return _buildRow(accountList[_random.nextInt(accountList.length)]);
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
                        vertical: 5,
                        horizontal: 20,
                      ),
                      child: Text(account)),
                ],
              ),
            );
          },
        );
      },
      child: Card(
          child: ListTile(
        // leading: Image.network(
        //   "https://bit.ly/3nQWmts",
        //   scale: 1,
        // ),
        title: Container(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              account + " account",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            )),
        subtitle: Column(children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(generateRandomHCMUTAccount(5),
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFF3D3D3D),
                      )))),
        ]),
        trailing: const Icon(Icons.navigate_next),
      )),
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
