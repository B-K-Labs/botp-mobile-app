import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/main/cubit/settings_main_state.dart';
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
}
