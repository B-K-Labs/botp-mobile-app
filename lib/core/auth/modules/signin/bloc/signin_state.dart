import 'package:botp_auth/common/statuses/form_submission_status.dart';

class SignInState {
  final String username;
  final String password;
  final FormSubmissionStatus formStatus;

  SignInState({
    this.username = '',
    this.password = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignInState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return SignInState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
