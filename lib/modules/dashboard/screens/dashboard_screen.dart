import 'package:flutter/material.dart';
import 'package:botp_auth/constants/app_constants.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:math';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Home"),
            automaticallyImplyLeading: true,
            backgroundColor: kPrimaryColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            )),
        body: const Body());
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _suggestions = <WordPair>[];
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
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        openCloseDial: isDialOpen,
        backgroundColor: Colors.blueAccent,
        overlayColor: Colors.grey,
        overlayOpacity: 0.5,
        spacing: 15,
        spaceBetweenChildren: 10,
        closeManually: true,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.logout),
            label: 'Sign out',
            backgroundColor: Colors.blue,
            // onTap: (){
            //   print('Share Tapped');
            // }
          ),
          SpeedDialChild(
            child: const Icon(Icons.settings),
            label: 'Setting',
            // onTap: (){
            //   print('Registration Tapped');
            // }
          ),
          SpeedDialChild(
            child: const Icon(Icons.qr_code),
            label: 'Account info',
            // onTap: (){
            //   print('Camera Tapped');
            // }
          ),
        ],
      ),
    );
  }

  Widget _buildAccountList() {
    var accountList = ['Netflix', 'Shopee', 'Lazada'];
    final _random = Random();
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(20)); /*4*/
          }

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
                      child: Text(account,
                          style: TextStyle(fontWeight: FontWeight.bold))),
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
