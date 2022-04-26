import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';

class SecurityHomeScreen extends StatelessWidget {
  const SecurityHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, title: "Security"),
        body: const SafeArea(bottom: true, child: SecurityHomeBody()));
  }
}

class SecurityHomeBody extends StatefulWidget {
  const SecurityHomeBody({Key? key}) : super(key: key);

  @override
  State<SecurityHomeBody> createState() => _SecurityHomeBodyState();
}

class _SecurityHomeBodyState extends State<SecurityHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _account(),
      _session(),
    ]);
  }

  Widget _account() {
    return Container();
  }

  Widget _session() {
    return Container();
  }
}
