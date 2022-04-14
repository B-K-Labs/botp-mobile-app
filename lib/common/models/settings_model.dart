class KYCRequestModel {
  final String bcAddress;
  final String fullName;
  final int age;
  final String gender;
  final String debitor;
  KYCRequestModel(
      this.bcAddress, this.fullName, this.age, this.gender, this.debitor);
  Map<String, dynamic> toJson() => ({
        "bcAddress": bcAddress,
        "info": {
          "fullName": fullName,
          "age": age,
          "gender": gender,
          "debitor": debitor,
        }
      });
}

class KYCResponseModel {
  final String fromBcAddress;
  final String toBcAddress;
  final int nonce;
  final int gasPrice;
  final int gasLimit;
  final String data;
  KYCResponseModel(this.fromBcAddress, this.toBcAddress, this.nonce,
      this.gasPrice, this.gasLimit, this.data);
  KYCResponseModel.fromJson(Map<String, dynamic> json)
      : fromBcAddress = json["from"],
        toBcAddress = json["nonce"],
        nonce = json["nonce"],
        gasPrice = json["gasPrice"],
        gasLimit = json["gasLimit"],
        data = json["data"];
}
