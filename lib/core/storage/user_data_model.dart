// Public Data
import 'package:botp_auth/constants/storage.dart';

class SessionDataModel {
  final SessionType sessionType;

  SessionDataModel({required this.sessionType});
  SessionDataModel.fromJSON(Map<String, dynamic> json)
      : sessionType = SessionType.values[json["sessionType"]];
  Map<String, dynamic> toJSON() => {"sessionType": sessionType.index};
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

class CredentialKeysDataModel {
  final String publicKey;
  final String privateKey;

  CredentialKeysDataModel({required this.publicKey, required this.privateKey});
  CredentialKeysDataModel.fromJSON(Map<String, dynamic> json)
      : publicKey = json["publiKey"],
        privateKey = json["privateKey"];
  Map<String, dynamic> toJSON() => {
        "publicKey": publicKey,
        "privateKey": privateKey,
      };
}
