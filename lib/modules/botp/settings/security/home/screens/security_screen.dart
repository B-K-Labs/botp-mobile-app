import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityHomeScreen extends StatelessWidget {
  const SecurityHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(
        appBarTitle: "Security", body: SecurityHomeBody());
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
    _onSignOut() async {
      print("Sign out");
      await context.read<SessionCubit>().signOut();
      // Navigate to Session Screen itself instead
      Application.router.navigateTo(context, "/");
    }

    return SettingsSectionWidget(title: "Session", children: [
      SettingsOptionWidget(
        label: "Sign out",
        type: SettingsOptionType.buttonTextOneSide,
        buttonSideColorType: ColorType.error,
        onTap: _onSignOut,
      ),
    ]);
  }
}
