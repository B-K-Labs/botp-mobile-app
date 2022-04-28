import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/configs/routes/application.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/constants/common.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_bloc.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_state.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_event.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:botp_auth/utils/ui/toast.dart';
import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:botp_auth/widgets/field.dart';
import 'package:botp_auth/widgets/button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ImportScreen extends StatelessWidget {
  const ImportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScreenWidget(appBarElevation: 0, body: ImportBody());
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
    return BlocProvider<ImportBloc>(
        create: (context) => ImportBloc(
            authRepository: context.read<AuthenticationRepository>(),
            sessionCubit: context.read<SessionCubit>()),
        child: Container(
            padding: const EdgeInsets.symmetric(
                horizontal: kAppPaddingHorizontalSize),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_signInOtherForm()])));
  }

  Widget _signInOtherForm() {
    return BlocListener<ImportBloc, ImportState>(
        listener: (context, state) {
          final formStatus = state.formStatus;
          // final scanQrStatus = state.scanQrStatus;
          if (formStatus is RequestStatusFailed) {
            showSnackBar(context, formStatus.exception.toString());
          }
          // Hide QR Scan error
          // if (scanQrStatus is RequestStatusFailed) {
          //   showSnackBar(context, scanQrStatus.exception.toString());
          // }
        },
        child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: kAppPaddingVerticalSize),
                Text("Import existing account",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(height: 24.0),
                Text("Private key",
                    style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 12.0),
                _privateKeyField(),
                const SizedBox(height: 24.0),
                Text("Password", style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(height: 12.0),
                _passwordField(),
                const SizedBox(height: 24.0),
                _signInOtherButton(),
              ],
            )));
  }

  Widget _privateKeyField() {
    return BlocBuilder<ImportBloc, ImportState>(builder: (context, state) {
      _privateKeyValidator(value) => state.validatePrivateKey;
      _privateKeyOnChanged(value) => context
          .read<ImportBloc>()
          .add(ImportEventPrivateKeyChanged(privateKey: value));
      _onNavigateQrCode() async {
        final scannedPrivateKey = await Application.router
            .navigateTo(context, "/utils/qrScanner") as String?;
        context.read<ImportBloc>().add(
            ImportEventScanQRPrivateKey(scannedPrivateKey: scannedPrivateKey));
      }

      return FieldNormalWidget(
          textInputAction: TextInputAction.next,
          autofocus: true,
          controller: context.read<ImportBloc>().privateKeyController,
          hintText: "123xxxxxx",
          validator: _privateKeyValidator,
          onChanged: _privateKeyOnChanged,
          suffixIconData: Icons.qr_code_scanner,
          onTapSuffixIcon: _onNavigateQrCode);
    });
  }

  Widget _passwordField() {
    return BlocBuilder<ImportBloc, ImportState>(builder: (context, state) {
      _newPasswordValidator(value) => state.validateNewPassword;
      _newPasswordOnChanged(value) => context
          .read<ImportBloc>()
          .add(ImportEventNewPasswordChanged(newPassword: value));
      return FieldPasswordWidget(
          textInputAction: TextInputAction.done,
          hintText: "******",
          validator: _newPasswordValidator,
          onChanged: _newPasswordOnChanged);
    });
  }

  Widget _signInOtherButton() {
    return BlocBuilder<ImportBloc, ImportState>(builder: (context, state) {
      final onSignInOther = state.formStatus is RequestStatusSubmitting
          ? null
          : () {
              if (_formKey.currentState!.validate()) {
                context.read<ImportBloc>().add(ImportEventSubmitted());
              }
            };
      return ButtonNormalWidget(
        text: "Import account",
        onPressed: onSignInOther,
      );
    });
  }
}
