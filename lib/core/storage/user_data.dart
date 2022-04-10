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

  // Preferences: theme, language, transactions displaying type
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
  // static Future<CredentialSessionDataModel?> getCredentialSessionData() async {
  //   final data =
  //       await SecureStorage.getSecureValue(UserDataType.credentialSession);
  //   return data != null ? CredentialSessionDataModel.fromJSON(data) : null;
  // }
  //
  // static setCredentialSessionData(String token, String effectiveTime) async {
  //   return await SecureStorage.setSecureValue(
  //       UserDataType.credentialSession,
  //       CredentialSessionDataModel(token: token, effectiveTime: effectiveTime)
  //           .toJSON());
  // }

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

  // Credential Profile: fullName, age, gender, address, debitor
  static Future<CredentialProfileDataModel?> getCredentialProfileData() async {
    final data =
        await SecureStorage.getSecureValue(UserDataType.credentialProfile);
    return data != null ? CredentialProfileDataModel.fromJSON(data) : null;
  }

  static setCredentialProfileData(String? avatarUrl, String fullName, int age,
          String gender, String address, String debitor) async =>
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
