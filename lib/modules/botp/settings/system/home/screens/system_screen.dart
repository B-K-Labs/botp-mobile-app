import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';

class SystemHomeScreen extends StatelessWidget {
  const SystemHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, title: "System"),
        body: const SafeArea(child: SystemHomeBody()));
  }
}

class SystemHomeBody extends StatefulWidget {
  const SystemHomeBody({Key? key}) : super(key: key);

  @override
  State<SystemHomeBody> createState() => _SystemHomeBodyState();
}

class _SystemHomeBodyState extends State<SystemHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SettingsSectionWidget(title: "Preferences", children: [
        SettingsOptionWidget(
          label: "Dark mode",
          type: SettingsOptionType.labelSwitchable,
        ),
        SettingsOptionWidget(
          label: "Transfer account",
          type: SettingsOptionType.labelNavigable,
          navigateDescription: "Engrish",
        ),
      ]),
      SettingsSectionWidget(title: "Notifications", children: [
        SettingsOptionWidget(
          label: "Notify when received new transactions",
          type: SettingsOptionType.labelSwitchable,
        ),
      ])
    ]);
  }
}
