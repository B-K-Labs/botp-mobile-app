import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/common/repositories/authentication_repository.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_event.dart';
import 'package:botp_auth/modules/authentication/import/bloc/import_state.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/authentication/session/cubit/session_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:botp_auth/common/states/request_status.dart';

class ImportBloc extends Bloc<ImportEvent, ImportState> {
  final AuthenticationRepository authRepository;
  final SessionCubit sessionCubit;
  bool _isSubmitting = false;

  ImportBloc({required this.authRepository, required this.sessionCubit})
      : super(ImportState()) {
    // On changed
    on<ImportPrivateKeyChanged>(
        (event, emit) => emit(state.copyWith(privateKey: event.privateKey)));
    on<ImportNewPasswordChanged>(
        (event, emit) => emit(state.copyWith(newPassword: event.newPassword)));

    // On submitted
    on<ImportSubmitted>((event, emit) async {
      if (_isSubmitting) return;
      _isSubmitting = true;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      try {
        final importResult =
            await authRepository.import(state.privateKey, state.newPassword);
        // Store account data
        UserData.setCredentialSessionData(UserDataSession.authenticated);
        UserData.setCredentialAccountData(importResult.bcAddress,
            importResult.publicKey, state.privateKey, state.newPassword);
        final userKyc = importResult.userKyc;
        // If KYC, save data; Else, remind user
        final didKyc = userKyc != null;
        if (userKyc != null) {
          UserData.setCredentialKYCData(userKyc.fullName, userKyc.address,
              userKyc.age, userKyc.gender, userKyc.debitor);
        }
        UserData.setCredentialProfileData(didKyc, null);
        sessionCubit.launchSession(skipSetupKyc: didKyc);
        emit(state.copyWith(formStatus: RequestStatusSuccessful()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
      _isSubmitting = false;
    });
  }
}
