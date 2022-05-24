import 'dart:convert';
import 'package:botp_auth/common/models/authenticator_model.dart';
import 'package:botp_auth/common/models/common_model.dart';
import 'package:botp_auth/constants/provenance.dart';
import 'package:botp_auth/constants/transaction.dart';
import 'package:botp_auth/core/api_url/api_url.dart';
import 'package:botp_auth/utils/services/rest_service.dart';
import 'package:http/http.dart' as http;
import 'package:universal_html/html.dart';

class AuthenticatorRepository {
  // Get OTP sessions list (with no filter in response)
  Future<GetTransactionsListResponseModel> getTransactionsList(
      String bcAddress, TransactionStatus transactionStatus,
      {int? currentPage, int? pageSize}) async {
    // Set search parameters
    final Map<String, dynamic> queryParameters = {
      "userAddress": bcAddress,
      ...(currentPage != null ? {"page": currentPage.toString()} : {}),
      ...(pageSize != null ? {"size": pageSize.toString()} : {}),
      ...(transactionStatus != TransactionStatus.all
          ? {"status": transactionStatus.name.toUpperCase()}
          : {})
    };
    http.Response result = await get(makeApiUrlString(
        path: "/message/OTPsessions", queryParameters: queryParameters));
    if (result.statusCode == HttpStatus.ok) {
      // Mark result - for calling multiple asynchronous requests in parallel
      final returnObj =
          GetTransactionsListResponseModel.fromJSON(json.decode(result.body));
      returnObj.markedResult(transactionStatus);
      return returnObj;
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

  // Get transaction detail
  Future<GetTransactionDetailResponseModel> getTransactionDetail(
      String secretId) async {
    http.Response result =
        await get(makeApiUrlString(path: "/message/OTPsessions/$secretId"));
    if (result.statusCode == HttpStatus.ok) {
      return GetTransactionDetailResponseModel.fromJSON(
          json.decode(result.body));
    }
    throw Exception(result.body);
  }

  // Provenance
  Future<ProvenanceEventResponseModel> getProvenanceEvent(
      ProvenanceEventType eventType, ProvenanceInfo provenanceInfo) async {
    final data = provenanceInfo.toJSON();
    final path = eventType == ProvenanceEventType.broadcast
        ? "/provenance/eventBroadcast"
        : "/provenance/eventHistory";
    // Especially the provenance case: use try catch
    try {
      http.Response result = await post(makeApiUrlString(path: path), data);
      if (result.statusCode == HttpStatus.ok) {
        // - Extract data
        final provenanceEventData = json.decode(result.body);
        final explorerId =
            provenanceEventData["logs"]["data"][0]["transactionHash"];
        final decodeResultData = provenanceEventData["decode"]["result"];
        // - Map data
        return ProvenanceEventResponseModel(
          eventType: eventType,
          broadcastEventData: eventType == ProvenanceEventType.broadcast
              ? BroadcastEventData(
                  agentBcAddress: decodeResultData["agentAddr"],
                  userBcAddress: decodeResultData["userAddr"],
                  id: decodeResultData["id"],
                  encryptedMessage: decodeResultData["encMessage"],
                  explorerId: explorerId)
              : null,
          historyEventData: eventType == ProvenanceEventType.history
              ? HistoryEventData(
                  agentBcAddress: decodeResultData["agentAddr"],
                  userBcAddress: decodeResultData["userAddr"],
                  id: decodeResultData["id"],
                  signature: decodeResultData["signature"],
                  encryptedMessage: decodeResultData["encMessage"],
                  explorerId: explorerId,
                )
              : null,
        );
      }
      throw Exception(result.body);
    } on Exception {
      return ProvenanceEventResponseModel(eventType: eventType);
    }
  }
}
