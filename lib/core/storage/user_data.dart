import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/core/storage/user_data_model.dart';
import 'package:botp_auth/utils/services/local_storage_service.dart';
import 'package:botp_auth/utils/services/secure_storage_service.dart';

// Note: all data is credential
class UserData {
  // Credential Session: session type
  static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialSession);
    return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  }

  static setCredentialSessionData(UserDataSession sessionType) async =>
      await SecureStorage.setSecureValue(UserDataType.credentialSession,
          CredentialSessionDataModel(sessionType: sessionType).toJSON());

  static clearCredentialSessionData() async =>
      await SecureStorage.removeSecureValue(UserDataType.credentialSession);

  // Credential Preferences: theme, language, transactions displaying type
  static Future<CredentialPreferenceDataModel?>
      getCredentialPreferencesData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialPreferences);
    return data != null ? CredentialPreferenceDataModel.fromJSON(data) : null;
  }

  static setCredentialPreferencesData(
          UserDataTransactionDisplaying transDisplayType,
          UserDataLanguage lang,
          UserDataTheme theme) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialPreferences,
          CredentialPreferenceDataModel(
                  transDisplayType: transDisplayType, lang: lang, theme: theme)
              .toJSON());

  static clearCredentialPreferencesData() async =>
      SecureStorage.removeSecureValue(UserDataType.credentialPreferences);

  // Credential Account: blockchain address, public/private key, password
  static Future<CredentialAccountDataModel?> getCredentialAccountData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialAccount);
    return data != null ? CredentialAccountDataModel.fromJSON(data) : null;
  }

  static setCredentialAccountData(String bcAddress, String publicKey,
          String privateKey, String password) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialAccount,
          CredentialAccountDataModel(
                  bcAddress: bcAddress,
                  publicKey: publicKey,
                  privateKey: privateKey,
                  password: password)
              .toJSON());

  static clearCredentialAccountData() async =>
      await SecureStorage.removeSecureValue(UserDataType.credentialAccount);

  // Credential Profile: didKYC, avatarUrl
  static Future<CredentialProfileDataModel?> getCredentialProfileData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialProfile);
    return data != null ? CredentialProfileDataModel.fromJSON(data) : null;
  }

  static setCredentialProfileDataModel(bool didKYC, String? avatarURL) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialProfile,
          CredentialProfileDataModel(didKyc: didKYC, avatarUrl: avatarURL)
              .toJSON());

  static clearCredentialProfileData() async =>
      await SecureStorage.removeSecureValue(UserDataType.credentialProfile);

  // Credential KYC: fullName, addressn age, gender, debitor
  static Future<CredentialKYCDataModel?> getCredentialKYCData() async {
    final data = await SecureStorage.getSecureValue(UserDataType.credentialKYC);
    return data != null ? CredentialKYCDataModel.fromJSON(data) : null;
  }

  static setCredentialKYCData(String fullName, String address, int age,
          String gender, String debitor) async =>
      await SecureStorage.setSecureValue(
          UserDataType.credentialKYC,
          CredentialKYCDataModel(
                  fullName: fullName,
                  address: address,
                  age: age,
                  gender: gender,
                  debitor: debitor)
              .toJSON());

  static clearCredentialKYCData() async =>
      await SecureStorage.removeSecureValue(UserDataType.credentialKYC);

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

  static clearCredentialAgentsData() async =>
      await SecureStorage.removeSecureValue(UserDataType.credentialAgents);

  // Wipe out everything, in case of e.g signing out
  static clear() async {
    await LocalStorage.removeAllValues();
    await SecureStorage.removeAllSecureValues();
  }
}
