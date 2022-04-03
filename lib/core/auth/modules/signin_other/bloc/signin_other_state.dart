import 'package:botp_auth/common/state/form_submission_status.dart';

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
  final FormStatus formStatus;

  SignInOtherState({
    this.privateKey = '',
    this.password = '',
    this.formStatus = const FormStatusInitial(),
  });

  SignInOtherState copyWith(
      {String? privateKey, String? password, FormStatus? formStatus}) {
    return SignInOtherState(
      privateKey: privateKey ?? this.privateKey,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
