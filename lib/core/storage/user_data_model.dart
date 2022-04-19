import 'package:botp_auth/constants/storage.dart';

// Public Data
class SessionDataModel {
  final UserDataSession sessionType;

  SessionDataModel({required this.sessionType});
  SessionDataModel.fromJSON(Map<String, dynamic> json)
      : sessionType = UserDataSession.values[json["sessionType"]];
  Map<String, dynamic> toJSON() => {"sessionType": sessionType.index};
}

class PreferenceDataModel {
  final UserDataTransactionDisplaying transDisplayType;
  final UserDataLanguage lang;
  final UserDataTheme theme;

  PreferenceDataModel(
      {required this.transDisplayType,
      required this.lang,
      required this.theme});
  PreferenceDataModel.fromJSON(Map<String, dynamic> json)
      : transDisplayType = UserDataTransactionDisplaying
            .values[json["transactionDisplayingType"]],
        lang = UserDataLanguage.values[json["language"]],
        theme = UserDataTheme.values[json["theme"]];
  Map<String, dynamic> toJSON() => {
        "transactionDisplayingType": transDisplayType.index,
        "language": lang.index,
        "theme": theme.index,
      };
}

// Credential Data
// class CredentialSessionDataModel {
//   final String token;
//   final String effectiveTime;
//
//   CredentialSessionDataModel(
//       {required this.token, required this.effectiveTime});
//   CredentialSessionDataModel.fromJSON(Map<String, dynamic> json)
//       : token = json["token"],
//         effectiveTime = json["effectiveTime"];
//   Map<String, dynamic> toJSON() =>
//       {"type": token, "effectiveTime": effectiveTime};
// }

class CredentialAccountDataModel {
  final String bcAddress;
  final String publicKey;
  final String privateKey;

  CredentialAccountDataModel(
      {required this.publicKey,
      required this.privateKey,
      required this.bcAddress});
  CredentialAccountDataModel.fromJSON(Map<String, dynamic> json)
      : publicKey = json["publicKey"],
        privateKey = json["privateKey"],
        bcAddress = json["bcAddress"];
  Map<String, dynamic> toJSON() => {
        "publicKey": publicKey,
        "privateKey": privateKey,
        "bcAddress": bcAddress
      };
}

class CredentialAgentsDataModel {
  final List<String> listBcAddresses;
  final List<String> listPublicKeys;

  CredentialAgentsDataModel(
      {required this.listBcAddresses, required this.listPublicKeys});
  CredentialAgentsDataModel.fromJSON(Map<String, dynamic> json)
      : listBcAddresses = json["listBcAddresses"],
        listPublicKeys = json["listPublicKeys"];
  Map<String, dynamic> toJSON() => {
        "listBcAddresses": listBcAddresses,
        "listPublicKeys": listPublicKeys,
      };
}

class CredentialProfileDataModel {
  final String? avatarUrl;
  final String fullName;
  final int age;
  final String gender;
  final String debitor;

  CredentialProfileDataModel(
      {this.avatarUrl,
      required this.fullName,
      required this.age,
      required this.gender,
      required this.debitor});
  CredentialProfileDataModel.fromJSON(Map<String, dynamic> json)
      : avatarUrl = json["avatarUrl"],
        fullName = json["fullName"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
  Map<String, dynamic> toJSON() => {
        "avatarUrl": avatarUrl,
        "fullName": fullName,
        "age": age,
        "gender": gender,
        "debitor": debitor,
      };
}
