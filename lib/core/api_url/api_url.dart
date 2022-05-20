import 'package:botp_auth/configs/environment/environment.dart';
import 'package:botp_auth/constants/api.dart';

final mainApiUrl = Environment().config.mainApiUri;
final bcExplorerApiUrl = Environment().config.bcExplorerApiUri;

String makeApiUrlString(
    {String path = "",
    Map<String, dynamic>? queryParameters,
    urlType = ApiUrlType.main}) {
  final Uri baseApiUri = Uri.parse(mainApiUrl);
  final String url = Uri(
    scheme: baseApiUri.scheme,
    host: baseApiUri.host,
    port: baseApiUri.port,
    path: '${baseApiUri.path}$path',
    queryParameters: queryParameters,
  ).toString();
  return url;
}
