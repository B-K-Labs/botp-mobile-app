abstract class SignInEvent {}

class SignInEventPasswordChanged extends SignInEvent {
  final String password;

  SignInEventPasswordChanged({required this.password});
}

class SignInEventSubmitted extends SignInEvent {}
