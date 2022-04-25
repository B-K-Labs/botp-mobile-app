abstract class ImportEvent {}

class ImportEventPrivateKeyChanged extends ImportEvent {
  final String privateKey;

  ImportEventPrivateKeyChanged({required this.privateKey});
}

class ImportEventNewPasswordChanged extends ImportEvent {
  final String newPassword;

  ImportEventNewPasswordChanged({required this.newPassword});
}

class ImportEventSubmitted extends ImportEvent {}

class ImportEventScanQRPrivateKey extends ImportEvent {
  String? scannedPrivateKey;

  ImportEventScanQRPrivateKey({required this.scannedPrivateKey});
}
