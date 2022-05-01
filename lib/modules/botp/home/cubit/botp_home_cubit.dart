import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/states/user_data_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/home/cubit/botp_home_state.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Keep track of session & some user data
class BOTPHomeCubit extends Cubit<BOTPHomeState> {
  SettingsRepository settingsRepository;

  BOTPHomeCubit({required this.settingsRepository}) : super(BOTPHomeState());

  // Flag
  bool _isLoadingUserData = false;

  loadCommonUserData() async {
    if (_isLoadingUserData) return;
    _isLoadingUserData = true;
    // Read user data from storage
    final accountData = await UserData.getCredentialAccountData();
    final profileData = await UserData.getCredentialProfileData();
    final agentsData = await UserData.getCredentialAgentsData();
    if (profileData!.didKyc) {
      final kycData = await UserData.getCredentialKYCData();
      emit(state.copyWith(
          avatarUrl: profileData.avatarUrl,
          bcAddress: accountData!.bcAddress,
          userKyc: UserKYC(
              fullName: kycData!.fullName,
              address: kycData.address,
              age: kycData.age,
              gender: kycData.gender,
              debitor: kycData.debitor),
          didKyc: true,
          needRegisterAgent:
              agentsData == null || agentsData.listBcAddresses.isEmpty
                  ? true
                  : false,
          loadUserDataStatus: LoadUserDataStatusSuccess()));
    } else {
      emit(state.copyWith(
        avatarUrl: profileData.avatarUrl,
        bcAddress: accountData!.bcAddress,
        didKyc: false,
        needRegisterAgent:
            agentsData == null || agentsData.listBcAddresses.isEmpty
                ? true
                : false,
        loadUserDataStatus: LoadUserDataStatusSuccess(),
      ));
    }
    // Get user agent list
    try {
      emit(state.copyWith(getAgentsListStatus: RequestStatusSubmitting()));
      final getAgentsListInfoResult =
          await settingsRepository.getAgentsList(accountData.bcAddress);
      final agentBcAddressesList = getAgentsListInfoResult.agentBcAddressesList;
      await UserData.setCredentialAgentsData(
          agentBcAddressesList); // Store in local storage (not used)
      emit(state.copyWith(
          getAgentsListStatus: RequestStatusSuccess(),
          needRegisterAgent: agentBcAddressesList.isEmpty));
    } on Exception catch (e) {
      emit(state.copyWith(getAgentsListStatus: RequestStatusFailed(e)));
    }
    emit(state.copyWith(getAgentsListStatus: const RequestStatusInitial()));
    _isLoadingUserData = false;
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
