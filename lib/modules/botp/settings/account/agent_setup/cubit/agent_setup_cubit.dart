import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/models/settings_model.dart';
import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/agent.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/account/agent_setup/cubit/agent_setup_state.dart';
import 'package:botp_auth/utils/services/clipboard_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountAgentSetupCubit extends Cubit<AccountAgentSetupState> {
  final SettingsRepository settingsRepository;
  bool _isSettingUpAgent = false;

  AccountAgentSetupCubit({required this.settingsRepository})
      : super(AccountAgentSetupState());

  setupAgent(String setupAgentUrl) async {
    if (_isSettingUpAgent) return;
    _isSettingUpAgent = true;
    emit(state.copyWith(setupAgentStatus: RequestStatusSubmitting()));
    final accountData = await UserData.getCredentialAccountData();
    try {
      // Validate scanned url
      if (setupAgentUrlValidator(setupAgentUrl) != null) {
        throw (Exception("Your Agent QR image is invalid. Please try again."));
      }
      final setupAgentResult = await settingsRepository.setUpAgent(
          setupAgentUrl, accountData!.bcAddress);
      emit(state.copyWith(
          setupAgentStatus: RequestStatusSuccess(),
          agentInfo: setupAgentResult.agentInfo));
    } on Exception catch (e) {
      emit(state.copyWith(setupAgentStatus: RequestStatusFailed(e)));
    }
    _isSettingUpAgent = false;
  }

  copyBcAddress() async {
    emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSubmitting()));
    try {
      await setClipboardData(state.agentInfo!.bcAddress);
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusSuccess()));
    } on Exception catch (e) {
      emit(state.copyWith(copyBcAddressStatus: SetClipboardStatusFailed(e)));
    }
    emit(
        state.copyWith(copyBcAddressStatus: const SetClipboardStatusInitial()));
  }
}
