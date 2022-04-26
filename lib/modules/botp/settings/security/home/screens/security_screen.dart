import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';

class SecurityHomeScreen extends StatelessWidget {
  const SecurityHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, title: "Security"),
        body: const SafeArea(child: SecurityHomeBody()));
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
    return Column(children: [
      SettingsSectionWidget(title: "Account security", children: [
        SettingsOptionWidget(
          label: "Change password",
          type: SettingsOptionType.labelNavigable,
        ),
        SettingsOptionWidget(
          label: "Transfer account",
          type: SettingsOptionType.labelNavigable,
        ),
        SettingsOptionWidget(
          label: "Fingerprint auth",
          type: SettingsOptionType.labelNavigable,
          navigateDescription: "Not set up yet",
        ),
      ]),
      SettingsSectionWidget(title: "Session", children: [
        SettingsOptionWidget(
          label: "Sign out",
          type: SettingsOptionType.buttonTextOneSide,
          buttonSideColorType: ColorType.error,
        ),
      ])
    ]);
  }

  Widget _session() {
    return Container();
  }
}
