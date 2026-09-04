import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/splash/controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(final BuildContext context) {
    // WidgetsBinding.instance!
    //     .addPostFrameCallback((_) async => await controller.getInit(context));
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xFFE6EFF8),
        body:   Column(
          children: <Widget>[
            Center(
              child: Container(
                  width: MediaQuery.of(context).size.width-50,
                  height: 700,
                  // child: VideoPlayer(controller.videoController)
        ),
            ),
          ],
        ),

      ),
    );
  }
}
