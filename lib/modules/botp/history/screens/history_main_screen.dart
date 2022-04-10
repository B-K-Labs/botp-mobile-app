import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";

class HistoryMainScreen extends StatelessWidget {
  const HistoryMainScreen({Key? key}) : super(key: key);

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
            minimum: EdgeInsets.all(kPaddingSafeArea),
            child: HistoryMainBody()));
  }
}

class HistoryMainBody extends StatefulWidget {
  const HistoryMainBody({Key? key}) : super(key: key);

  @override
  State<HistoryMainBody> createState() => _HistoryMainBodyState();
}

class _HistoryMainBodyState extends State<HistoryMainBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("History")]);
  }
}
