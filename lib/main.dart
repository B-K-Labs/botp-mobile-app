import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the the me of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const Account(),
    );
  }
}


class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}


class _AccountState extends State<Account> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 12.0);
  ValueNotifier<bool> isDialOpen = ValueNotifier(false);
  int _counter = 0;

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
    return "hientm177" + String.fromCharCodes(List.generate(len, (index) => r.nextInt(33) + 89)) + "@hcmut.edu.vn";
  }

  String generateRandomOTPCode({int len = 6}) {
    var r = Random();
    return String.fromCharCodes(List.generate(len ~/ 2, (index) => r.nextInt(10) + 48)) + " " + String.fromCharCodes(List.generate(len ~/ 2, (index) => r.nextInt(10) + 48));
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "BOTP Auth",
            textAlign: TextAlign.center,
          )
        ),

        body: _buildAccountList(),

        floatingActionButton:  SpeedDial(
          animatedIcon: AnimatedIcons.menu_close  ,
          openCloseDial: isDialOpen,
          backgroundColor: Colors.blueAccent,
          overlayColor: Colors.grey,
          overlayOpacity: 0.5,
          spacing: 15,
          spaceBetweenChildren: 10,
          closeManually: true,
          children: [
            SpeedDialChild(
                child: Icon(Icons.share_rounded),
                label: 'Share app',
                backgroundColor: Colors.blue,
                onTap: (){
                  print('Share Tapped');
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.keyboard),
                label: 'Enter registration code ',
                onTap: (){
                  print('Registration Tapped');
                }
            ),
            SpeedDialChild(
                child: Icon(Icons.camera_enhance),
                label: 'Scan QR Code',
                onTap: (){
                  print('Camera Tapped');
                }
            ),
          ],
        ),
    );
  }

  Widget _buildAccountList() {
    return ListView.builder(
        padding: const EdgeInsets.all(15.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return const Divider();
          /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(20)); /*4*/
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    return Card(
      child: ListTile(
        leading:  Image.network("https://bit.ly/3nQWmts",
        scale: 1,),
        title: Container (
          padding: const EdgeInsets.only(top: 10.0),
          child: const Text(
            "Facebook account",
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          )
        ),
        subtitle: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: Text(
                    generateRandomHCMUTAccount(5),
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Color(0xFF3D3D3D),
                    )
                  )
              )
            ),
            Align(
                alignment: Alignment.centerLeft,
                child:
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text(
                      generateRandomOTPCode(),
                      style: const TextStyle(
                        fontSize: 24.0,
                        color: Color(0xFFE81616)
                        )
                      )
                    )
                  )
            ]
        ),
        trailing: const Icon(Icons.navigate_next),
      )
    );
  }
}

