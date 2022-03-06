// RestAPI to remote server

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Map<String, String> _headers = {
  "Content-Type": "application/json",
};

Future<http.Response> get(url) async {
  return await http.get(
    Uri.parse(url),
  );
}

Future<http.Response> post(url, body) async {
  return await http.post(Uri.parse(url),
      body: convert.jsonEncode(body),
      encoding: convert.Encoding.getByName("utf-8"));
}

Future<http.Response> patch(url, body) async {
  return await http.patch(Uri.parse(url),
      body: convert.jsonEncode(body),
      encoding: convert.Encoding.getByName("utf-8"));
}
