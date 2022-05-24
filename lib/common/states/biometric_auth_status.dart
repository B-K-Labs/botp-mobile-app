abstract class BiometricAuthStatus {
  const BiometricAuthStatus(); // Canonicalization
}

class BiometricAuthStatusInitial extends BiometricAuthStatus {
  const BiometricAuthStatusInitial();
}

class BiometricAuthStatusSubmitting extends BiometricAuthStatus {}

class BiometricAuthStatusSuccess extends BiometricAuthStatus {}

class BiometricAuthStatusFailed extends BiometricAuthStatus {
  final Exception exception;
  BiometricAuthStatusFailed(this.exception);
}
