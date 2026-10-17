
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

    super.initState();
  }

  @override
  dispose(){

    super.dispose();
  }

  @override
  Widget build(final BuildContext context) {



    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,

      //todo-REMOVE
      body: Container(),
      // body: WebView(
      //   initialUrl: widget.url,
      //   javascriptMode: JavascriptMode.unrestricted,
      //
      // ),
    );
  }
}
