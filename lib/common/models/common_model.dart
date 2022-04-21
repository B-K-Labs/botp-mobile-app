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

class OTPInfoData (
int
)