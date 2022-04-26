import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/constants/routing_param.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/bloc/kyc_setup_bloc.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/bloc/kyc_setup_event.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/bloc/kyc_setup_state.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:botp_auth/widgets/field.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSetupKYCScreen extends StatelessWidget {
  final FromScreen? from;

  const AccountSetupKYCScreen({Key? key, this.from}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountSetupKYCBloc>(
        create: (context) => AccountSetupKYCBloc(
            settingsRepository: context.read<SettingsRepository>()),
        child: Scaffold(
            appBar: from == FromScreen.authReminderKYCSetup
                ? null
                : AppBarWidget.generate(context, title: "Setup KYC"),
            body: SafeArea(
                bottom: true, child: AccountSetupKYCBody(from: from))));
  }
}

class AccountSetupKYCBody extends StatefulWidget {
  const AccountSetupKYCBody({Key? key, this.from}) : super(key: key);

  final FromScreen? from;

  @override
  State<AccountSetupKYCBody> createState() => _AccountSetupKYCBodyState();
}

class _AccountSetupKYCBodyState extends State<AccountSetupKYCBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            const EdgeInsets.symmetric(horizontal: kAppPaddingHorizontalSize),
        child: _profile());
  }

  Widget _profile() {
    return BlocListener<AccountSetupKYCBloc, AccountSetupKYCState>(
        listener: (context, state) {
          final loadUserDataStatus = state.loadUserDataStatus;
          final formStatus = state.formStatus;
          if (loadUserDataStatus is LoadUserDataStatusFailed) {
            showSnackBar(context, loadUserDataStatus.exception.toString());
          } else if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          } else if (formStatus is RequestStatusSuccess) {
            if (widget.from != FromScreen.authReminderKYCSetup) {
              showSnackBar(context, "Update profile successfully");
            }
            Application.router.pop(context);
          }
        },
        child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                        const SizedBox(height: kAppPaddingTopSize),
                        Text("Full name",
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(height: 12.0),
                        _fullNameField(),
                        const SizedBox(height: 24.0),
                        Text("Address",
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(height: 12.0),
                        _addressField(),
                        const SizedBox(height: 24.0),
                        Row(children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Age",
                                  style: Theme.of(context).textTheme.bodyText1),
                              const SizedBox(height: 12.0),
                              _ageField(),
                            ],
                          )),
                          const SizedBox(
                              width: kAppPaddingBetweenItemSmallSize),
                          Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                Text("Gender",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                                const SizedBox(height: 12.0),
                                _genderField(),
                              ]))
                        ]),
                        const SizedBox(height: 24.0),
                        Text("Phone number",
                            style: Theme.of(context).textTheme.bodyText1),
                        const SizedBox(height: 12.0),
                        _debitorField(),
                      ]))),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: kAppPaddingBottomSize),
                      child: Column(children: [
                        Row(
                          children: [
                            Expanded(child: _cancelProfileButton()),
                            const SizedBox(
                                width: kAppPaddingBetweenItemSmallSize),
                            Expanded(child: _editProfileButton()),
                          ],
                        ),
                      ]))
                ])));
  }

  Widget _fullNameField() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      _fullNameValidator(value) => state.validateFullName;
      _fullNameOnChanged(value) => context
          .read<AccountSetupKYCBloc>()
          .add(AccountSetupKYCEventFullNameChanged(value));
      return FieldNormalWidget(
          textInputAction: TextInputAction.next,
          autofocus: true,
          hintText: "Harry Jayson",
          validator: _fullNameValidator,
          onChanged: _fullNameOnChanged);
    });
  }

  Widget _addressField() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      _addressValidator(value) => state.validateFullName;
      _addressOnChanged(value) => context
          .read<AccountSetupKYCBloc>()
          .add(AccountSetupKYCEventAddressChanged(value));
      return FieldNormalWidget(
          textInputAction: TextInputAction.next,
          hintText: "District 10, HCM, Viet Nam",
          validator: _addressValidator,
          onChanged: _addressOnChanged);
    });
  }

  Widget _ageField() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      _ageValidator(value) => state.validateAge;
      _ageOnChanged(value) => context
          .read<AccountSetupKYCBloc>()
          .add(AccountSetupKYCEventAgeChanged(value));
      return FieldNormalWidget(
          textInputAction: TextInputAction.next,
          hintText: "18",
          validator: _ageValidator,
          onChanged: _ageOnChanged);
    });
  }

  Widget _genderField() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      _genderValidator(value) => state.validateAge;
      _genderOnChanged(value) => context
          .read<AccountSetupKYCBloc>()
          .add(AccountSetupKYCEventGenderChanged(value));
      return FieldNormalWidget(
          textInputAction: TextInputAction.next,
          hintText: "Male",
          validator: _genderValidator,
          onChanged: _genderOnChanged);
    });
  }

  Widget _debitorField() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      _debitorValidator(value) => state.validateAge;
      _debitorOnChanged(value) => context
          .read<AccountSetupKYCBloc>()
          .add(AccountSetupKYCEventDebitorChanged(value));
      return FieldNormalWidget(
          textInputAction: TextInputAction.done,
          hintText: "999-999-9999",
          validator: _debitorValidator,
          onChanged: _debitorOnChanged);
    });
  }

  Widget _cancelProfileButton() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      final onCancelEdit = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              Application.router.pop(context, false);
            };
      return ButtonNormalWidget(
        text: "I'll do later",
        type: ButtonNormalType.secondaryOutlined,
        onPressed: onCancelEdit,
      );
    });
  }

  Widget _editProfileButton() {
    return BlocBuilder<AccountSetupKYCBloc, AccountSetupKYCState>(
        builder: (context, state) {
      final onProfileEdit = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context
                    .read<AccountSetupKYCBloc>()
                    .add(AccountSetupKYCEventSubmitted());
              }
            };
      return ButtonNormalWidget(
        text: "Setup KYC",
        onPressed: onProfileEdit,
      );
    });
  }
}
