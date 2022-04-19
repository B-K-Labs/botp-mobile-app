import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_bloc.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_state.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_event.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          elevation: 0,
        ),
        body: const SafeArea(bottom: true, child: ImportBody()));
  }
}

class ImportBody extends StatefulWidget {
  const ImportBody({Key? key}) : super(key: key);

  @override
  _ImportBodyState createState() => _ImportBodyState();
}

class _ImportBodyState extends State<ImportBody> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInOtherBloc>(
        create: (context) => SignInOtherBloc(
            authRepository: context.read<AuthRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [_signInOtherForm(context), _otherOptions()]));
  }

  Widget _signInOtherForm(context) {
    return BlocListener<SignInOtherBloc, SignInOtherState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          }
        },
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // const SizedBox(height: 36.0),
                Text("Import an existing account",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 72.0),
                Text("Private key",
                    style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 12.0),
                _privateKeyField(),
                const SizedBox(height: 24.0),
                Text("Password", style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(height: 12.0),
                _passwordField(),
                const SizedBox(height: 36.0),
                _signInOtherButton(),
              ],
            )));
  }

  Widget _privateKeyField() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      _privateKeyValidator(value) => state.validatePrivateKey;
      _privateKeyOnChanged(value) => context
          .read<SignInOtherBloc>()
          .add(SignInOtherPrivateKeyChanged(privateKey: value));
      _onNavigateQrCode() => null;
      return FieldNormalWidget(
          hintText: "123xxxxxx",
          validator: _privateKeyValidator,
          onChanged: _privateKeyOnChanged,
          suffixIconData: Icons.qr_code,
          onTapSuffixIcon: _onNavigateQrCode);
    });
  }

  Widget _passwordField() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      _newPasswordValidator(value) => state.validateNewPassword;
      _newPasswordOnChanged(value) => context
          .read<SignInOtherBloc>()
          .add(SignInOtherNewPasswordChanged(newPassword: value));
      return FieldPasswordWidget(
          hintText: "******",
          validator: _newPasswordValidator,
          onChanged: _newPasswordOnChanged);
    });
  }

  Widget _signInOtherButton() {
    return BlocBuilder<SignInOtherBloc, SignInOtherState>(
        builder: (context, state) {
      final onSignInOther = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<SignInOtherBloc>().add(SignInOtherSubmitted());
              }
            };
      return ButtonNormalWidget(
        text: "Import account",
        onPressed: onSignInOther,
      );
    });
  }

  Widget _otherOptions() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 60.0),
        ButtonTextWidget(
          text: "Sign in with current account",
          onPressed: () {
            Application.router.navigateTo(context, "/auth/signIn");
          },
        ),
        const SizedBox(height: 12.0),
        ButtonTextWidget(
          text: "Create new account",
          onPressed: () {
            Application.router.navigateTo(context, "/auth/signUp");
          },
        ),
      ],
    );
  }
}
