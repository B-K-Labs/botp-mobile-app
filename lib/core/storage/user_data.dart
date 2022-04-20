import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/utils/services/local_storage_service.dart';
import 'package:botp_auth/utils/services/secure_storage_service.dart';

// Note: all data is credential
class UserData {
  // Credential Session: session type
  static Future<SessionDataModel?> getCredentialSessionData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialSession);
    return data != null ? SessionDataModel.fromJSON(data) : null;
  }

  static setSessionData(UserDataSession sessionType) async =>
      await SecureStorage.setSecureValue(UserDataType.credentialSession,
          SessionDataModel(sessionType: sessionType).toJSON());

  // Credential Preferences: theme, language, transactions displaying type
  static Future<PreferenceDataModel?> getCredentialPreferencesData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialPreferences);
    return data != null ? PreferenceDataModel.fromJSON(data) : null;
  }

  static setPreferencesData(UserDataTransactionDisplaying transDisplayType,
          UserDataLanguage lang, UserDataTheme theme) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialPreferences,
          PreferenceDataModel(
                  transDisplayType: transDisplayType, lang: lang, theme: theme)
              .toJSON());

  // Credential Account: blockchain address, public/private key, password
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

  // Credential Profile: fullName, age, gender, debitor
  static Future<CredentialProfileDataModel?> getCredentialProfileData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialProfile);
    return data != null ? CredentialProfileDataModel.fromJSON(data) : null;
  }

  static setCredentialProfileData(String? avatarUrl, String fullName, int age,
          String gender, String debitor) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialProfile,
          CredentialProfileDataModel(
                  avatarUrl: avatarUrl,
                  fullName: fullName,
                  age: age,
                  gender: gender,
                  debitor: debitor)
              .toJSON());

  // Credential Agent: agents list
  static Future<CredentialAgentsDataModel?> getCredentialAgentsData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialAgents);
    return data != null ? CredentialAgentsDataModel.fromJSON(data) : null;
  }

  static setCredentialAgentsData(
          List<String> listBcAddresses, List<String> listPublicKeys) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialAgents,
          CredentialAgentsDataModel(
                  listBcAddresses: listBcAddresses,
                  listPublicKeys: listPublicKeys)
              .toJSON());

  // Wipe out data for e.g signing out
  static clear() async {
    await LocalStorage.removeAllValues();
    await SecureStorage.removeAllSecureValues();
  }
}
