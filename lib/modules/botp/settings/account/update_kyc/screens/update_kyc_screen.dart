import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/constants/theme.dart';
import 'package:botp_auth/modules/botp/settings/account/update_kyc/bloc/update_kyc_bloc.dart';
import 'package:botp_auth/modules/botp/settings/account/update_kyc/bloc/update_kyc_event.dart';
import 'package:botp_auth/modules/botp/settings/account/update_kyc/bloc/update_kyc_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountUpdateKYCScreen extends StatelessWidget {
  const AccountUpdateKYCScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileEditBloc>(
        create: (context) =>
            ProfileEditBloc(settingsRepo: context.read<SettingsRepository>()),
        child: Scaffold(appBar: AppBar(), body: const AccountUpdateKYCBody()));
  }
}

class AccountUpdateKYCBody extends StatefulWidget {
  const AccountUpdateKYCBody({Key? key}) : super(key: key);

  @override
  State<AccountUpdateKYCBody> createState() => _AccountUpdateKYCBodyState();
}

class _AccountUpdateKYCBodyState extends State<AccountUpdateKYCBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
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
          } else if (formStatus is RequestStatusSuccessful) {
            showSnackBar(context, "Update profile successfully");
            Application.router.pop(context);
          }
        },
        child: Form(
            key: _formKey,
            child: Column(children: [
              const SizedBox(height: kAppPaddingTopSize),
              _fullName(),
              _age(),
              _gender(),
              _debitor(),
              _editProfileButton(),
            ])));
  }

  Widget _fullName() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
      _fullNameValidator(value) => state.validateFullName;
      _fullNameOnChanged(value) => context
          .read<ProfileEditBloc>()
          .add(ProfileEditEventFullNameChanged(value));
      return FieldNormalWidget(
          hintText: "Harry Jayson",
          validator: _fullNameValidator,
          onChanged: _fullNameOnChanged,
          initialValue: state.fullName);
    });
  }

  Widget _age() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
      _ageValidator(value) => state.validateAge;
      _ageOnChanged(value) => context
          .read<ProfileEditBloc>()
          .add(ProfileEditEventAgeChanged(value));
      return FieldNormalWidget(
          hintText: "18",
          validator: _ageValidator,
          onChanged: _ageOnChanged,
          initialValue: state.age?.toString());
    });
  }

  Widget _gender() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
      _genderValidator(value) => state.validateAge;
      _genderOnChanged(value) => context
          .read<ProfileEditBloc>()
          .add(ProfileEditEventGenderChanged(value));
      return FieldNormalWidget(
          hintText: "Male",
          validator: _genderValidator,
          onChanged: _genderOnChanged,
          initialValue: state.gender);
    });
  }

  Widget _debitor() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
      _debitorValidator(value) => state.validateAge;
      _debitorOnChanged(value) => context
          .read<ProfileEditBloc>()
          .add(ProfileEditEventDebitorChanged(value));
      return FieldNormalWidget(
          hintText: "999-999-9999",
          validator: _debitorValidator,
          onChanged: _debitorOnChanged,
          initialValue: state.gender);
    });
  }

  Widget _editProfileButton() {
    return BlocBuilder<ProfileEditBloc, ProfileEditState>(
        builder: (context, state) {
      final onProfileEdit = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context
                    .read<ProfileEditBloc>()
                    .add(ProfileEditEventSubmitted());
              }
            };
      return ButtonNormalWidget(
        text: "Update profile",
        onPressed: onProfileEdit,
      );
    });
  }
}
