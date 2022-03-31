abstract class SignInEvent {}

class SignInPrivateKeyChanged extends SignInEvent {
  final String privateKey;

  SignInPrivateKeyChanged({required this.privateKey});
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  SignInPasswordChanged({required this.password});
}

class SignInSubmitted extends SignInEvent {}
