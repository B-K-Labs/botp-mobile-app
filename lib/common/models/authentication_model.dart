import 'package:botp_auth/common/models/common_model.dart';

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
  UserKYC? userKyc;
  SignUpResponseModel(
    this.bcAddress,
    this.publicKey,
    this.privateKey,
    this.userKyc,
  );
  SignUpResponseModel.fromJSON(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'],
        privateKey = json['privateKey'],
        userKyc = json["info"] != null ? UserKYC.fromJSON(json["info"]) : null;
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
  UserKYC? userKyc;
  String? avatarUrl;

  SignInResponseModel(
      this.bcAddress, this.publicKey, this.userKyc, this.avatarUrl);

  SignInResponseModel.fromJSON(Map<String, dynamic> json)
      : bcAddress = json["bcAddress"],
        publicKey = json["publicKey"],
        userKyc = json["info"] != null ? UserKYC.fromJSON(json["info"]) : null,
        avatarUrl = json["avatar"];
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
  UserKYC? userKyc;
  String? avatarUrl;

  ImportResponseModel(
      this.bcAddress, this.publicKey, this.userKyc, this.avatarUrl);
  ImportResponseModel.fromJSON(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'],
        userKyc = json['info'] != null ? UserKYC.fromJSON(json['info']) : null,
        avatarUrl = json['avatar']; // Nullable
}
