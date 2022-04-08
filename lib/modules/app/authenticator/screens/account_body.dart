import 'package:flutter/material.dart';

class AccountBody extends StatefulWidget {
  const AccountBody({Key? key}) : super(key: key);

  @override
  _AccountBodyState createState() => _AccountBodyState();
}

class _AccountBodyState extends State<AccountBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        height: 200,
        alignment: const Alignment(0.0, 0.0),
        child: const Text(
          "Settings",
          style: TextStyle(fontWeight: FontWeight.normal, fontSize: 25.00),
        ),
      ),
      Expanded(
        child: Container(),
      )
    ]));
  }
}

class GroupSettingItem extends StatelessWidget {
  final List<Widget> child;

  const GroupSettingItem({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: child,
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
