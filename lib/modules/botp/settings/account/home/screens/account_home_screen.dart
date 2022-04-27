import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_cubit.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountHomeScreen extends StatelessWidget {
  const AccountHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(appBarTitle: "Account", body: AccountHomeBody());
  }
}

class AccountHomeBody extends StatefulWidget {
  const AccountHomeBody({Key? key}) : super(key: key);

  @override
  State<AccountHomeBody> createState() => _AccountHomeBodyState();
}

class _AccountHomeBodyState extends State<AccountHomeBody> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ProfileViewCubit(
            settingsRepository: context.read<SettingsRepository>()),
        child: Column(children: [
          reminder(),
          _account(),
          const DividerWidget(
              padding:
                  EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize)),
          _profile(),
        ]));
  }

  Widget reminder() {
    return BlocBuilder<ProfileViewCubit, ProfileViewState>(
        builder: (context, state) =>
            state.loadUserData is LoadUserDataStatusSuccess && !state.didKyc
                ? Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: kAppPaddingHorizontalSize,
                        vertical: kAppPaddingVerticalSize),
                    child: ReminderWidget(
                      iconData: Icons.verified_outlined,
                      colorType: ColorType.primary,
                      title: "You're almost done!",
                      description:
                          "BOTP Auth need to know you. Enter your information here to use the authenticator!",
                      onTap: () async {
                        final setUpKycResult = await Application.router
                                .navigateTo(
                                    context, "/botp/settings/account/setupKyc")
                            as bool?;
                        if (setUpKycResult == true) {
                          showSnackBar(context, "Update profile successfully",
                              SnackBarType.success);
                        }
                      },
                    ))
                : Container());
  }

  Widget _account() {
    return BlocConsumer<ProfileViewCubit, ProfileViewState>(
        listener: (context, state) {
      // Copy bcAddress
      final copyBcAddressStatus = state.copyBcAddressStatus;
      if (copyBcAddressStatus is SetClipboardStatusSuccess) {
        showSnackBar(
            context, "Blockchain address copied.", SnackBarType.success);
      } else if (copyBcAddressStatus is SetClipboardStatusFailed) {
        showSnackBar(context, copyBcAddressStatus.exception.toString());
      }
    }, builder: (context, state) {
      if (state.loadUserData is! LoadUserDataStatusSuccess) {
        return const CircularProgressIndicator();
      } else {
        return SettingsSectionWidget(title: "Account info", children: [
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndCustomWidget,
              label: "Blockchain address",
              customWidget: BcAddressWidget(
                  bcAddress: state.bcAddress!,
                  onTap: () {
                    context.read<ProfileViewCubit>().copyBcAddress();
                  })),
          SettingsOptionWidget(
            type: SettingsOptionType.buttonTextOneSide,
            buttonSide: OptionButtonOneSide.left,
            label: "Add new agent by scanning QR",
            onTap: () async {
              final data = await Application.router
                  .navigateTo(context, "/utils/qrScanner") as String?;
              if (data != null) {
                final result =
                    await context.read<ProfileViewCubit>().setupAgent(data);
                if (result == null) {
                  showSnackBar(context, "Failed to add new agent.");
                } else {
                  // showSnackBar(context, "Added new agent successfully.",
                  //     SnackBarType.success);
                  Application.router.navigateTo(
                      context, "/botp/settings/account/agentInfo",
                      routeSettings:
                          RouteSettings(arguments: result.agentInfo));
                }
              }
            },
          ),
        ]);
      }
    });
  }

  Widget _profile() {
    return BlocBuilder<ProfileViewCubit, ProfileViewState>(
        builder: (context, state) {
      if (state.loadUserData is! LoadUserDataStatusSuccess) {
        return const CircularProgressIndicator();
      } else if (state.didKyc) {
        return SettingsSectionWidget(title: "KYC Info", children: [
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndValue,
              label: "Name",
              value: state.fullName!),
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndValue,
              label: "Address",
              value: state.address!),
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndValue,
              label: "Age",
              value: state.age!.toString()),
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndValue,
              label: "Gender",
              value: state.gender!),
          SettingsOptionWidget(
              type: SettingsOptionType.labelAndValue,
              label: "Phone number",
              value: state.debitor!),
        ]);
      } else {
        // Return nothing
        return Container();
      }
    });
  }
}
