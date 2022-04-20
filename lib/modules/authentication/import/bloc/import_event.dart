abstract class ImportEvent {}

class ImportPrivateKeyChanged extends ImportEvent {
  final String privateKey;

  ImportPrivateKeyChanged({required this.privateKey});
}

class ImportNewPasswordChanged extends ImportEvent {
  final String newPassword;

  ImportNewPasswordChanged({required this.newPassword});
}

class ImportSubmitted extends ImportEvent {}
