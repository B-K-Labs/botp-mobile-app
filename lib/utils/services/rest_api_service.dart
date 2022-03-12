// RestAPI to remote server
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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

Future<http.Response> get(url,
        [token, Map<String, String> otherHeaders = const {}]) async =>
    await http.get(Uri.parse(url),
        headers: _combineHeaders(token, otherHeaders));

Future<http.Response> post(url, body,
        [token, Map<String, String> otherHeaders = const {}]) async =>
    await http.post(Uri.parse(url),
        headers: _combineHeaders(token, otherHeaders),
        body: convert.jsonEncode(body),
        encoding: convert.Encoding.getByName("utf-8"));

Future<http.Response> put(url, body,
        [token, Map<String, String> otherHeaders = const {}]) async =>
    await http.put(Uri.parse(url),
        headers: _combineHeaders(token, otherHeaders),
        body: convert.jsonEncode(body),
        encoding: convert.Encoding.getByName("utf-8"));

Future<http.Response> patch(url, body,
        [token, Map<String, String> otherHeaders = const {}]) async =>
    await http.patch(Uri.parse(url),
        headers: _combineHeaders(token, otherHeaders),
        body: convert.jsonEncode(body),
        encoding: convert.Encoding.getByName("utf-8"));
