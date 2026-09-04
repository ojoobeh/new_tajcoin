import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/authentication_controller.dart';

class AuthenticationBottomSheetPickImage extends GetWidget<AuthenticationController> {



  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(26),
            topLeft: Radius.circular(26),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          InkWell(
            onTap:() {
              controller.pickImage();
              Get.back();
            } ,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Get.theme.dividerColor.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.gallery,
                          color: Get.theme.dividerColor.withOpacity(0.5),
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ).marginOnly(bottom: 16),
                  Text(
                    'Gallery'.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 16,
                      color: Get.theme.dividerColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
          InkWell(
            onTap:() {
              controller.takeImage();
              Get.back();
            } ,
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Get.theme.dividerColor.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        Assets.camera,
                        color: Get.theme.dividerColor.withOpacity(0.5),
                        width: 64,
                        height: 64,
                      ),
                    ),
                  ).marginOnly(bottom: 16),
                  Text(
                    'Camera'.tr,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 16,
                      color: Get.theme.dividerColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
