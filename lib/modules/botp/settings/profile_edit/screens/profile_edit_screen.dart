import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/core/modules/settings/settings_repository.dart';
import 'package:botp_auth/modules/botp/settings/profile_edit/bloc/profile_edit_bloc.dart';
import 'package:botp_auth/modules/botp/settings/profile_edit/bloc/profile_edit_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: const ProfileEditBody());
  }
}

class ProfileEditBody extends StatefulWidget {
  const ProfileEditBody({Key? key}) : super(key: key);

  @override
  State<ProfileEditBody> createState() => _ProfileEditBodyState();
}

class _ProfileEditBodyState extends State<ProfileEditBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileEditBloc>(
        create: (context) =>
            ProfileEditBloc(settingsRepo: context.read<SettingsRepository>()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [_profile()]));
  }

  Widget _profile() {
    return BlocListener<ProfileEditBloc, ProfileEditState>(
        listener: (context, state) {
          final loadUserDataStatus = state.loadUserDataStatus;
          final formStatus = state.formStatus;
          if (loadUserDataStatus is LoadUserDataStatusFailed) {
            showSnackBar(context, loadUserDataStatus.exception.toString());
          } else if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(key: _formKey, child: Column(children: [])));
  }
}
