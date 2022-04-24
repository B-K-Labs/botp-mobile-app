abstract class SetClipboardStatus {
  const SetClipboardStatus();
}

class SetClipboardStatusInitial extends SetClipboardStatus {
  const SetClipboardStatusInitial();
}

class SetClipboardStatusSubmitting extends SetClipboardStatus {}

class SetClipboardStatusSuccess extends SetClipboardStatus {}

class SetClipboardStatusFailed extends SetClipboardStatus {
  final Exception exception;
  SetClipboardStatusFailed(this.exception);
}
