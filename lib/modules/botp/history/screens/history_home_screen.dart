import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/bars.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, type: AppBarType.history),
        body: const SafeArea(bottom: true, child: HistoryBody()));
  }
}

class HistoryBody extends StatefulWidget {
  const HistoryBody({Key? key}) : super(key: key);

  @override
  State<HistoryBody> createState() => _HistoryBodyState();
}

class _HistoryBodyState extends State<HistoryBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("History")]);
  }
}
