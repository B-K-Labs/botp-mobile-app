import 'dart:convert';
import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/constants/pagination.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/api_url/api_url.dart';
import 'package:botp_auth/utils/services/rest_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class AuthenticatorRepository {
  // Get OTP sessions list
  Future<GetTransactionsListResponseModel> getTransactionsList(
      String bcAddress, TransactionStatus? transactionStatus,
      [int currentPage = 1]) async {
    // Set search parameters
    final Map<String, dynamic> queryParameters = {
      "userAddress": bcAddress,
      "page": currentPage.toString(),
      "size": kTransactionItemsPagSize.toString()
    };
    if (transactionStatus != null &&
        transactionStatus != TransactionStatus.all) {
      queryParameters["status"] = transactionStatus.name.toUpperCase();
    }
    http.Response result = await get(makeApiUrlString(
        path: "/message/OTPsessions", queryParameters: queryParameters));
    if (result.statusCode == HttpStatus.ok) {
      return GetTransactionsListResponseModel.fromJSON(
          json.decode(result.body));
    }
    throw Exception(result.body);
  }

  // Confirm transaction (step 1)
  Future<ConfirmTransactionResponseModel> confirmTransaction(
      String otpSessionId, String password) async {
    final data = RequestTransactionRequestModel(
            otpSessionId: otpSessionId,
            password: password,
            action: TransactionRequestAction.confirm)
        .toJSON();
    http.Response result =
        await post(makeApiUrlString(path: "/message/receiveMessage"), data);
    if (result.statusCode == HttpStatus.ok) {
      return ConfirmTransactionResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception(result.body);
  }

  // Deny transaction (step 1)
  Future<DenyTransactionResponseModel> denyTransaction(
      String otpSessionId, String password) async {
    final data = RequestTransactionRequestModel(
            otpSessionId: otpSessionId,
            password: password,
            action: TransactionRequestAction.deny)
        .toJSON();
    http.Response result =
        await post(makeApiUrlString(path: "/message/receiveMessage"), data);
    if (result.statusCode == HttpStatus.ok) {
      return DenyTransactionResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception(result.body);
  }

  // Discard transaction (step 2)
  Future<CancelTransactionResponseModel> cancelTransaction(
      String otpSessionId, String password) async {
    final data = RequestTransactionRequestModel(
            otpSessionId: otpSessionId,
            password: password,
            action: TransactionRequestAction.cancel)
        .toJSON();
    http.Response result =
        await post(makeApiUrlString(path: "/message/cancelMessage"), data);
    if (result.statusCode == HttpStatus.ok) {
      return CancelTransactionResponseModel.fromJSON(json.decode(result.body));
    }
    throw Exception(result.body);
  }
}
