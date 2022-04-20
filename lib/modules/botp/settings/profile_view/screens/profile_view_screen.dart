import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/modules/botp/settings/profile_edit/screens/profile_edit_screen.dart';
import 'package:botp_auth/modules/botp/settings/profile_view/cubit/profile_view_cubit.dart';
import 'package:botp_auth/modules/botp/settings/profile_view/cubit/profile_view_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfileEditScreen())),
              icon: const Icon(Icons.edit))
        ]),
        body: const ProfileViewBody());
  }
}

class ProfileViewBody extends StatefulWidget {
  const ProfileViewBody({Key? key}) : super(key: key);

  @override
  State<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends State<ProfileViewBody> {
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
