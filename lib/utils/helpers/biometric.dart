import 'package:botp_auth/constants/settings.dart';
import 'package:botp_auth/core/storage/user_data.dart';
import 'package:botp_auth/utils/services/local_auth_service.dart';

// Get biometric setup status
Future<BiometricSetupStatus> getBiometricSetupStatus() async {
  final isSupported = await LocalAuth.isBiometricSupported();
  if (!isSupported) return BiometricSetupStatus.unsupported;

  final isEnrolled = await LocalAuth.isBiometricEnrolled();
  if (!isEnrolled) return BiometricSetupStatus.notSetup;

  final isActivated =
      (await UserData.getCredentialBiometricData())?.isActivated ?? false;
  return isActivated
      ? BiometricSetupStatus.enabled
      : BiometricSetupStatus.disabled;
}
