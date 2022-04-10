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
  String encryptedPrivateKey;
  SignUpResponseModel(
    this.bcAddress,
    this.publicKey,
    this.privateKey,
    this.encryptedPrivateKey,
  );
  SignUpResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['addressBC'], // bcAddress
        publicKey = json['publicKey'],
        privateKey = json['privateKey'],
        encryptedPrivateKey = json['encPrivateKey']; // encryptedPrivateKey
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
  SignInResponseModel();
  SignInResponseModel.fromJson(Map<String, dynamic> json) {}
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
  ImportResponseModel();
  ImportResponseModel.fromJson(Map<String, dynamic> json) {}
}
