import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, title: "System"),
        body: const SafeArea(child: AboutHomeBody()));
  }
}

class AboutHomeBody extends StatefulWidget {
  const AboutHomeBody({Key? key}) : super(key: key);

  @override
  State<AboutHomeBody> createState() => _AboutHomeBodyState();
}

class _AboutHomeBodyState extends State<AboutHomeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _appInfo(),
    ]);
  }

  Widget _appInfo() {
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
