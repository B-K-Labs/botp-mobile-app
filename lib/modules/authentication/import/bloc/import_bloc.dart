import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_event.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_state.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final AuthenticationRepository authRepository;
  final SessionCubit sessionCubit;
  bool _isSubmitting = false;
  // Controller
  final privateKeyController = TextEditingController();

  ImportBloc({required this.authRepository, required this.sessionCubit})
      : super(ImportState()) {
    // On changed

    String getMagicPrivateKeyIfExist() {
      if (state.privateKey.trim() == dotenv.env["USER_TEST"]) {
        return dotenv.env["USER_TEST_PRIVATE_KEY"] ?? state.privateKey;
      } else {
        return state.privateKey;
      }
    }

    on<ImportEventPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<ImportEventNewPasswordChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPassword)));

    // On submitted
    on<ImportEventSubmitted>((event, emit) async {
      if (_isSubmitting) return;
      _isSubmitting = true;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final importResult = await authRepository.import(
            getMagicPrivateKeyIfExist(), state.newPassword);
        // Launch session
        await sessionCubit.saveNewSessionFromImport(
            importResult.bcAddress,
            importResult.publicKey,
            getMagicPrivateKeyIfExist(),
            state.newPassword,
            importResult.avatarUrl,
            importResult.userKyc);
        // Launch session
        await sessionCubit.remindSettingUpAndLaunchSession();
        emit(state.copyWith(formStatus: RequestStatusSuccess()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
      emit(state.copyWith(formStatus: const RequestStatusInitial()));
      _isSubmitting = false;
    });

    // Scan qr
    on<ImportEventScanQRPrivateKey>((event, emit) {
      emit(state.copyWith(scanQrStatus: RequestStatusSubmitting()));
      final scannedPrivateKey = event.scannedPrivateKey;
      if (scannedPrivateKey == null) {
        emit(state.copyWith(
            scanQrStatus: RequestStatusFailed(
                Exception("Could not scan your private key."))));
      } else {
        emit(state.copyWith(
            privateKey: scannedPrivateKey,
            scanQrStatus: RequestStatusSuccess()));
        privateKeyController.text = scannedPrivateKey;
      }
      emit(state.copyWith(scanQrStatus: const RequestStatusInitial()));
    });
  }
}
