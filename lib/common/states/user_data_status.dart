abstract class LoadUserDataStatus {
  const LoadUserDataStatus();
}

class LoadUserDataStatusInitial extends LoadUserDataStatus {
  const LoadUserDataStatusInitial();
}

class LoadUserDataStatusSuccess extends LoadUserDataStatus {}

class LoadUserDataStatusFailed extends LoadUserDataStatus {
  Exception exception;
  LoadUserDataStatusFailed(this.exception);
}
