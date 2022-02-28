import 'package:botp_auth/widgets/transaction.dart';
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

  Color myColor = const Color(0xff00bfa5);
  // _openDialog(account) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return Dialog(
  //         // shape: RoundedRectangleBorder(
  //         //     borderRadius: BorderRadius.circular(40)),
  //         elevation: 16,
  //         child: ListView(
  //           shrinkWrap: true,
  //           children: <Widget>[
  //             const SizedBox(height: 20),
  //             const Center(child: Text('Authentication info')),
  //             const SizedBox(height: 20),
  //             Container(
  //                 padding: const EdgeInsets.symmetric(
  //                   horizontal: 20,
  //                 ),
  //                 child: Text(account)),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }

  _openAlertBox({required String account}) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            contentPadding: const EdgeInsets.only(top: 10.0),
            content: SizedBox(
              width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        account,
                        style: const TextStyle(fontSize: 24.0),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.star_border,
                            color: myColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: myColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: myColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: myColor,
                            size: 30.0,
                          ),
                          Icon(
                            Icons.star_border,
                            color: myColor,
                            size: 30.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 4.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Add Review",
                        border: InputBorder.none,
                      ),
                      maxLines: 8,
                    ),
                  ),
                  InkWell(
                    child: Container(
                      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                      decoration: BoxDecoration(
                        color: myColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(32.0),
                            bottomRight: Radius.circular(32.0)),
                      ),
                      child: const Text(
                        "Rate Product",
                        style: TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildRow(String account) {
    return GestureDetector(
      onTap: () => _openAlertBox(account: account),
      child: Container(
          // decoration: BoxDecoration(
          //   color: Colors.white,
          //   borderRadius: const BorderRadius.only(
          //       topLeft: Radius.circular(8),
          //       topRight: Radius.circular(8),
          //       bottomLeft: Radius.circular(8),
          //       bottomRight: Radius.circular(8)),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.grey.withOpacity(0.5),
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: const Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: AppTransactionItemMain(
              isLasted: false,
              agentName: account,
              timestamp: "11:45 - 21/02/2022",
              email: generateRandomHCMUTAccount(),
              urlImage: generateRandomAgentImage(),
              transStatus: generateRandomTransactionStatus())),
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
