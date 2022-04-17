abstract class SignInCurrentEvent {}

class SignInCurrentPasswordChanged extends SignInCurrentEvent {
  final String password;

  SignInCurrentPasswordChanged({required this.password});
}

class SignInCurrentSubmitted extends SignInCurrentEvent {}
