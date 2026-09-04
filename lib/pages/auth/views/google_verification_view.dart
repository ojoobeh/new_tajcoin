import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:webazin/utils/utils.dart';

import '../../../utils/assets.dart';
import '../controllers/auth_controller.dart';

class GoogleVerificationView extends GetView<AuthController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff19202b),
              Color(0xff3c4651),
            ],
          ),
        ),
        child: Stack(
          children: <Widget>[
            Positioned(
                bottom: 0,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    Assets.vector,
                    height: 150,
                    width: Get.width,
                    fit: BoxFit.fill,
                  ),
                )),
            ListView(
              primary: true,
              children: <Widget>[
                SizedBox(
                  height: 44,
                ),
                Image.asset(
                  Assets.logo,
                  width: 150,
                  height: 150,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60, left: 16, right: 16),
                  child: Text(
                    "Please enter the 6-digit code from Google Authenticator".tr,
                    style: TextStyle(fontFamily: FontFamily.vazirBold, color: AppColors.skype1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 30),
                  padding: EdgeInsets.symmetric(horizontal: 62, vertical: 8),
                  child: PinFieldAutoFill(
                    codeLength: 6,
                    autoFocus: true,
                    decoration: UnderlineDecoration(colorBuilder: FixedColorBuilder(Get.theme.dividerColor), textStyle: TextStyle(color: Get.theme.dividerColor)),
                    onCodeChanged: (input) {
                      controller.code = input.toString();
                      if (input!.length == 6) {
                        controller.getVerify();
                      }
                    },
                  ),
                ),
                Obx(() {
                  return Container(
                    child: InkWell(
                      onTap: () => controller.login(),
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: controller.time.value > 0
                              ? Text(
                            "Please wait a time seconds".tr.replaceAll('time', controller.time.value.toString()),
                            style: TextStyle(
                              fontFamily: FontFamily.vazirBold,
                              color: Get.theme.dividerColor,
                            ),
                          )
                              : Text(''),
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(
                  width: Get.width,
                  child: Container(
                    margin: const EdgeInsets.only(top: 30),
                    width: Get.width / 2,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Obx(() {
                        return !controller.isLoading.value
                            ? controller.code.length == 4
                            ? InkWell(
                            onTap: () => controller.login(),
                            child: Container(
                              child: Text(
                                "Login".tr,
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontFamily: FontFamily.vazirBold,
                                ),
                              ),
                            ))
                            : Container(
                          child: Text(
                            "Login".tr,
                            style: TextStyle(
                              color: Get.theme.primaryColor.withOpacity(0.4),
                              fontFamily: FontFamily.vazirBold,
                            ),
                          ),
                        )
                            : SpinKitWave(color: context.theme.highlightColor, size: 24, type: SpinKitWaveType.start);
                      }),
                    ),
                  ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                ),
                Obx(() {
                  return Container(
                    child: InkWell(
                      onTap: () => controller.login(),
                      child: Container(
                        width: 250,
                        height: 50,
                        margin: const EdgeInsets.only(top: 8),
                        child: Center(
                          child: controller.time.value > 0
                              ? Text(
                            "Please wait a time seconds".tr.replaceAll('time', controller.time.value.toString()),
                            style: TextStyle(
                              fontFamily: FontFamily.vazirBold,
                              color: Get.theme.dividerColor,
                            ),
                          )
                              : Text(''),
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
