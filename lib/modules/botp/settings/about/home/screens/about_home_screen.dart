import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';

class AboutHomeScreen extends StatelessWidget {
  const AboutHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(appBarTitle: "About", body: AboutHomeBody());
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
    return SingleChildScrollView(
        child: Column(children: [
      _appInfo(),
    ]));
  }

  Widget _appInfo() {
    return Column(children: [
      SettingsSectionWidget(title: "BOTP Authenticator", children: [
        Container(
            padding: const EdgeInsets.symmetric(
                vertical: kAppPaddingBetweenItemLargeSize),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 120.0,
                width: 120.0,
                child: Image.asset("assets/images/temp/botp_temp.png",
                    scale: 1, fit: BoxFit.contain),
              )
            ])),
        const SettingsOptionWidget(
          label: "Version",
          value: "1.0.0",
          type: SettingsOptionType.labelAndValue,
        ),
        const SettingsOptionWidget(
          label: "Develop team",
          type: SettingsOptionType.labelAndValue,
          value: "Shinebright team",
        ),
      ]),
    ]);
  }
}
