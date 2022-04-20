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
  final String password;

  CredentialAccountDataModel(
      {required this.publicKey,
      required this.privateKey,
      required this.bcAddress,
      required this.password});
  CredentialAccountDataModel.fromJSON(Map<String, dynamic> json)
      : publicKey = json["publicKey"],
        privateKey = json["privateKey"],
        bcAddress = json["bcAddress"],
        password = json["password"];
  Map<String, dynamic> toJSON() => {
        "publicKey": publicKey,
        "privateKey": privateKey,
        "bcAddress": bcAddress,
        "password": password,
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
  final bool didKYC;
  final String fullName;
  final String address;
  final int age;
  final String gender;
  final String debitor;

  CredentialProfileDataModel(
      {this.avatarUrl,
      this.didKYC = false,
      required this.fullName,
      required this.address,
      required this.age,
      required this.gender,
      required this.debitor});
  CredentialProfileDataModel.fromJSON(Map<String, dynamic> json)
      : avatarUrl = json["avatarUrl"],
        didKYC = json["didKYC"],
        fullName = json["fullName"],
        address = json["address"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
  Map<String, dynamic> toJSON() => {
        "avatarUrl": avatarUrl,
        "didKYC": didKYC,
        "fullName": fullName,
        "address": address,
        "age": age,
        "gender": gender,
        "debitor": debitor,
      };
}
