import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controller/default_controller.dart';

class DefaultView extends GetView<DefaultController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Default',
          style: TextStyle(
            fontFamily: FontFamily.vazirLight,
            color: Get.theme.dividerColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Container(
        child: Container(),
      ),
    );
  }
}
