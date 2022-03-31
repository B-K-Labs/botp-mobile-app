import 'package:botp_auth/common/state/form_submission_status.dart';

class SignUpState {
  // Password
  final String password;
  get validatePassword => password.isEmpty
      ? "Missing password"
      : password.length < 8
          ? "Password must be at least 6 characters"
          : RegExp(r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\`\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\{\]\}\\\|\;\:\'\"\,\<\.\>\/\?]).{6,}$''')
                  .hasMatch(password)
              ? ""
              : "Password must contain one uppercase, one lowercase, one digit, and one special character";

  // Form status
  final FormStatus formStatus;

  // Constructors
  SignUpState(
      {this.password = '', this.formStatus = const FormStatusInitial()});

  SignUpState copyWith({password, formStatus}) {
    return SignUpState(
        password: password ?? this.password,
        formStatus: formStatus ?? this.formStatus);
  }
}
