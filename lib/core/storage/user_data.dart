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
  static init() {
    LocalStorageUtils.init();
    SecureStorageUtils.init();
  }

  // Session
  static Future<SessionDataModel> getSessionData() async =>
      SessionDataModel.fromJSON(await LocalStorageUtils.getMapValue(_session));

  static setSessionData({int? sessionType}) async {
    if (sessionType == null) return;
    return await LocalStorageUtils.setMapValue(
        _session, SessionDataModel(sessionType: sessionType).toJSON());
  }

  // Credential Session
  static Future<CredentialSessionDataModel> getCredentialSessionData() async =>
      CredentialSessionDataModel.fromJSON(
          await SecureStorageUtils.getMapValue(_credentialSession));

  static setCredentialSessionData(String? token, String? activeTime) async {
    if (token == null && activeTime == null) return;
    CredentialSessionDataModel data = await getCredentialSessionData();
    return await SecureStorageUtils.setMapValue(
        _credentialSession,
        CredentialSessionDataModel(
                token: token ?? data.token,
                effectiveTime: activeTime ?? data.effectiveTime)
            .toJSON());
  }

  // Credential Keys
  static Future<CredentialKeysDataModel> getCredentialKeysData() async =>
      CredentialKeysDataModel.fromJSON(
          await SecureStorageUtils.getMapValue(_credentialKeys));

  static setCredentialKeysData(String? publicKey, String? privateKey) async {
    if (publicKey == null && privateKey == null) return;
    CredentialKeysDataModel data = await getCredentialKeysData();
    return await SecureStorageUtils.setMapValue(
        _credentialKeys,
        CredentialKeysDataModel(
                publicKey: publicKey ?? data.publicKey,
                privateKey: privateKey ?? data.privateKey)
            .toJSON());
  }

  // Wipe out data for signing out
  static destroyAllData() async {
    // Remove all user data
    await LocalStorageUtils.removeAllMaps();
    await SecureStorageUtils.removeAllMaps();
    // Set initial session
    await setSessionData(sessionType: 0);
  }
}
