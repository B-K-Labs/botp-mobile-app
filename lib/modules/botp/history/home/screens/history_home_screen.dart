import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";

class HistoryHomeScreen extends StatelessWidget {
  const HistoryHomeScreen({Key? key}) : super(key: key);

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
            child: HistoryHomeBody()));
  }
}

class HistoryHomeBody extends StatefulWidget {
  const HistoryHomeBody({Key? key}) : super(key: key);

  @override
  State<HistoryHomeBody> createState() => _HistoryHomeBodyState();
}

class _HistoryHomeBodyState extends State<HistoryHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [Text("History")]);
  }
}
