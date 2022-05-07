import 'package:botp_auth/common/repositories/settings_repository.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/agent.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/security/biometric_setup/cubit/biometric_setup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityBiometricSetupCubit extends Cubit<SecurityBiometricSetupState> {
  final SettingsRepository settingsRepository;
  bool _isSettingUpAgent = false;

  SecurityBiometricSetupCubit({required this.settingsRepository})
      : super(SecurityBiometricSetupState());

  setupBiometric() async {
    if (_isSettingUpAgent) return;
    _isSettingUpAgent = true;
    emit(state.copyWith(setupBiometricStatus: RequestStatusSubmitting()));
    try {
      emit(state.copyWith(
        setupBiometricStatus: RequestStatusSuccess(),
      ));
    } on Exception catch (e) {
      emit(state.copyWith(setupBiometricStatus: RequestStatusFailed(e)));
    }
    _isSettingUpAgent = false;
  }
}
