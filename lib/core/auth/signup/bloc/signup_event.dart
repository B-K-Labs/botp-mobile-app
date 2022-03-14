abstract class SignUpEvent {}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  SignUpPasswordChanged({required this.password});
}

class SignUpSubmitted extends SignUpEvent {}
