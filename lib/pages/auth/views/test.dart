import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:webazin/utils/utils.dart';

import '../../../utils/helper.dart';
import '../../../utils/ui.dart';
import '../../../utils/assets.dart';

import '../../../utils/core.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/auth_controller.dart';

class GoogleVerificationView extends GetView<AuthController> {
  @override
  Widget build(final BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Google Verification".tr,
              style: Get.textTheme.bodySmall!.merge(TextStyle(color: context.theme.primaryColor)),
            ),
            centerTitle: true,
            backgroundColor: AppColors.orangeColor,
            automaticallyImplyLeading: false,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Get.theme.primaryColor),
              onPressed: () => {Get.back()},
            ),
          ),
          body: ListView(
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    height: 180,
                    width: Get.width,
                    decoration: BoxDecoration(
                      color: AppColors.orangeColor,
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(color: Get.theme.focusColor.withOpacity(0.2), blurRadius: 10, offset: Offset(0, 5)),
                      ],
                    ),
                    margin: const EdgeInsets.only(bottom: 50),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Text(
                            '${Core.appName}',
                            style: Get.textTheme.bodySmall!.merge(TextStyle(color: Get.theme.primaryColor, fontSize: 24)),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Welcome to ${Core.appName}!".tr,
                            style: Get.textTheme.labelSmall!.merge(TextStyle(color: Get.theme.primaryColor)),
                            textAlign: TextAlign.center,
                          ),
                          // Text("Fill the following credentials to login your account", style: Get.textTheme.labelSmall.merge(TextStyle(color: Get.theme.primaryColor))),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    decoration: Ui.getBoxDecoration(
                      radius: 14,
                      border: Border.all(width: 5, color: Get.theme.primaryColor),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(
                        Assets.logo,
                        fit: BoxFit.cover,
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Obx(() {
                if (controller.isLoading.value) {
                  return CircularLoadingWidget(height: 300);
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        "Please enter the 6-digit code from Google Authenticator".tr,
                        style: Get.textTheme.titleSmall,
                        textAlign: TextAlign.center,
                      ).paddingSymmetric(horizontal: 20, vertical: 20),
                      Container(
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
                      // BlockButtonWidget(
                      //   onPressed: () async {
                      //     if (controller.verifyCode.value.length == 4) {
                      //       await controller.getVerify();
                      //     } else {
                      //     }
                      //   },
                      //   color: AppColors.orangeColor,
                      //   text: Text(
                      //     "Verify".tr,
                      //     style: Get.textTheme.bodySmall!.merge(TextStyle(color: Get.theme.primaryColor)),
                      //   ),
                      // ).paddingSymmetric(vertical: 35, horizontal: 20),

                    ],
                  );
                }
              })
            ],
          )),
    );
  }
}
