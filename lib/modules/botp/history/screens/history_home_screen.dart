import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            iconTheme:
                IconThemeData(color: Theme.of(context).colorScheme.onSurface),
            title: NormalInputFieldWidget(
              validator: (value) {},
              onChanged: (value) {},
              iconData: Icons.search,
              onTapIcon: () {},
            )),
        body: const SafeArea(
            minimum: EdgeInsets.all(kPaddingSafeArea), child: HistoryBody()));
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
