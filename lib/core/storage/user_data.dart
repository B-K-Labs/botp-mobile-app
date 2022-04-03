import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/utils/services/local_storage_service.dart';
import 'package:botp_auth/utils/services/secure_storage_service.dart';

class UserData {
  // Session
  static Future<SessionDataModel?> getSessionData() async {
    final data = await LocalStorage.getValue(KUserData.session);
    return data != null ? SessionDataModel.fromJSON(data) : null;
  }

  static setSessionData(SessionType sessionType) async =>
      await LocalStorage.setValue(KUserData.session,
          SessionDataModel(sessionType: sessionType).toJSON());

  // Credential Session
  static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
    final data =
        await SecureStorage.getSecureValue(KUserData.credentialSession);
    return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  }

  static setCredentialSessionData(String token, String effectiveTime) async {
    return await SecureStorage.setSecureValue(
        KUserData.credentialSession,
        CredentialSessionDataModel(token: token, effectiveTime: effectiveTime)
            .toJSON());
  }

  // Credential Keys
  static Future<CredentialKeysDataModel?> getCredentialKeysData() async {
    final data = await SecureStorage.getSecureValue(KUserData.credentialKeys);
    return data != null ? CredentialKeysDataModel.fromJSON(data) : null;
  }

  static setCredentialKeysData(String publicKey, String privateKey) async =>
      await SecureStorage.setSecureValue(
          KUserData.credentialKeys,
          CredentialKeysDataModel(publicKey: publicKey, privateKey: privateKey)
              .toJSON());

  // Wipe out data for signing out
  static clear() async {
    // Remove all user data
    await LocalStorage.removeAllValues();
    await SecureStorage.removeAllSecureValues();
    // Set initial session
    await setSessionData(SessionType.unauthenticated);
  }
}
