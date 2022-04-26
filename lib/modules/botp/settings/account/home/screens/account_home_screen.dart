import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_cubit.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_state.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/setting.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountHomeScreen extends StatelessWidget {
  const AccountHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget.generate(context, title: "Accounts"),
        body: const AccountHomeBody());
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
        create: (context) => ProfileViewCubit(),
        child: Column(children: [
          _profile(),
          const SizedBox(height: 20),
          _account(),
        ]));
  }

  Widget _profile() {
    return BlocBuilder<ProfileViewCubit, ProfileViewState>(
        builder: (context, state) {
      if (state.loadUserData is! LoadUserDataStatusSuccess) {
        return const CircularProgressIndicator();
      } else if (state.didKyc) {
        return Column(children: [
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
        return const Text("Please f*cking do KYC");
      }
    });
  }

  Widget _account() {
    return BlocConsumer<ProfileViewCubit, ProfileViewState>(
        listener: (context, state) {},
        builder: (context, state) => Column(children: const []));
  }
}
