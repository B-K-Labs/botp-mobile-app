// RestAPI to remote server
import 'dart:convert' as convert;
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Map<String, String> _defaultHeaders = {
  HttpHeaders.contentTypeHeader: "application/json",
};

Map<String, String> _combineHeaders(String? token,
        Map<String, String> headers) =>
    token != null
        ? {
            ..._defaultHeaders,
            HttpHeaders.authorizationHeader: token,
            ...headers
          }
        : {..._defaultHeaders, ...headers};

void printRequestInfo(http.Response response, {dynamic body}) {
  if (kDebugMode) {
    print('Request Info:');
    print('URL: ${response.request!.url}');
    print('Method: ${response.request!.method}');
    print('Headers: ${response.request!.headers}');
    print('Body: $body');
  }
}

void printResponseInfo(http.Response response) {
  if (kDebugMode) {
    print('Response Info:');
    print('Status Code: ${response.statusCode}');
    print('Headers: ${response.headers}');
    print('Body: ${response.body}');
  }
}

Future<http.Response> get(url,
    [token, Map<String, String> otherHeaders = const {}]) async {
  final response = await http.get(Uri.parse(url),
      headers: _combineHeaders(token, otherHeaders));
  printRequestInfo(response);
  printResponseInfo(response);
  return response;
}

Future<http.Response> post(url, body,
    [token, Map<String, String> otherHeaders = const {}]) async {
  final response = await http.post(Uri.parse(url),
      headers: _combineHeaders(token, otherHeaders),
      body: convert.jsonEncode(body),
      encoding: convert.Encoding.getByName("utf-8"));
  printRequestInfo(response, body: body);
  printResponseInfo(response);
  return response;
}

Future<http.Response> put(url, body,
    [token, Map<String, String> otherHeaders = const {}]) async {
  final response = await http.put(Uri.parse(url),
      headers: _combineHeaders(token, otherHeaders),
      body: convert.jsonEncode(body),
      encoding: convert.Encoding.getByName("utf-8"));
  printRequestInfo(response, body: body);
  printResponseInfo(response);
  return response;
}

Future<http.Response> patch(url, body,
    [token, Map<String, String> otherHeaders = const {}]) async {
  final response = await http.patch(Uri.parse(url),
      headers: _combineHeaders(token, otherHeaders),
      body: convert.jsonEncode(body),
      encoding: convert.Encoding.getByName("utf-8"));
  printRequestInfo(response, body: body);
  printResponseInfo(response);
  return response;
}
