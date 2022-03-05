class SignUpResponseModel {
  String bcAddress;
  String publicKey;
  String privateKey;
  String encryptedPrivateKey;
  String status;

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
