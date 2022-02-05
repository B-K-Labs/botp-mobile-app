import 'package:flutter/material.dart';

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  _HistoryBodyState createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 200,
        alignment: const Alignment(0.0, 0.0),
        child: const Text(
          "Lookup History",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25.00),
        ),
      ),
      Expanded(
        child: Container(),
      )
    ]));
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
