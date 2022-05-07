import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/common/states/clipboard_status.dart';
import 'package:botp_auth/common/states/request_status.dart';
import 'package:local_auth/local_auth.dart';

class SecurityBiometricSetupState {
  final RequestStatus setupBiometricStatus;

  SecurityBiometricSetupState({
    this.setupBiometricStatus = const RequestStatusInitial(),
  });

  SecurityBiometricSetupState copyWith({
    RequestStatus? setupBiometricStatus,
  }) =>
      SecurityBiometricSetupState(
        setupBiometricStatus: setupBiometricStatus ?? this.setupBiometricStatus,
      );
}
