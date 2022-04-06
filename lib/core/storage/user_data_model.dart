import 'package:botp_auth/constants/storage.dart';

// Public Data
class SessionDataModel {
  final SessionType sessionType;

  SessionDataModel({required this.sessionType});
  SessionDataModel.fromJSON(Map<String, dynamic> json)
      : sessionType = SessionType.values[json["sessionType"]];
  Map<String, dynamic> toJSON() => {"sessionType": sessionType.index};
}

class PreferenceDataModel {
  final TransactionDisplayingType transDisplayType;
  final Language lang;
  final AppTheme theme;

  PreferenceDataModel(
      {required this.transDisplayType,
      required this.lang,
      required this.theme});
  PreferenceDataModel.fromJSON(Map<String, dynamic> json)
      : transDisplayType =
            TransactionDisplayingType.values[json["transactionDisplayingType"]],
        lang = Language.values[json["language"]],
        theme = AppTheme.values[json["theme"]];
  Map<String, dynamic> toJSON() => {
        "transactionDisplayingType": transDisplayType.index,
        "language": lang.index,
        "theme": theme.index,
      };
}

// Credential Data
class CredentialSessionDataModel {
  final String token;
  final String effectiveTime;

  CredentialSessionDataModel(
      {required this.token, required this.effectiveTime});
  CredentialSessionDataModel.fromJSON(Map<String, dynamic> json)
      : token = json["token"],
        effectiveTime = json["effectiveTime"];
  Map<String, dynamic> toJSON() =>
      {"type": token, "effectiveTime": effectiveTime};
}

class CredentialAccountDataModel {
  final String address;
  final String publicKey;
  final String privateKey;

  CredentialAccountDataModel(
      {required this.publicKey,
      required this.privateKey,
      required this.address});
  CredentialAccountDataModel.fromJSON(Map<String, dynamic> json)
      : publicKey = json["publiKey"],
        privateKey = json["privateKey"],
        address = json["bcAddress"];
  Map<String, dynamic> toJSON() =>
      {"publicKey": publicKey, "privateKey": privateKey, "bcAddress": address};
}

class CredentialAgentsDataModel {
  final List<String> listAgentBcAddress;

  CredentialAgentsDataModel({required this.listAgentBcAddress});
  CredentialAgentsDataModel.fromJSON(Map<String, dynamic> json)
      : listAgentBcAddress = json["listAgentBcAddress"];
  Map<String, dynamic> toJSON() => {
        "listAgentBcAddress": listAgentBcAddress,
      };
}

class CredentialProfileDataModel {
  final String fullName;
  final int age;
  final String gender;
  final String debitor;

  CredentialProfileDataModel(
      {required this.fullName,
      required this.age,
      required this.gender,
      required this.debitor});
  CredentialProfileDataModel.fromJSON(Map<String, dynamic> json)
      : fullName = json["fullName"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
  Map<String, dynamic> toJSON() => {
        "fullName": fullName,
        "age": age,
        "gender": gender,
        "debitor": debitor,
      };
}
