
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MarketWebView extends StatefulWidget {
  final String url;

  const MarketWebView(this.url);

  @override
  _MarketWebViewState createState() => _MarketWebViewState();
}

class _MarketWebViewState extends State<MarketWebView> {
  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  dispose(){
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);


    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body:Container()
      // WebView(
      //   initialUrl: widget.url,
      //   javascriptMode: JavascriptMode.unrestricted,
      //
      // ),
    );
  }
}
