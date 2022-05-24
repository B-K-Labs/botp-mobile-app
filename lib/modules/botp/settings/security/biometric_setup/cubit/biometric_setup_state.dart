import 'package:botp_auth/common/states/biometric_auth_status.dart';

class SecurityBiometricSetupState {
  final BiometricAuthStatus setupBiometricStatus;

  SecurityBiometricSetupState({
    this.setupBiometricStatus = const BiometricAuthStatusInitial(),
  });

  SecurityBiometricSetupState copyWith({
    BiometricAuthStatus? setupBiometricStatus,
  }) =>
      SecurityBiometricSetupState(
        setupBiometricStatus: setupBiometricStatus ?? this.setupBiometricStatus,
      );
}
