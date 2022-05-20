import 'package:botp_auth/configs/environment/environment.dart';
import 'package:botp_auth/constants/api.dart';

final mainApiUrl = Environment().config.mainApiUri;
final bcExplorerApiUrl = Environment().config.bcExplorerApiUri;

String makeApiUrlString(
    {String path = "",
    Map<String, dynamic> queryParameters = const {},
    urlType = ApiUrlType.main}) {
  final Uri baseApiUri = Uri.parse(mainApiUrl);
  return Uri(
    scheme: baseApiUri.scheme,
    host: baseApiUri.host,
    port: baseApiUri.port,
    path: '${baseApiUri.path}$path',
    queryParameters: queryParameters,
  ).toString();
}
