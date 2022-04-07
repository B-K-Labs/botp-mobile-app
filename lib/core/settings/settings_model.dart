class KYCRequestModel {
  final String address;
  final String fullName;
  final int age;
  final String gender;
  final String debitor;
  KYCRequestModel(
      this.address, this.fullName, this.age, this.gender, this.debitor);
  Map<String, dynamic> toJson() => ({
        "bcAddress": address,
        "info": {
          "fullName": fullName,
          "age": age,
          "gender": gender,
          "debitor": debitor,
        }
      });
}

class KYCResponseModel {
  final String fromAddress;
  final String toAddress;
  final int nonce;
  final int gasPrice;
  final int gasLimit;
  final String data;
  KYCResponseModel(this.fromAddress, this.toAddress, this.nonce, this.gasPrice,
      this.gasLimit, this.data);
  KYCResponseModel.fromJson(Map<String, dynamic> json)
      : fromAddress = json["from"],
        toAddress = json["nonce"],
        nonce = json["nonce"],
        gasPrice = json["gasPrice"],
        gasLimit = json["gasLimit"],
        data = json["data"];
}
