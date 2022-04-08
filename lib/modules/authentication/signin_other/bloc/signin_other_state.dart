import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/authentication.dart';

class SignInOtherState {
  // Private key
  final String privateKey;
  String? get validatePrivateKey => privateKeyValidator(privateKey);
  // Password
  final String password;
  String? get validatePassword => passwordNormalValidator(password);

  // Form status
  final RequestStatus formStatus;

  SignInOtherState({
    this.privateKey = '',
    this.password = '',
    this.formStatus = const RequestStatusInitial(),
  });

  SignInOtherState copyWith(
      {String? privateKey, String? password, RequestStatus? formStatus}) {
    return SignInOtherState(
      privateKey: privateKey ?? this.privateKey,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
