import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/utils/services/local_storage_service.dart';
import 'package:botp_auth/utils/services/secure_storage_service.dart';

class UserData {
  // Session: session type
  static Future<SessionDataModel?> getSessionData() async {
    final data = await LocalStorage.getValue(UserDataType.session);
    return data != null ? SessionDataModel.fromJSON(data) : null;
  }

  static setSessionData(SessionType sessionType) async =>
      await LocalStorage.setValue(UserDataType.session,
          SessionDataModel(sessionType: sessionType).toJSON());

  // Preferences: theme, language, transaction displaying type
  static Future<PreferenceDataModel?> getPreferencesData() async {
    final data = await LocalStorage.getValue(UserDataType.preferences);
    return data != null ? PreferenceDataModel.fromJSON(data) : null;
  }

  static setPreferencesData(TransactionDisplayingType transDisplayType,
          Language lang, AppTheme theme) async =>
      await LocalStorage.setValue(
          UserDataType.preferences,
          PreferenceDataModel(
                  transDisplayType: transDisplayType, lang: lang, theme: theme)
              .toJSON());

  // Credential Session: token, expired time
  static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialSession);
    return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  }

  static setCredentialSessionData(String token, String effectiveTime) async {
    return await SecureStorage.setSecureValue(
        UserDataType.credentialSession,
        CredentialSessionDataModel(token: token, effectiveTime: effectiveTime)
            .toJSON());
  }

  // Credential Account: blockchain address, public/private key
  static Future<CredentialAccountDataModel?> getCredentialAccountData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialAccount);
    return data != null ? CredentialAccountDataModel.fromJSON(data) : null;
  }

  static setCredentialAccountData(
          String bcAddress, String publicKey, String privateKey) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialAccount,
          CredentialAccountDataModel(
                  bcAddress: bcAddress,
                  publicKey: publicKey,
                  privateKey: privateKey)
              .toJSON());

  // Credential Account: blockchain address, public/private key
  static Future<CredentialAgentsDataModel?> getCredentialAgentsData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialAgents);
    return data != null ? CredentialAgentsDataModel.fromJSON(data) : null;
  }

  static setCredentialAgentsData(List<String> listAgentBcAddress) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialAgents,
          CredentialAgentsDataModel(listAgentBcAddress: listAgentBcAddress)
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
