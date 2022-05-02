import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_cubit.dart';
import 'package:botp_auth/modules/botp/settings/account/agent_setup/cubit/agent_setup_cubit.dart';
import 'package:botp_auth/modules/botp/settings/account/agent_setup/cubit/agent_setup_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountAgentSetupScreen extends StatelessWidget {
  const AccountAgentSetupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(hasAppBar: false, body: AccountAgentSetupBody());
  }
}

class AccountAgentSetupBody extends StatefulWidget {
  const AccountAgentSetupBody({Key? key}) : super(key: key);

  @override
  State<AccountAgentSetupBody> createState() => _AccountAgentSetupBodyState();
}

class _AccountAgentSetupBodyState extends State<AccountAgentSetupBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AccountAgentSetupCubit(
            settingsRepository: context.read<SettingsRepository>()),
        child: BlocListener<AccountAgentSetupCubit, AccountAgentSetupState>(
            listener: (context, state) {
              // Update user info
              final setupAgentStatus = state.setupAgentStatus;
              if (setupAgentStatus is RequestStatusSuccess) {
                context.read<BOTPHomeCubit>().loadCommonUserData();
              }
              // Copy address
              final copyBcAddressStatus = state.copyBcAddressStatus;
              if (copyBcAddressStatus is SetClipboardStatusSuccess) {
                showSnackBar(context, "Blockchain address copied.",
                    SnackBarType.success);
              } else if (state.copyBcAddressStatus
                  is SetClipboardStatusFailed) {
                showSnackBar(context, "Failed to copy blockchain address.");
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: kAppPaddingHorizontalSize),
                child: _agentSetup())));
  }

  Widget _agentSetup() {
    return BlocBuilder<AccountAgentSetupCubit, AccountAgentSetupState>(
        builder: (context, state) {
      if (state.setupAgentStatus is RequestStatusInitial) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
                    Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text("Add new agent",
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary))),
                    const SizedBox(height: kAppPaddingBetweenItemNormalSize),
                    const Text(
                        "Register your favorite agent to your BOTP Authenticator now!"),
                    Expanded(
                        child: Center(
                            child: SizedBox(
                      height: 120.0,
                      width: 120.0,
                      child: Image.asset("assets/images/temp/botp_temp.png",
                          scale: 1, fit: BoxFit.contain),
                    ))),
                  ])),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: kAppPaddingVerticalSize),
                  child: Row(
                    children: [
                      Expanded(
                          child: ButtonNormalWidget(
                              type: ButtonNormalType.secondaryOutlined,
                              text: "Cancel",
                              onPressed: () {
                                Application.router.pop(context);
                              })),
                      const SizedBox(width: kAppPaddingBetweenItemSmallSize),
                      Expanded(
                          child: ButtonNormalWidget(
                              text: "Scan QR",
                              onPressed: () async {
                                final scannedSetupAgentUrl = await Application
                                        .router
                                        .navigateTo(context, "/utils/qrScanner")
                                    as String?;
                                if (scannedSetupAgentUrl != null) {
                                  context
                                      .read<AccountAgentSetupCubit>()
                                      .setupAgent(scannedSetupAgentUrl);
                                }
                              })),
                    ],
                  ))
            ]);
      } else if (state.setupAgentStatus is RequestStatusSubmitting) {
        return Stack(children: [
          Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
            Text("It would take a bit!",
                style: Theme.of(context).textTheme.bodyText2,
                textAlign: TextAlign.center),
            const SizedBox(height: kAppPaddingBetweenItemSmallSize),
            Text("Setting up your agent.",
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
      } else if (state.setupAgentStatus is RequestStatusFailed) {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(children: [
                const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
                Text("Couldn't add your agent. Please try again.",
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                Text("Somethings went wrong.",
                    style: Theme.of(context)
                        .textTheme
                        .headline5
                        ?.copyWith(color: Theme.of(context).colorScheme.error)),
                Expanded(
                    child: Center(
                        child: SizedBox(
                  height: 120.0,
                  width: 120.0,
                  child: Image.asset(
                      "assets/images/logo/botp_logo_disabled.png",
                      scale: 1,
                      fit: BoxFit.contain),
                ))),
              ])),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: kAppPaddingVerticalSize),
                  child: Row(
                    children: [
                      Expanded(
                          child: ButtonNormalWidget(
                              type: ButtonNormalType.secondaryOutlined,
                              text: "Cancel",
                              onPressed: () {
                                Application.router.pop(context);
                              })),
                      const SizedBox(width: kAppPaddingBetweenItemSmallSize),
                      Expanded(
                          child: ButtonNormalWidget(
                              text: "Try again",
                              onPressed: () async {
                                final scannedSetupAgentUrl = await Application
                                        .router
                                        .navigateTo(context, "/utils/qrScanner")
                                    as String?;
                                if (scannedSetupAgentUrl != null) {
                                  context
                                      .read<AccountAgentSetupCubit>()
                                      .setupAgent(scannedSetupAgentUrl);
                                }
                              })),
                    ],
                  ))
            ]);
      } else {
        return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      child: Column(children: [
                const SizedBox(height: kAppPaddingTopWithoutAppBarSize),
                Text("Here is the agent detail.",
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: kAppPaddingBetweenItemSmallSize),
                Text("Added agent successfully!",
                    style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: kAppPaddingBetweenItemVeryLargeSize),
                AgentInfoWidget(
                    agentInfo: state.agentInfo!,
                    opTapBcAddress: () async {
                      context.read<AccountAgentSetupCubit>().copyBcAddress();
                    })
              ]))),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: kAppPaddingVerticalSize),
                  child: ButtonNormalWidget(
                      text: "Go back",
                      onPressed: () {
                        Application.router.pop(context);
                      }))
            ]);
      }
    });
  }
}
