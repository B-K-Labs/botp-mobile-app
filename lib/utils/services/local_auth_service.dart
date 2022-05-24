import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class LocalAuth {
  static late final LocalAuthentication auth;

  static init() {
    auth = LocalAuthentication();
  }

  // Is hardware supported
  static Future<bool> isBiometricSupported() async {
    try {
      // Note: isDeviceSupported() is just for device-level support
      return await auth.canCheckBiometrics;
    } on PlatformException {
      return false;
    }
  }

  // Get enrolled method list
  // Note: due to security, only 2 types (BiometricType.weak and BiometricType.wrong) are returned
  // https://stackoverflow.com/questions/72111458/how-to-detect-specific-flutter-biometrictype-touch-or-face-id-using-local-auth
  static Future<List<BiometricType>> _getAvailableBiometricsList() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException {
      return <BiometricType>[];
    }
  }

  static Future<bool> isBiometricEnrolled() async {
    final biometricList = await _getAvailableBiometricsList();
    return biometricList.contains(BiometricType.strong);
  }

  // Authenticate with biometric only
  static Future<bool> authenticateWithBiometric() async {
    try {
      return await auth.authenticate(
          localizedReason: "Scan your fingerprint/face to continue",
          options: const AuthenticationOptions(
              useErrorDialogs: true, stickyAuth: true, biometricOnly: true));
    } on Exception {
      return false;
    }
  }
}
