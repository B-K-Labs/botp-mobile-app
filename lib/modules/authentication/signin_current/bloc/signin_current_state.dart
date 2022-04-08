import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/authentication.dart';

class SignInCurrentState {
  // Private key
  final String bcAddress;
  String? get validateBcAddress => bcAddressValidator(bcAddress);
  // Password
  final String password;
  String? get validatePassword => passwordNormalValidator(password);

  // Form status
  final RequestStatus formStatus;

  SignInCurrentState({
    this.bcAddress = '',
    this.password = '',
    this.formStatus = const RequestStatusInitial(),
  });

  SignInCurrentState copyWith(
      {String? bcAddress, String? password, RequestStatus? formStatus}) {
    return SignInCurrentState(
      bcAddress: bcAddress ?? this.bcAddress,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
