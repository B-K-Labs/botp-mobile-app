abstract class SetClipboardStatus {
  const SetClipboardStatus();
}

class SetClipboardStatusInitial extends SetClipboardStatus {
  const SetClipboardStatusInitial();
}

class SetClipboardStatusSubmitting extends SetClipboardStatus {}

class SetClipboardStatusSuccess extends SetClipboardStatus {
  final String? message;

  SetClipboardStatusSuccess({this.message});
}

class SetClipboardStatusFailed extends SetClipboardStatus {
  final Exception exception;
  SetClipboardStatusFailed(this.exception);
}
