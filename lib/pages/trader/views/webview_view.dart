
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewView extends StatefulWidget {
  final String url;

  const WebViewView(this.url);

  @override
  _WebViewViewState createState() => _WebViewViewState();
}

class _WebViewViewState extends State<WebViewView> {



  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }




  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container()
      // WebView(
      //   initialUrl: widget.url,
      //   javascriptMode: JavascriptMode.unrestricted,
      //
      // ),
    );
  }
}
