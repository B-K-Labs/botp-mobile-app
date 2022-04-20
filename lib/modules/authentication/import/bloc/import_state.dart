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

  ImportState({
    this.privateKey = '',
    this.newPassword = '',
    this.formStatus = const RequestStatusInitial(),
  });

  ImportState copyWith(
          {String? privateKey,
          String? newPassword,
          RequestStatus? formStatus}) =>
      ImportState(
        privateKey: privateKey ?? this.privateKey,
        newPassword: newPassword ?? this.newPassword,
        formStatus: formStatus ?? this.formStatus,
      );
}
