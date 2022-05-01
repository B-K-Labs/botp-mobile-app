import 'package:botp_auth/common/models/settings_model.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/account/home/cubit/account_home_state.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewCubit extends Cubit<ProfileViewState> {
  final SettingsRepository settingsRepository;

  ProfileViewCubit({required this.settingsRepository})
      : super(ProfileViewState()) {
    readProfileData();
  }

  readProfileData() async {
    final kycData = await UserData.getCredentialKYCData();
    final accountData = await UserData.getCredentialAccountData();
    try {
      if (kycData != null) {
        emit(state.copyWith(
            fullName: kycData.fullName,
            address: kycData.address,
            age: kycData.age,
            gender: kycData.gender,
            debitor: kycData.debitor,
            didKyc: true,
            bcAddress: accountData!.bcAddress,
            publicKey: accountData.publicKey,
            loadUserData: LoadUserDataStatusSuccess()));
      } else {
        emit(state.copyWith(
            didKyc: false,
            bcAddress: accountData!.bcAddress,
            publicKey: accountData.publicKey,
            loadUserData: LoadUserDataStatusSuccess()));
      }
    } on Exception catch (e) {
      emit(state.copyWith(loadUserData: LoadUserDataStatusFailed(e)));
    }
  }

  Future<SetupAgentResponseModel?> setupAgent(String setupAgentUrl) async {
    final accountData = await UserData.getCredentialAccountData();
    try {
      final setupAgentResult = await settingsRepository.setUpAgent(
          setupAgentUrl, accountData!.bcAddress);
      return setupAgentResult;
    } on Exception catch (e) {
      return null;
    }
  }

  Future<void> copyBcAddress() async {
    emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSubmitting()));
    try {
      await setClipboardData(state.bcAddress);
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSuccess()));
    } on Exception catch (e) {
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusFailed(e)));
    } finally {
      emit(state.copyWith(
          copyBcAddressStatus: const SetClipboardStatusInitial()));
    }
  }
}
