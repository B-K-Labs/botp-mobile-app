import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/home/cubit/settings_main_state.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsHomeCubit extends Cubit<SettingsHomeState> {
  SettingsHomeCubit() : super(SettingsHomeState()) {
    readGeneralUserData();
  }

  readGeneralUserData() async {
    final accountData = await UserData.getCredentialAccountData();
    final profileData = await UserData.getCredentialProfileData();
    final kycData = await UserData.getCredentialKYCData();
    emit(state.copyWith(
        avatarUrl: profileData?.avatarUrl,
        fullName: kycData?.fullName,
        bcAddress: accountData!.bcAddress,
        loadUserDataStatus: LoadUserDataStatusSuccess()));
  }

  Future<void> copyBcAddress() async {
    try {
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSubmitting()));
      // Copy address to clipboard
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
