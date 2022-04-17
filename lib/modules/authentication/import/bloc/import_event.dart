abstract class SignInOtherEvent {}

class SignInOtherPrivateKeyChanged extends SignInOtherEvent {
  final String privateKey;

  SignInOtherPrivateKeyChanged({required this.privateKey});
}

class SignInOtherNewPasswordChanged extends SignInOtherEvent {
  final String newPassword;

  SignInOtherNewPasswordChanged({required this.newPassword});
}

class SignInOtherSubmitted extends SignInOtherEvent {}
