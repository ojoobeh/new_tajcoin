import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/assets_controller.dart';


class BottomSheetHelpWidget extends GetWidget<AssetsController> {
  String param;

  BottomSheetHelpWidget(this.param);

  @override
  Widget build(final BuildContext context) {
    controller.selectNetworksIndex.value = 0;
    return WillPopScope(
      onWillPop: () async => !controller.isDismissible.value,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            )),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () => Get.back(),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: Get.theme.dividerColor.withOpacity(0.5),
                    size: 32,
                  ),
                ),
                Text(
                  'Help'.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirLight,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ).marginOnly(bottom: 16),
                Divider(
                  height: 1,
                  color: Get.theme.dividerColor.withOpacity(0.3),
                  endIndent: 16,
                  indent: 16,
                ),
                Text(
                  param,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirLight,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ).marginOnly(bottom: 36),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
