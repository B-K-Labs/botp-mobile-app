import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/authentication.dart';

class ImportState {
  // Private key
  final String privateKey;
  String? get validatePrivateKey => privateKeyValidator(privateKey);
  // Password
  final String newPassword;
  String? get validateNewPassword => passwordNormalValidator(newPassword);
  // Form status
  final RequestStatus formStatus;
  // Qr scan
  final RequestStatus scanQrStatus;

  ImportState({
    this.privateKey = '',
    this.newPassword = '',
    this.formStatus = const RequestStatusInitial(),
    this.scanQrStatus = const RequestStatusInitial(),
  });

  ImportState copyWith(
          {String? privateKey,
          String? newPassword,
          RequestStatus? formStatus,
          RequestStatus? scanQrStatus}) =>
      ImportState(
          privateKey: privateKey ?? this.privateKey,
          newPassword: newPassword ?? this.newPassword,
          formStatus: formStatus ?? this.formStatus,
          scanQrStatus: scanQrStatus ?? this.scanQrStatus);
}
