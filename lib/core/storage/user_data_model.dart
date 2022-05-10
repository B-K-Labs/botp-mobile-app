import 'package:botp_auth/constants/storage.dart';
import 'package:botp_auth/constants/transaction.dart';

// Public Data
class CredentialSessionDataModel {
  final UserDataSession sessionType;

  CredentialSessionDataModel({required this.sessionType});
  CredentialSessionDataModel.fromJSON(Map<String, dynamic> json)
      : sessionType = UserDataSession.values[json["sessionType"]];
  Map<String, dynamic> toJSON() => {"sessionType": sessionType.index};
}

class CredentialPreferenceDataModel {
  final UserDataTransactionDisplaying transDisplayType;
  final UserDataLanguage lang;
  final UserDataTheme theme;

  CredentialPreferenceDataModel(
      {required this.transDisplayType,
      required this.lang,
      required this.theme});
  CredentialPreferenceDataModel.fromJSON(Map<String, dynamic> json)
      : transDisplayType = UserDataTransactionDisplaying
            .values[json["transactionDisplayingType"]],
        lang = UserDataLanguage.values[json["language"]],
        theme = UserDataTheme.values[json["theme"]];
  Map<String, dynamic> toJSON() => {
        "transactionDisplayingType": transDisplayType.index,
        "language": lang.index,
        "theme": theme.index,
      };
}

class CredentialAccountDataModel {
  final String bcAddress;
  final String publicKey;
  final String privateKey;
  final String password;

  CredentialAccountDataModel(
      {required this.publicKey,
      required this.privateKey,
      required this.bcAddress,
      required this.password});
  CredentialAccountDataModel.fromJSON(Map<String, dynamic> json)
      : publicKey = json["publicKey"],
        privateKey = json["privateKey"],
        bcAddress = json["bcAddress"],
        password = json["password"];
  Map<String, dynamic> toJSON() => {
        "publicKey": publicKey,
        "privateKey": privateKey,
        "bcAddress": bcAddress,
        "password": password,
      };
}

class CredentialAgentsDataModel {
  final List<String> listBcAddresses;

  CredentialAgentsDataModel({required this.listBcAddresses});
  CredentialAgentsDataModel.fromJSON(Map<String, dynamic> json)
      : listBcAddresses = List<String>.from(
            json["listBcAddresses"]); // Cast list of dynamic to lsit of string
  Map<String, dynamic> toJSON() => {
        "listBcAddresses": listBcAddresses,
      };
}

class CredentialTransactionsHistoryDataModel {
  List<String> requestingTransactionSecretIdsList;
  List<String> waitingTransactionSecretIdsList;
  CredentialTransactionsHistoryDataModel(
      {required this.requestingTransactionSecretIdsList,
      required this.waitingTransactionSecretIdsList});
  CredentialTransactionsHistoryDataModel.fromJSON(Map<String, dynamic> json)
      : requestingTransactionSecretIdsList =
            List<String>.from(json[TransactionStatus.requesting.name]),
        waitingTransactionSecretIdsList =
            List<String>.from(json[TransactionStatus.waiting.name]);
  Map<String, dynamic> toJSON() => {
        TransactionStatus.requesting.name: requestingTransactionSecretIdsList,
        TransactionStatus.waiting.name: waitingTransactionSecretIdsList
      };
}

class CredentialTransactionsSecretDataModel {
  final Map<String, dynamic> objTransactionSecretMessages;
  CredentialTransactionsSecretDataModel({
    required this.objTransactionSecretMessages,
  });
  CredentialTransactionsSecretDataModel.fromJSON(Map<String, dynamic> json)
      : objTransactionSecretMessages = json["objTransactionSecretMessages"];
  Map<String, dynamic> toJSON() =>
      {"objTransactionSecretMessages": objTransactionSecretMessages};
}

class CredentialProfileDataModel {
  final String? avatarUrl;
  final bool didKyc;
  CredentialProfileDataModel({
    this.avatarUrl = "",
    this.didKyc = false,
  });
  CredentialProfileDataModel.fromJSON(Map<String, dynamic> json)
      : avatarUrl = json["avatarUrl"],
        didKyc = json["didKyc"];
  Map<String, dynamic> toJSON() => {"avatarUrl": avatarUrl, "didKyc": didKyc};
}

class CredentialKYCDataModel {
  final String fullName;
  final String address;
  final int age;
  final String gender;
  final String debitor;

  CredentialKYCDataModel(
      {required this.fullName,
      required this.address,
      required this.age,
      required this.gender,
      required this.debitor});
  CredentialKYCDataModel.fromJSON(Map<String, dynamic> json)
      : fullName = json["fullName"],
        address = json["address"],
        age = json["age"],
        gender = json["gender"],
        debitor = json["debitor"];
  Map<String, dynamic> toJSON() => {
        "fullName": fullName,
        "address": address,
        "age": age,
        "gender": gender,
        "debitor": debitor,
      };
}

class CredentialBiometricDataModel {
  final bool isActivated;

  CredentialBiometricDataModel({required this.isActivated});
  CredentialBiometricDataModel.fromJSON(Map<String, dynamic> json)
      : isActivated = json["isActivated"];
  Map<String, dynamic> toJSON() => {"isActivated": isActivated};
}
