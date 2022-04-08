abstract class SignInCurrentEvent {}

class SignInCurrentPrivateKeyChanged extends SignInCurrentEvent {
  final String bcAddress;

  SignInCurrentPrivateKeyChanged({required this.bcAddress});
}

class SignInCurrentPasswordChanged extends SignInCurrentEvent {
  final String password;

  SignInCurrentPasswordChanged({required this.password});
}

class SignInCurrentSubmitted extends SignInCurrentEvent {}
