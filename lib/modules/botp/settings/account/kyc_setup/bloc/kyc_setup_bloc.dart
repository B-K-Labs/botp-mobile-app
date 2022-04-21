import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/bloc/kyc_setup_event.dart';
import 'package:botp_auth/modules/botp/settings/account/kyc_setup/bloc/kyc_setup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountSetupKYCBloc
    extends Bloc<AccountSetupKYCEvent, AccountSetupKYCState> {
  SettingsRepository settingsRepository;
  bool _isSubmitting = false;

  AccountSetupKYCBloc({required this.settingsRepository})
      : super(AccountSetupKYCState()) {
    // On changed
    on<AccountSetupKYCEventFullNameChanged>(
        (event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<AccountSetupKYCEventAddressChanged>(
        (event, emit) => emit(state.copyWith(address: event.address)));
    on<AccountSetupKYCEventAgeChanged>(
        (event, emit) => emit(state.copyWith(age: event.age)));
    on<AccountSetupKYCEventGenderChanged>(
        (event, emit) => emit(state.copyWith(gender: event.gender)));
    on<AccountSetupKYCEventDebitorChanged>(
        (event, emit) => emit(state.copyWith(debitor: event.debitor)));

    // On submitted
    on<AccountSetupKYCEventSubmitted>((event, emit) async {
      if (_isSubmitting) return;
      _isSubmitting = true;
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      final accountData = await UserData.getCredentialAccountData();
      final profileData = await UserData.getCredentialProfileData();
      final kycData = await UserData.getCredentialKYCData();
      try {
        final updateKycResult = await settingsRepository.updateKyc(
            accountData!.bcAddress,
            accountData.password,
            state.fullName!,
            state.address!,
            int.parse(state.age!),
            state.gender!,
            state.debitor!);
        UserData.setCredentialProfileData(true, profileData!.avatarUrl);
        UserData.setCredentialKYCData(state.fullName!, state.address!,
            int.parse(state.age!), state.gender!, state.debitor!);
        emit(state.copyWith(formStatus: RequestStatusSuccessful()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
      _isSubmitting = false;
    });
  }
}
