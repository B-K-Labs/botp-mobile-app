class KYCRequestModel {
  final String bcAddress;
  final String password;
  final String fullName;
  final String address;
  final int age;
  final String gender;
  final String debitor;
  KYCRequestModel(this.bcAddress, this.password, this.fullName, this.address,
      this.age, this.gender, this.debitor);
  Map<String, dynamic> toJson() => ({
        "bcAddress": bcAddress,
        "password": password,
        "type": "USER",
        "info": {
          "fullName": fullName,
          "address": address,
          "age": age,
          "gender": gender,
          "debitor": debitor,
        }
      });
}

class KYCResponseModel {
  final Object info;
  KYCResponseModel(this.info);
  KYCResponseModel.fromJson(Map<String, dynamic> json) : info = json["info"];
}
