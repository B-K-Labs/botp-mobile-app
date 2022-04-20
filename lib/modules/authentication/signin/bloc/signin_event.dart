abstract class SignInEvent {}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged({required this.password});
}

class SignInSubmitted extends SignInEvent {}
