import 'package:botp_auth/configs/environment/environment.dart';

final baseApiUrl = Environment().config.baseApiUri;
String makeApiUrlString(
    {String path = "", Map<String, String> queryParameters = const {}}) {
  final Uri baseApiUri = Uri.parse(baseApiUrl);
  return Uri(
    scheme: baseApiUri.scheme,
    host: baseApiUri.host,
    port: baseApiUri.port,
    path: '${baseApiUri.path}$path',
    queryParameters: queryParameters,
  ).toString();
}
