import 'package:botp_auth/constants/theme.dart';
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
        child: Text(
          "History",
          style: Theme.of(context)
              .textTheme
              .headline4
              ?.copyWith(color: AppColors.primaryColor),
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
