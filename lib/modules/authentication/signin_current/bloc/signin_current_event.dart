abstract class SignInCurrentEvent {}

class SignInCurrentPrivateKeyChanged extends SignInCurrentEvent {
  final String privateKey;

  SignInCurrentPrivateKeyChanged({required this.privateKey});
}

class SignInCurrentPasswordChanged extends SignInCurrentEvent {
  final String password;

  SignInCurrentPasswordChanged({required this.password});
}

class SignInCurrentSubmitted extends SignInCurrentEvent {}
