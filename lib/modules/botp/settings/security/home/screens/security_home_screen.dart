import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/widgets/button.dart';
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
      const SettingsOptionWidget(
        label: "Change password",
        type: SettingsOptionType.labelNavigable,
      ),
      SettingsOptionWidget(
        label: "Transfer account",
        type: SettingsOptionType.labelNavigable,
        navigateDescription: "Export/Import",
        onTap: () {
          Application.router
              .navigateTo(context, "/botp/settings/security/transfer");
        },
      ),
      const SettingsOptionWidget(
        label: "Fingerprint authentication",
        type: SettingsOptionType.labelNavigable,
        navigateDescription: "Not set up yet",
      ),
    ]);
  }

  Widget _session() {
    Future<bool?> _signOutConfirmation() => showModalBottomSheet<bool>(
        context: context,
        builder: (context) {
          final _titleStyle = Theme.of(context)
              .textTheme
              .headline6
              ?.copyWith(color: Theme.of(context).colorScheme.primary);
          final _descriptionStyle = Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Theme.of(context).colorScheme.primary);

          return Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: kAppPaddingHorizontalSize,
                  vertical: kAppPaddingVerticalSize),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Are you sure you want to sign out?",
                        style: _titleStyle),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    SizedBox(
                      child: const Text(
                        "Your current account data would be kept.",
                        textAlign: TextAlign.center,
                      ),
                      width: MediaQuery.of(context).size.width * 0.8,
                    ),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    ReminderWidget(
                      iconData: Icons.warning_rounded,
                      colorType: ColorType.error,
                      title: "Caution!",
                      description:
                          "You won't be able to sign in if you forgot your password. Remember that you've saved this account.",
                      child: GestureDetector(
                          onTap: () {
                            Application.router.navigateTo(
                                context, "/botp/settings/security/transfer",
                                replace: true);
                          },
                          child: Text(
                            "If you haven't yet, click here to export your account",
                            style: _descriptionStyle,
                          )),
                    ),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                            flex: 1,
                            child: ButtonNormalWidget(
                                text: "Cancel",
                                onPressed: () {
                                  Application.router.pop(context, false);
                                },
                                type: ButtonNormalType.secondaryOutlined)),
                        const SizedBox(width: kAppPaddingBetweenItemSmallSize),
                        Expanded(
                            flex: 1,
                            child: ButtonNormalWidget(
                                text: "Sign out",
                                onPressed: () {
                                  Application.router.pop(context, true);
                                },
                                type: ButtonNormalType.error))
                      ],
                    ),
                  ]));
        });

    _onSignOut() async {
      // Wait for confirmation
      final signOutConfirmationResult = await _signOutConfirmation();
      // Perform action
      if (signOutConfirmationResult == true) {
        await context.read<SessionCubit>().signOut();
        // Navigate to Session Screen
        Application.router.navigateTo(context, "/", clearStack: true);
      }
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
