import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/transaction.dart';

class GetTransactionsListResponseModel {
  PaginationInfo paginationInfo;
  List<TransactionDetail> otpSessionsList;

  GetTransactionsListResponseModel.fromJSON(Map<String, dynamic> json)
      : paginationInfo =
            PaginationInfo(currentPage: json["page"], totalPage: json["size"]),
        otpSessionsList =
            json["data"].forEach((otpSessionJson) => TransactionDetail(
                otpSessionInfo: OTPSessionInfo.fromJSON(otpSessionJson),
                otpSessionSecretInfo: OTPSessionSecretInfo.fromJSON(
                  otpSessionJson,
                )));
}

class RequestTransactionRequestModel {
  final String otpSessionId;
  final String password;
  final TransactionRequestAction action;
  RequestTransactionRequestModel(
      {required this.otpSessionId,
      required this.password,
      required this.action});
  Map<String, dynamic> toJSON() => action != TransactionRequestAction.cancel
      ? {
          "OTPsessionId": otpSessionId,
          "password": password,
          "action": action.name.toString().toUpperCase()
        }
      : {"OTPsessionId": otpSessionId, "password": password};
}

abstract class RequestTransactionResponseModel {
  const RequestTransactionResponseModel();
}

class ConfirmTransactionResponseModel extends RequestTransactionResponseModel {
  final String secretMessage;
  ConfirmTransactionResponseModel({required this.secretMessage});
  ConfirmTransactionResponseModel.fromJSON(Map<String, dynamic> json)
      : secretMessage = json["message"];
}

class DenyTransactionResponseModel extends RequestTransactionResponseModel {
  final String result;
  DenyTransactionResponseModel({required this.result});
  DenyTransactionResponseModel.fromJSON(this.result);
}

class CancelTransactionResponseModel extends RequestTransactionResponseModel {
  final Object otpSession; // TODO: Just declaration, no need to use that?
  CancelTransactionResponseModel({required this.otpSession});
  CancelTransactionResponseModel.fromJSON(Map<String, dynamic> json)
      : otpSession = json["OTPsession"];
}
