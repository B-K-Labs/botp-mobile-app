import 'package:botp_auth/common/states/clipboard_status.dart';
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
    final profileData = await UserData.getCredentialKYCData();
    emit(state.copyWith(
        avatarUrl: profileData?.avatarUrl,
        fullName: profileData?.fullName,
        bcAddress: accountData!.bcAddress));
  }

  Future<void> copyBcAddress() async {
    try {
      await setClipboardData(state.bcAddress);
      if (state.copyBcAddressStatus is SetClipboardStatusInitial) {
        emit(state.copyWith(
            copyBcAddressStatus: SetClipboardStatusSuccessful()));
      }
    } on Exception catch (e) {
      if (state.copyBcAddressStatus is SetClipboardStatusFailed) return;
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusFailed(e)));
    } finally {
      // Reset to initial state
      _resetCopyBcState();
    }
  }

  Future<void> _resetCopyBcState() async {
    await Future.delayed(const Duration(seconds: 5));
    emit(
        state.copyWith(copyBcAddressStatus: const SetClipboardStatusInitial()));
  }
}
