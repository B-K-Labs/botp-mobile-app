import 'package:botp_auth/constants/transaction.dart';

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

class TransactionInfoModel {
  String agentName;
  String agentAvatarUrl;
  bool agentIsVerified;
  String agentBcAddress;
  String timestamp;
  TransactionStatus transactionStatus;
  String notifyMessage;

  TransactionInfoModel(
      {required this.agentName,
      required this.agentAvatarUrl,
      required this.agentIsVerified,
      required this.agentBcAddress,
      required this.timestamp,
      required this.transactionStatus,
      required this.notifyMessage});
}

class OTPInfoModel {
  String value;
  int remainingTime;

  OTPInfoModel({required this.value, required this.remainingTime});
}
