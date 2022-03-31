import 'package:botp_auth/common/statuses/form_submission_status.dart';

class SignUpState {
  // Password
  final String password;
  bool get isValidPassword => RegExp(
          r'''^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[\`\~\!\@\#\$\%\^\&\*\(\)\-\_\=\+\[\{\]\}\\\|\;\:\'\"\,\<\.\>\/\?]).{8,}$''')
      .hasMatch(password);

  // Form status
  final FormSubmissionStatus formStatus;

  // Constructors
  SignUpState(
      {this.password = '', this.formStatus = const InitialFormStatus()});

  SignUpState copyWith(
      {required String password, required FormSubmissionStatus formStatus}) {
    return SignUpState(password: password, formStatus: formStatus);
  }
}
