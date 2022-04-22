import 'package:botp_auth/constants/transaction.dart';

// KYC
class UserKYC {
  String fullName;
  String address;
  int age;
  String gender;
  String debitor;

  UserKYC(
      {required this.fullName,
      required this.address,
      required this.age,
      required this.gender,
      required this.debitor});

  UserKYC.fromJSON(Map<String, dynamic> json)
      : fullName = json["fullName"],
        address = json["address"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
}

// OTP sessions list
// Example
// {
// "_id": "62611cb32c0e920016f746ed",
// "status": "REQUESTING",
// "agentAddr": "0x6ddecf74606378775bb11a227956793cFcf963a4",
// "userAddr": "0x0D7631Ab6FF72e66e283E62C27600911e9eAE24C",
// "notifyMessage": "[khiem20tc] 006 - End!",
// "date": 1650531507528,
// "__v": 0,
// "agentInfo": {
// "_id": "626113c80e797d0016eb7766",
// "info": {
// "fullName": "The Coffee House",
// "description": "Coffee company"
// }
// }
// },
class OTPSessionInfo {
  String agentName;
  String agentAvatarUrl;
  String agentBcAddress;
  bool agentIsVerified;
  int timestamp;
  TransactionStatus transactionStatus;
  String notifyMessage;

  OTPSessionInfo(
      {required this.agentName,
      required this.agentAvatarUrl,
      required this.agentBcAddress,
      required this.agentIsVerified,
      required this.timestamp,
      required this.transactionStatus,
      required this.notifyMessage});

  OTPSessionInfo.fromJSON(Map<String, dynamic> json)
      : agentName = json["agentInfo"]["info"]["fullName"],
        agentAvatarUrl = json["agentInfo"]["avatar"] ?? "",
        agentBcAddress = json["agentAddr"],
        agentIsVerified = true,
        timestamp = json["date"],
        transactionStatus = json["status"].toString().toTransactionStatusType(),
        notifyMessage = json["notifyMessage"];
}

class OTPSessionSecretInfo {
  String secretId;
  String? secretMessage;
  OTPSessionSecretInfo({required this.secretId});
  OTPSessionSecretInfo.fromJSON(Map<String, dynamic> json)
      : secretId = json["_id"],
        secretMessage = null;
  setSecretMessage(String secretMessage) => this.secretMessage = secretMessage;
  clearSecretMessage() => secretMessage = null;
}

class OTPValueInfo {
  String value;
  int remainingSecond;
  OTPValueStatus get status => value.isEmpty
      ? OTPValueStatus.notAvailable
      : remainingSecond > otpRemainingSecondThreshold
          ? OTPValueStatus.valid
          : remainingSecond > 0
              ? OTPValueStatus.nearlyDead
              : OTPValueStatus.dead;
  void setInvalid() => value = "";
  OTPValueInfo({this.value = "", this.remainingSecond = 0});
  OTPValueInfo copyWith({String? value, int? remainingSecond}) => OTPValueInfo(
      value: value ?? this.value,
      remainingSecond: remainingSecond ?? this.remainingSecond);
}

class TransactionDetail {
  OTPSessionInfo otpSessionInfo;
  OTPSessionSecretInfo otpSessionSecretInfo;

  TransactionDetail(
      {required this.otpSessionInfo, required this.otpSessionSecretInfo});
}

class PaginationInfo {
  final int currentPage;
  final int totalPage;
  PaginationInfo({required this.currentPage, required this.totalPage});
}
