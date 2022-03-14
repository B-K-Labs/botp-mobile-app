// Public Data
class SessionDataModel {
  // Session type: 0: first-time-user, 1: Signed out user, 2: Temporarily signed out user, 3: Authenticated user
  final int sessionType;
  SessionDataModel({required this.sessionType});
  SessionDataModel.fromJSON(Map<String, dynamic> json)
      : sessionType = json["type"] ?? 0;
  Map<String, dynamic> toJSON() => {"type": sessionType};
}

// Credential Data
class CredentialSessionDataModel {
  final String token;
  final String effectiveTime;
  CredentialSessionDataModel(
      {required this.token, required this.effectiveTime});
  CredentialSessionDataModel.fromJSON(Map<String, dynamic> json)
      : token = json["token"],
        effectiveTime = json["duration"];
  Map<String, dynamic> toJSON() => {"type": token, "duration": effectiveTime};
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
