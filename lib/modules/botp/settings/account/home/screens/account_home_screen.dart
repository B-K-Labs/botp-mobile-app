import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_cubit.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_state.dart';
import 'package:fluro/fluro.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountHomeScreen extends StatelessWidget {
  const AccountHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Application.router.navigateTo(
                  context, "/botp/settings/account/updateKYC",
                  transition: TransitionType.inFromRight),
              icon: const Icon(Icons.edit))
        ]),
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
      if (state.loadUserData is! LoadUserDataStatusSuccessful) {
        return const CircularProgressIndicator();
      } else if (state.didKyc) {
        return Column(children: [
          Text(state.fullName!),
          Text(state.age!.toString()),
          Text(state.gender!),
          Text(state.debitor!),
        ]);
      } else {
        return const Text("Please f*cking do KYC");
      }
    });
  }

  Widget _account() {
    return BlocConsumer<ProfileViewCubit, ProfileViewState>(
        listener: (context, state) {},
        builder: (context, state) => Column(children: []));
  }
}
