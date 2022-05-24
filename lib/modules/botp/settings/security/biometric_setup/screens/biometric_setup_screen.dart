import 'package:botp_auth/common/states/biometric_auth_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/settings/security/biometric_setup/cubit/biometric_setup_cubit.dart';
import 'package:botp_auth/modules/botp/settings/security/biometric_setup/cubit/biometric_setup_state.dart';
import 'package:botp_auth/widgets/biometric.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityBiometricSetupScreen extends StatelessWidget {
  final FromScreen fromScreen;
  const SecurityBiometricSetupScreen({Key? key, required this.fromScreen})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        hasAppBar: false, body: SecurityBiometricSetupBody(fromScreen));
  }
}

class SecurityBiometricSetupBody extends StatefulWidget {
  final FromScreen fromScreen;
  const SecurityBiometricSetupBody(this.fromScreen, {Key? key})
      : super(key: key);

  @override
  State<SecurityBiometricSetupBody> createState() =>
      _SecurityBiometricSetupBodyState();
}

class _SecurityBiometricSetupBodyState
    extends State<SecurityBiometricSetupBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SecurityBiometricSetupCubit()..setupBiometric(),
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize),
            child: _biometricSetup()));
  }

  Widget _biometricSetup() {
    return BlocConsumer<SecurityBiometricSetupCubit,
        SecurityBiometricSetupState>(listener: (context, state) {
      final setupBiometricStatus = state.setupBiometricStatus;
      if (setupBiometricStatus is BiometricAuthStatusSuccess) {
        // Update settings data
        context.read<BOTPHomeCubit>().reloadCommonData();
      }
    }, builder: (context, state) {
      final setupBiometricStatus = state.setupBiometricStatus;
      if (setupBiometricStatus is BiometricAuthStatusInitial) {
        return Container();
      } else if (setupBiometricStatus is BiometricAuthStatusSubmitting) {
        return Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
            Text("Follow the instruction.",
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            Text("Setting up your biometric",
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(color: Theme.of(context).colorScheme.primary),
                textAlign: TextAlign.center),
          ]),
          Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [Center(child: CircularProgressIndicator())]),
        ]);
      } else if (setupBiometricStatus is BiometricAuthStatusFailed) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(children: [
                BiometricSetupStatusWidget(
                    isSuccess: false,
                    message: setupBiometricStatus.exception.toString())
              ])),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: kAppPaddingVerticalSize),
                  child: Row(
                    children: [
                      Expanded(
                          child: ButtonNormalWidget(
                              type: ButtonNormalType.secondaryOutlined,
                              text: widget.fromScreen ==
                                      FromScreen.botpSettingsSecurity
                                  ? "Cancel"
                                  : "Do later",
                              onPressed: () {
                                if (widget.fromScreen ==
                                    FromScreen.botpSettingsSecurity) {
                                  Application.router.pop(context);
                                } else {
                                  Application.router.navigateTo(context, "/");
                                  context
                                      .read<SessionCubit>()
                                      .remindSettingUpAndLaunchSession(
                                          skipSetupBiometric: true);
                                }
                              })),
                      const SizedBox(width: kAppPaddingBetweenItemSmallSize),
                      Expanded(
                          child: ButtonNormalWidget(
                              text: "Try again",
                              onPressed: () {
                                // Run again
                                context
                                    .read<SecurityBiometricSetupCubit>()
                                    .setupBiometric();
                              })),
                    ],
                  ))
            ]);
      } else {
        return widget.fromScreen == FromScreen.botpSettingsSecurity
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                    const Expanded(
                        child: BiometricSetupStatusWidget(
                            isSuccess: true,
                            message:
                                "You can use biometric authentication in the next sign in.")),
                    Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: kAppPaddingVerticalSize),
                        child: ButtonNormalWidget(
                            text: "Go back",
                            onPressed: () {
                              Application.router.pop(context);
                            }))
                  ])
            : Container();
      }
    });
  }
}
