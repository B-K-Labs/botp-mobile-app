// Sign in
class SignInRequestModel {
  final String address;
  final String password;
  SignInRequestModel(this.address, this.password);
  Map<String, dynamic> toJson() => ({
        "bcAddress": address,
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
  String address;
  String publicKey;
  String privateKey;
  String encryptedPrivateKey;
  bool status;
  SignUpResponseModel(
    this.address,
    this.publicKey,
    this.privateKey,
    this.encryptedPrivateKey,
    this.status,
  );
  SignUpResponseModel.fromJson(Map<String, dynamic> json)
      : address = json['bcAddress'],
        publicKey = json['publicKey'],
        privateKey = json['privateKey'],
        encryptedPrivateKey = json['encryptedPrivateKey'],
        status = json['status'];
}

// Import security
class ImportRequestModel {
  final String hashedPrivateKey;
  final String password;
  ImportRequestModel(this.hashedPrivateKey, this.password);
  Map<String, dynamic> toJson() => ({
        'hashedPrivateKey': hashedPrivateKey,
        'password': password, // TODO: change to new password
      });
}

class ImportResponseModel {
  bool status;
  ImportResponseModel(this.status);
  ImportResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}
