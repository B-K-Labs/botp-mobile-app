import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';

class SystemHomeScreen extends StatelessWidget {
  const SystemHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(appBarTitle: "System", body: SystemHomeBody());
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
      _preferences(),
      const DividerWidget(
          padding: EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize)),
      _notifications(),
    ]);
  }

  Widget _preferences() {
    return const SettingsSectionWidget(title: "Preferences", children: [
      SettingsOptionWidget(
        label: "Dark mode",
        type: SettingsOptionType.labelSwitchable,
      ),
      SettingsOptionWidget(
        label: "Transfer account",
        type: SettingsOptionType.labelNavigable,
        navigateDescription: "Engrish",
      )
    ]);
  }

  Widget _notifications() {
    return const SettingsSectionWidget(title: "Notifications", children: [
      SettingsOptionWidget(
        label: "Notify when received new transactions",
        type: SettingsOptionType.labelSwitchable,
      ),
    ]);
  }
}
