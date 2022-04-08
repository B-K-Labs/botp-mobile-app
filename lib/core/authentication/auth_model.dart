// Sign in
class SignInRequestModel {
  final String bcAddress;
  final String password;
  SignInRequestModel(this.bcAddress, this.password);
  Map<String, dynamic> toJson() => ({
        "bcAddress": bcAddress,
        "password": password,
      });
}

class SignInResponseModel {
  final bool status;
  SignInResponseModel(this.status);
  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : status = json["status"];
}

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
  bool status;
  SignUpResponseModel(
    this.bcAddress,
    this.publicKey,
    this.privateKey,
    this.encryptedPrivateKey,
    this.status,
  );
  SignUpResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'],
        publicKey = json['publicKey'],
        privateKey = json['privateKey'],
        encryptedPrivateKey = json['encryptedPrivateKey'],
        status = json['status'];
}

// Import account
class ImportRequestModel {
  final String hashedPrivateKey;
  final String newPassword;
  ImportRequestModel(this.hashedPrivateKey, this.newPassword);
  Map<String, dynamic> toJson() => ({
        'hashedPrivateKey': hashedPrivateKey,
        'password': newPassword, // TODO: change to new password
      });
}

class ImportResponseModel {
  bool status;
  ImportResponseModel(this.status);
  ImportResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}
