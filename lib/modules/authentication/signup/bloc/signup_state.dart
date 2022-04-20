import 'package:botp_auth/common/states/request_status.dart';
import 'package:botp_auth/common/validators/authentication.dart';

class SignUpState {
  // Password
  final String password;
  String? get validatePassword => passwordStrictValidator(password);
  // Form status
  final RequestStatus formStatus;

  // Constructors
  SignUpState(
      {this.password = '', this.formStatus = const RequestStatusInitial()});

  SignUpState copyWith(
          {String? password, RequestStatus? formStatus, bool? didKYC}) =>
      SignUpState(
          password: password ?? this.password,
          formStatus: formStatus ?? this.formStatus);
}
