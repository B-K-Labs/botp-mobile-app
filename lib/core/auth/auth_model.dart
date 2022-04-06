class SignInRequestModel {
  final String password;
  final String hashedPrivateKey;
  SignInRequestModel(this.hashedPrivateKey, this.password);
  Map<String, dynamic> toJSON() => ({
        'hashedPrivateKey': hashedPrivateKey,
        'password': password,
      });
}

class SignInResponseModel {
  bool status;
  SignInResponseModel(this.status);
  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : status = json['status'];
}

class SignUpRequestModel {
  final String password;
  SignUpRequestModel(this.password);
  Map<String, dynamic> toJSON() => ({"password": password});
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
