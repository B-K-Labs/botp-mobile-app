import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        appBarTitle: "Blockchain Explorer", body: WebViewBody(url));
  }
}

class WebViewBody extends StatefulWidget {
  final String url;
  const WebViewBody(this.url, {Key? key}) : super(key: key);

  @override
  State<WebViewBody> createState() => _WebViewBodyState();
}

class _WebViewBodyState extends State<WebViewBody> {
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      //TODO: Handle exception come from Uri.parse
      controller: controller..loadRequest(Uri.parse(widget.url)),
    );
  }
}
