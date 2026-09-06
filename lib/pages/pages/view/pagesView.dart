import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controller/pages_controller.dart';

class PagesView extends GetView<PagesController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          controller.title.value.tr,
          style: TextStyle(
            fontFamily: FontFamily.vazirLight,
            color: Get.theme.dividerColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: controller.callPage.value != null &&
                  controller.callPage.value.data != null &&
                  controller.callPage.value.data != '' &&
                  controller.callPage.value.data != 'null'
              ? Container(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Html(
                  style: {
                    "*": Style(textAlign: TextAlign.right,direction: TextDirection.rtl,fontSize: FontSize.medium),
                  },

                  data: controller.callPage.value.data,),
              ),
            ),
          )
              : Container(),
        );
      }),
    );
  }
}
