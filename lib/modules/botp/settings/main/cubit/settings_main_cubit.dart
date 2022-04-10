import 'package:botp_auth/common/states/set_clipboard_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/main/cubit/settings_main_state.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsMainCubit extends Cubit<SettingsMainState> {
  SettingsMainCubit() : super(SettingsMainState()) {
    readGeneralUserData();
  }

  readGeneralUserData() async {
    final accountData = await UserData.getCredentialAccountData();
    final profileData = await UserData.getCredentialProfileData();
    emit(state.copyWith(
        avatarUrl: profileData?.avatarUrl,
        fullName: profileData?.fullName,
        bcAddress: accountData!.bcAddress));
  }

  Future<void> copyBcAddress() async {
    try {
      await Clipboard.setData(ClipboardData(text: state.bcAddress));
      if (state is SetClipboardStatusInitial) {
        emit(state.copyWith(
            copyBcAddressStatus: SetClipboardStatusSuccessful()));
        await Future.delayed(const Duration(seconds: 5));
        emit(state.copyWith(
            copyBcAddressStatus: const SetClipboardStatusInitial()));
      }
    } on Exception catch (e) {
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusFailed(e)));
    }
  }
}
