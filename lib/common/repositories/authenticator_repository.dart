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
      "page": currentPage,
      "size": kTransactionItemsPagSize
    };
    if (transactionStatus != null) {
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

  // Discard transaction (step 2)
}
