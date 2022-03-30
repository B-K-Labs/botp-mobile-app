import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/utils/services/local_storage_service.dart';
import 'package:botp_auth/utils/services/secure_storage_service.dart';

class UserData {
  static const _session = "session_data";
  static const _transaction = "transaction_data";
  static const _preference = "preference_data";
  static const _credentialSession = "credential_session_data";
  static const _credentialKeys = "credential_key_data";
  static const _credentialAccount = "credential_account_data";
  static const _credentialProfile = "credential_profile_data";

  // Session
  static Future<SessionDataModel?> getSessionData() async {
    final data = await LocalStorage.getValue(_session);
    return data != null ? SessionDataModel.fromJSON(data) : null;
  }

  static setSessionData(int sessionType) async => await LocalStorage.setValue(
      _session, SessionDataModel(sessionType: sessionType).toJSON());

  // Credential Session
  static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
    final data = await SecureStorage.getSecureValue(_credentialSession);
    return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  }

  static setCredentialSessionData(String token, String effectiveTime) async {
    return await SecureStorage.setSecureValue(
        _credentialSession,
        CredentialSessionDataModel(token: token, effectiveTime: effectiveTime)
            .toJSON());
  }

  // Credential Keys
  static Future<CredentialKeysDataModel?> getCredentialKeysData() async {
    final data = await SecureStorage.getSecureValue(_credentialKeys);
    return data != null ? CredentialKeysDataModel.fromJSON(data) : null;
  }

  static setCredentialKeysData(String publicKey, String privateKey) async =>
      await SecureStorage.setSecureValue(
          _credentialKeys,
          CredentialKeysDataModel(publicKey: publicKey, privateKey: privateKey)
              .toJSON());

  // Wipe out data for signing out
  static clear() async {
    // Remove all user data
    await LocalStorage.removeAllValues();
    await SecureStorage.removeAllSecureValues();
    // Set initial session
    await setSessionData(0);
  }
}
