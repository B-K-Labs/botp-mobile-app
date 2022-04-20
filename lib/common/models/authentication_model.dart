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
  UserKYCModel? userKyc;
  SignUpResponseModel(
    this.bcAddress,
    this.publicKey,
    this.privateKey,
    this.userKyc,
  );
  SignUpResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'],
        privateKey = json['privateKey'],
        userKyc =
            json["info"] != null ? UserKYCModel.fromJSON(json["info"]) : null;
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
  UserKYCModel? userKyc;

  SignInResponseModel(
      this.bcAddress, this.publicKey, this.privateKey, this.userKyc);

  SignInResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json["bcAddress"],
        publicKey = json["publicKey"],
        privateKey = json["privateKey"],
        userKyc =
            json["info"] != null ? UserKYCModel.fromJSON(json["info"]) : null;
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
  UserKYCModel? userKyc;

  ImportResponseModel(this.bcAddress, this.publicKey, this.userKyc);
  ImportResponseModel.fromJson(Map<String, dynamic> json)
      : bcAddress = json['bcAddress'], // bcAddress
        publicKey = json['publicKey'],
        userKyc =
            json['info'] != null ? UserKYCModel.fromJSON(json['info']) : null;
}

class UserKYCModel {
  String fullName;
  String address;
  int age;
  String gender;
  String debitor;

  UserKYCModel(
      {required this.fullName,
      required this.address,
      required this.age,
      required this.gender,
      required this.debitor});

  Map<String, dynamic> toJSON() => {
        "fullName": fullName,
        "address": address,
        "age": age,
        "gender": gender,
        "debitor": debitor
      };

  UserKYCModel.fromJSON(Map<String, dynamic> json)
      : fullName = json["fullName"],
        address = json["address"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
}
