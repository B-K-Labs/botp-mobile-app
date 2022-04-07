// For form
abstract class RequestStatus {
  const RequestStatus();
}

class RequestStatusInitial extends RequestStatus {
  const RequestStatusInitial();
}

class RequestStatusSubmitting extends RequestStatus {}

class RequestStatusSuccess extends RequestStatus {}

class RequestStatusFailed extends RequestStatus {
  final Exception exception;
  RequestStatusFailed(this.exception);
}
