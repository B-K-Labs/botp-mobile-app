abstract class FormStatus {
  const FormStatus();
}

class FormStatusInitial extends FormStatus {
  const FormStatusInitial();
}

class FormStatusSubmitting extends FormStatus {}

class FormStatusSuccess extends FormStatus {}

class FormStatusFailed extends FormStatus {
  final Exception exception;
  FormStatusFailed(this.exception);
}
