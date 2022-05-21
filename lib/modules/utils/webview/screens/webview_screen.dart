import 'dart:async';
import 'package:botp_auth/widgets/common.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatelessWidget {
  final String url;
  const WebViewScreen(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenWidget(
        appBarTitle: "VBC Blockchain Explorer", body: WebViewBody(url));
  }
}

class WebViewBody extends StatefulWidget {
  final String url;
  const WebViewBody(this.url, {Key? key}) : super(key: key);

  @override
  State<WebViewBody> createState() => _WebViewBodyState();
}

class _WebViewBodyState extends State<WebViewBody> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return WebView(
        initialUrl: widget.url, javascriptMode: JavascriptMode.unrestricted);
  }
}
