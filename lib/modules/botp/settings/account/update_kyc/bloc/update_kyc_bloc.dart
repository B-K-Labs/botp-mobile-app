import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/account/update_kyc/bloc/update_kyc_event.dart';
import 'package:botp_auth/modules/botp/settings/account/update_kyc/bloc/update_kyc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountUpdateKYCBloc
    extends Bloc<AccountUpdateKYCEvent, AccountUpdateKYCState> {
  SettingsRepository settingsRepo;

  AccountUpdateKYCBloc({required this.settingsRepo})
      : super(AccountUpdateKYCState()) {
    // On changed
    on<AccountUpdateKYCEventFullNameChanged>(
        (event, emit) => emit(state.copyWith(fullName: event.fullName)));
    on<AccountUpdateKYCEventAgeChanged>(
        (event, emit) => emit(state.copyWith(age: event.age)));
    on<AccountUpdateKYCEventGenderChanged>(
        (event, emit) => emit(state.copyWith(gender: event.gender)));
    on<AccountUpdateKYCEventDebitorChanged>(
        (event, emit) => emit(state.copyWith(debitor: event.debitor)));

    // On submitted
    on<AccountUpdateKYCEventSubmitted>((event, emit) async {
      emit(state.copyWith(formStatus: RequestStatusSubmitting()));
      final accountData = await UserData.getCredentialAccountData();
      final profileData = await UserData.getCredentialProfileData();
      try {
        // final kycResult = await settingsRepo.kyc(accountData!.bcAddress,
        //     state.fullName!, state.age!, state.gender!, state.debitor!);
        UserData.setCredentialProfileData(
            profileData?.avatarUrl,
            state.fullName!,
            int.parse(state.age!),
            state.gender!,
            state.debitor!);
        emit(state.copyWith(formStatus: RequestStatusSuccessful()));
      } on Exception catch (e) {
        emit(state.copyWith(formStatus: RequestStatusFailed(e)));
      }
    });
  }
}
