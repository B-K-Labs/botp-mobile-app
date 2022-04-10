abstract class SetClipboardStatus {
  const SetClipboardStatus();
}

class SetClipboardStatusInitial extends SetClipboardStatus {
  const SetClipboardStatusInitial();
}

class SetClipboardStatusSuccessful extends SetClipboardStatus {}

class SetClipboardStatusFailed extends SetClipboardStatus {
  final Exception exception;
  SetClipboardStatusFailed(this.exception);
}
