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

  // Called in mainApp()
  static init() async {
    await LocalStorageUtils.init();
    await SecureStorageUtils.init();
  }

  // Session
  static Future<SessionDataModel?> getSessionData() async {
    final data = await LocalStorageUtils.getMapValue(_session);
    return data != null ? SessionDataModel.fromJSON(data) : null;
  }

  static setSessionData(int sessionType) async =>
      await LocalStorageUtils.setMapValue(
          _session, SessionDataModel(sessionType: sessionType).toJSON());

  // Credential Session
  static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
    final data = await SecureStorageUtils.getMapValue(_credentialSession);
    return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  }

  static setCredentialSessionData(String token, String effectiveTime) async {
    return await SecureStorageUtils.setMapValue(
        _credentialSession,
        CredentialSessionDataModel(token: token, effectiveTime: effectiveTime)
            .toJSON());
  }

  // Credential Keys
  static Future<CredentialKeysDataModel?> getCredentialKeysData() async {
    final data = await SecureStorageUtils.getMapValue(_credentialKeys);
    return data != null ? CredentialKeysDataModel.fromJSON(data) : null;
  }

  static setCredentialKeysData(String publicKey, String privateKey) async =>
      await SecureStorageUtils.setMapValue(
          _credentialKeys,
          CredentialKeysDataModel(publicKey: publicKey, privateKey: privateKey)
              .toJSON());

  // Wipe out data for signing out
  static destroyAllData() async {
    // Remove all user data
    await LocalStorageUtils.removeAllMaps();
    await SecureStorageUtils.removeAllMaps();
    // Set initial session
    await setSessionData(0);
  }
}
