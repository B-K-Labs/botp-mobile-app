import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import 'package:flutter/material.dart';
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
    return SingleChildScrollView(
        child: Column(children: [
      _account(),
      const DividerWidget(
          padding: EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize)),
      _session(),
    ]));
  }

  Widget _account() {
    return BlocBuilder<BOTPHomeCubit, BOTPHomeState>(builder: (context, state) {
      final String biometricStatus;
      dynamic onTapBiometricSetup = () {
        Application.router
            .navigateTo(context, "/botp/settings/security/setupBiometric");
      };
      switch (state.biometricSetupStatus) {
        case BiometricSetupStatus.unsupported:
          biometricStatus = "Unsupported";
          onTapBiometricSetup = null;
          break;
        case BiometricSetupStatus.notSetup:
          biometricStatus = "Not setup yet";
          break;
        case BiometricSetupStatus.disabled:
          biometricStatus = "Disabled";
          break;
        case BiometricSetupStatus.enabled:
        default:
          biometricStatus = "Enabled";
          onTapBiometricSetup = () {
            context.read<BOTPHomeCubit>().removeBiometricSetup();
          };
      }

      return SettingsSectionWidget(title: "Account security", children: [
        // const SettingsOptionWidget(
        //   label: "Change password",
        //   type: SettingsOptionType.labelNavigable,
        // ),
        SettingsOptionWidget(
          label: "Transfer account",
          type: SettingsOptionType.labelNavigable,
          navigateDescription: "Export/Import",
          onTap: () {
            Application.router
                .navigateTo(context, "/botp/settings/security/transfer");
          },
        ),
        SettingsOptionWidget(
          label: "Fingerprint authentication",
          type: SettingsOptionType.labelNavigable,
          navigateDescription: biometricStatus,
          onTap: onTapBiometricSetup,
        ),
        SettingsOptionWidget(
          label: "Delete your account",
          type: SettingsOptionType.labelNavigable,
          onTap: onDeleteAccount,
        ),
      ]);
    });
  }

  Widget _session() {
    Future<bool?> signOutConfirmation() => showModalBottomSheet<bool>(
        context: context,
        builder: (context) {
          final titleStyle = Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary);
          final descriptionStyle = Theme.of(context)
              .textTheme
              .bodySmall
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
                        style: titleStyle),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Your current account data would be kept.",
                        textAlign: TextAlign.center,
                      ),
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
                            style: descriptionStyle,
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

    onSignOut() async {
      // Wait for confirmation
      final signOutConfirmationResult = await signOutConfirmation();
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
        onTap: onSignOut,
      ),
    ]);
  }

  onDeleteAccount() async {
    // Wait for confirmation
    final deleteAccountResult = await deleteAccountConfirmation();
    // Perform action
    if (deleteAccountResult == true) {
      await context.read<SessionCubit>().signOutAndClearData();
      // Navigate to Session Screen
      Application.router.navigateTo(context, "/", clearStack: true);
    }
  }

  Future<bool?> deleteAccountConfirmation() => showModalBottomSheet<bool>(
      context: context,
      builder: (context) {
        final titleStyle = Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Theme.of(context).colorScheme.primary);

        return Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize,
                vertical: kAppPaddingVerticalSize),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Do you want to delete your account?",
                      style: titleStyle),
                  const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: const Text(
                      "Your account data would be permanently deleted. You won't be able to recover it.",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                  const ReminderWidget(
                    iconData: Icons.warning_rounded,
                    colorType: ColorType.error,
                    title: "Caution!",
                    description:
                        "Please make sure you've exported your account data before deleting it.",
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
                              text: "Delete account",
                              onPressed: () {
                                Application.router.pop(context, true);
                              },
                              type: ButtonNormalType.error))
                    ],
                  ),
                ]));
      });
}
