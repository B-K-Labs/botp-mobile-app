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
      const DividerWidget(
          padding: EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize)),
      _session(),
    ]);
  }

  Widget _account() {
    return SettingsSectionWidget(title: "Account security", children: [
      SettingsOptionWidget(
        label: "Change password",
        type: SettingsOptionType.labelNavigable,
      ),
      SettingsOptionWidget(
        label: "Transfer account",
        type: SettingsOptionType.labelNavigable,
      ),
      SettingsOptionWidget(
        label: "Fingerprint authentication",
        type: SettingsOptionType.labelNavigable,
        navigateDescription: "Not set up yet",
      ),
    ]);
  }

  Widget _session() {
    return SettingsSectionWidget(title: "Session", children: [
      SettingsOptionWidget(
        label: "Sign out",
        type: SettingsOptionType.buttonTextOneSide,
        buttonSideColorType: ColorType.error,
        onNavigate: signOut,
      ),
    ]);
  }

  signOut() {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200,
            color: Colors.amber,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Modal BottomSheet'),
                  ElevatedButton(
                    child: const Text('Close BottomSheet'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
          );
        });
  }
}
