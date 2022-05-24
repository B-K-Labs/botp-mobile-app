abstract class SignInEvent {}

class SignInEventPasswordChanged extends SignInEvent {
  final String password;

  SignInEventPasswordChanged({required this.password});
}

class SignInEventSubmitted extends SignInEvent {
  final String? password;
  SignInEventSubmitted({this.password});
}

class SignInEventBiometricAuth extends SignInEvent {
  final bool isSilent;
  final bool isEnabled;
  SignInEventBiometricAuth({this.isSilent = false, this.isEnabled = true});
}
