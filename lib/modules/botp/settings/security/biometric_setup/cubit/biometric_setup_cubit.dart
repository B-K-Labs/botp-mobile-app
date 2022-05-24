import 'package:botp_auth/common/states/biometric_auth_status.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/modules/botp/settings/security/biometric_setup/cubit/biometric_setup_state.dart';
import 'package:botp_auth/utils/services/local_auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecurityBiometricSetupCubit extends Cubit<SecurityBiometricSetupState> {
  bool _isSettingUpAgent = false;

  SecurityBiometricSetupCubit() : super(SecurityBiometricSetupState());

  setupBiometric() async {
    if (_isSettingUpAgent) return;
    _isSettingUpAgent = true;
    emit(state.copyWith(setupBiometricStatus: BiometricAuthStatusSubmitting()));
    try {
      // Check if biometric supported
      final isBiometricHardwareSupported =
          await LocalAuth.isBiometricSupported();
      if (!isBiometricHardwareSupported) {
        throw Exception(
            "Your device does not support biometric authentication.");
      }

      // Authenticating
      final biometricAuthResult = await LocalAuth.authenticateWithBiometric();
      if (biometricAuthResult) {
        // Register biometric authentication state
        await UserData.setCredentialBiometricData(true);
        // Update status
        emit(state.copyWith(
          setupBiometricStatus: BiometricAuthStatusSuccess(),
        ));
      } else {
        throw Exception("We cannot recognize you. Please try again.");
      }
    } on Exception catch (e) {
      emit(state.copyWith(setupBiometricStatus: BiometricAuthStatusFailed(e)));
    }
    _isSettingUpAgent = false;
  }
}
