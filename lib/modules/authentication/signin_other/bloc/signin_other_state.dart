import 'package:botp_auth/common/state/request_status.dart';

class SignInOtherState {
  // Private key
  final String privateKey;
  String? get validatePrivateKey => null;
  // Password
  final String password;
  String? get validatePassword => password.isEmpty
      ? "Missing password"
      : password.length < 6
          ? "Password must be at least 6 characters"
          : RegExp(r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\`\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\{\]\}\\\|\;\:\'\"\,\<\.\>\/\?]).{6,}$''')
                  .hasMatch(password)
              ? null
              : "Password must contain one uppercase, lowercase, digit, and one special character";

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
