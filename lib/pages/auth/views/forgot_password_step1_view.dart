

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';

import '../../../utils/assets.dart';
import '../controllers/auth_controller.dart';
import '../widget/text_form_field_2_widget.dart';

class ForgotPasswordStep1View extends GetView<AuthController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: Container(
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
                  margin: const EdgeInsets.only(top: 60),
                  child: TextFormField2Widget(
                    hintText: "Email".tr,
                    iconData: Assets.person,
                    keyboardType: TextInputType.emailAddress,
                    hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: (Get.theme.dividerColor), height: 1.2),
                    // initialValue: controller.currentUser.value.mobile.replaceAll('null', ''),
                    onChanged: (input) => controller.email.value = input,
                  ),
                ),


                SizedBox(
                  width: Get.width,
                  child: InkWell(
                    onTap:() {
                      controller.isLoading.isTrue ? null : controller.forgetPasswordStep1();
                    },
                    child: Container(
                      margin: const EdgeInsets.only(top: 64),
                      width: Get.width / 2,
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.orangeColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Obx(() {
                          return !controller.isLoading.value
                              ? Container(
                            child: Text(
                              "Get verify code".tr,
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontFamily: FontFamily.vazirBold,
                              ),
                            ),
                          )
                              : SpinKitWave(
                              // color: context.theme.highlightColor,//todo-REMOVE
                              size: 24, type: SpinKitWaveType.start,);
                        }),
                      ),
                    ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}

