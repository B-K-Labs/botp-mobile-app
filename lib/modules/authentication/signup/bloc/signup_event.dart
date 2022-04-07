abstract class SignUpEvent {}

class SignUpEventPasswordChanged extends SignUpEvent {
  final String password;

  SignUpEventPasswordChanged({required this.password});
}

class SignUpEventSubmitted extends SignUpEvent {}
