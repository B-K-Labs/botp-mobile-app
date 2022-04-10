import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/authentication.dart';

class SignInOtherState {
  // Private key
  final String privateKey;
  String? get validatePrivateKey => privateKeyValidator(privateKey);
  // Password
  final String newPassword;
  String? get validateNewPassword => passwordNormalValidator(newPassword);

  // Form status
  final RequestStatus formStatus;

  SignInOtherState({
    this.privateKey = '',
    this.newPassword = '',
    this.formStatus = const RequestStatusInitial(),
  });

  SignInOtherState copyWith(
          {String? privateKey,
          String? newPassword,
          RequestStatus? formStatus}) =>
      SignInOtherState(
        privateKey: privateKey ?? this.privateKey,
        newPassword: newPassword ?? this.newPassword,
        formStatus: formStatus ?? this.formStatus,
      );
}
