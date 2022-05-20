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

  OTPSessionInfo copyWith(
          {String? agentName,
          String? agentAvatarUrl,
          String? agentBcAddress,
          bool? agentIsVerified,
          int? timestamp,
          TransactionStatus? transactionStatus,
          String? notifyMessage}) =>
      OTPSessionInfo(
          agentName: agentName ?? this.agentName,
          agentBcAddress: agentBcAddress ?? this.agentBcAddress,
          agentAvatarUrl: agentAvatarUrl ?? this.agentAvatarUrl,
          agentIsVerified: agentIsVerified ?? this.agentIsVerified,
          timestamp: timestamp ?? this.timestamp,
          transactionStatus: transactionStatus ?? this.transactionStatus,
          notifyMessage: notifyMessage ?? this.notifyMessage);

  setTransactionStatus(TransactionStatus transactionStatus) =>
      this.transactionStatus = transactionStatus;

  OTPSessionInfo.fromJSON(Map<String, dynamic> json)
      : agentName = json["agentInfo"]["info"]["name"],
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
      : secretId = json["_id"], // (update) Khiem's mongo id
        secretMessage = null;
  setSecretMessage(String? secretMessage) => this.secretMessage = secretMessage;
  clearSecretMessage() => secretMessage = null;
}

class OTPValueInfo {
  String value;
  int remainingSecond;
  int totalSeconds;
  bool notAvailable;
  OTPValueStatus get status => notAvailable
      ? OTPValueStatus.notAvailable
      : value.isEmpty
          ? OTPValueStatus.initial
          : remainingSecond > otpRemainingSecondThreshold
              ? OTPValueStatus.valid
              : remainingSecond > 0
                  ? OTPValueStatus.nearlyExpired
                  : OTPValueStatus.expired;
  countdown() => remainingSecond > -1 ? remainingSecond -= 1 : remainingSecond;
  OTPValueInfo(
      {this.value = "",
      this.remainingSecond = -1,
      this.totalSeconds = -1,
      this.notAvailable = false});
  OTPValueInfo copyWith(
          {String? value, int? remainingSecond, bool? notAvailable}) =>
      OTPValueInfo(
          value: value ?? this.value,
          remainingSecond: remainingSecond ?? this.remainingSecond,
          notAvailable: notAvailable ?? this.notAvailable);
}

class TransactionDetail {
  OTPSessionInfo otpSessionInfo;
  OTPSessionSecretInfo otpSessionSecretInfo;

  TransactionDetail(
      {required this.otpSessionInfo, required this.otpSessionSecretInfo});
  TransactionDetail copyWith(
          {OTPSessionInfo? otpSessionInfo,
          OTPSessionSecretInfo? otpSessionSecretInfo}) =>
      TransactionDetail(
          otpSessionInfo: otpSessionInfo ?? this.otpSessionInfo,
          otpSessionSecretInfo:
              otpSessionSecretInfo ?? this.otpSessionSecretInfo);
}

class PaginationInfo {
  final int currentPage;
  final int totalPage;
  PaginationInfo({required this.currentPage, required this.totalPage});
}

class AgentInfo {
  final String name;
  final String description;
  final String bcAddress;
  final String avatarUrl;
  final bool isVerified;

  AgentInfo(
      {required this.name,
      required this.description,
      required this.bcAddress,
      required this.avatarUrl,
      required this.isVerified});
}

class ProvenanceInfo {
  final String agentBcAddress;
  final String userBcAddress;
  final String id;

  ProvenanceInfo(
      {required this.agentBcAddress,
      required this.userBcAddress,
      required this.id});
}

class BroadcastEventData {
  final String agentBcAddress;
  final String userBcAddress;
  final String id;
  final String encryptedMessage;

  BroadcastEventData(
      {required this.agentBcAddress,
      required this.userBcAddress,
      required this.id,
      required this.encryptedMessage});
}

class HistoryEventData {
  final String agentBcAddress;
  final String userBcAddress;
  final String id;
  final String encryptedMessage;
  final String signature;

  HistoryEventData(
      {required this.agentBcAddress,
      required this.userBcAddress,
      required this.id,
      required this.encryptedMessage,
      required this.signature});
}
