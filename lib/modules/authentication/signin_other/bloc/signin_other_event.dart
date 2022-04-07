abstract class SignInOtherEvent {}

class SignInOtherPrivateKeyChanged extends SignInOtherEvent {
  final String privateKey;

  SignInOtherPrivateKeyChanged({required this.privateKey});
}

class SignInOtherPasswordChanged extends SignInOtherEvent {
  final String password;

  SignInOtherPasswordChanged({required this.password});
}

class SignInOtherSubmitted extends SignInOtherEvent {}
