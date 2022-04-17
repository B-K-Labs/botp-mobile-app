// Sign up
class SignUpRequestModel {
  final String password;
  SignUpRequestModel(this.password);
  Map<String, dynamic> toJson() => ({"password": password});
}

class SignUpResponseModel {
  String bcAddress;
  String publicKey;
  String privateKey;
  SignUpResponseModel(
    this.bcAddress,
    this.publicKey,
    this.privateKey,
  );
  SignUpResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'],
        privateKey = json['privateKey']; // encryptedPrivateKey
}

// Sign in
class SignInRequestModel {
  final String hashedPrivateKey;
  final String password;
  SignInRequestModel(this.hashedPrivateKey, this.password);
  Map<String, dynamic> toJson() => ({
        "hashedPrivateKey": hashedPrivateKey,
        "password": password,
      });
}

class SignInResponseModel {
  String bcAddress;
  String publicKey;
  String privateKey;

  SignInResponseModel(this.bcAddress, this.publicKey, this.privateKey);
  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json["bcAddress"],
        publicKey = json["publicKey"],
        privateKey = json["privateKey"];
}

// Import
class ImportRequestModel {
  final String privateKey;
  final String newPassword;
  ImportRequestModel(this.privateKey, this.newPassword);
  Map<String, dynamic> toJson() => ({
        "privateKey": privateKey,
        "newPassword": newPassword,
      });
}

class ImportResponseModel {
  String bcAddress;
  String publicKey;

  ImportResponseModel(this.bcAddress, this.publicKey);
  ImportResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'];
}
