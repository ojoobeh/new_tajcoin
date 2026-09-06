import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:webazin/utils/core.dart';

import '../../../utils/ui.dart';
import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/setting_sms_controller.dart';
import '../widget/auth_sms_custom_text_field_widget.dart';

class SettingSmsView extends GetView<SettingSmsController> {
  @override
  Widget build(final BuildContext context) {
    return Stack(
      children: <Widget>[
        Scaffold(
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          appBar: AppBar(
            title: Text(
              "Two-step login".tr,
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
          body: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        Assets.password_2,
                                        width: 22,
                                        color: Get.theme.dividerColor.withOpacity(0.7),
                                      ).marginSymmetric(
                                        horizontal: 14,
                                      ),
                                      Text(
                                        "Two-step authentication through SMS code".tr,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: FontFamily.vazirLight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return Container(
                                    child: Transform.scale(
                                      scale: 1.1,
                                      child: Switch(
                                        onChanged: (value) => controller.changeVerifyStatus("sms"),
                                        value: controller.isSMSVerify.value,
                                        activeColor: Colors.redAccent,
                                        activeTrackColor: Colors.orange,
                                        inactiveThumbColor: Colors.grey.shade600,
                                        inactiveTrackColor: Colors.grey.shade200,
                                      ),
                                    ),
                                  );
                                }).marginSymmetric(
                                  horizontal: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        Assets.svEmail,
                                        width: 22,
                                        color: Get.theme.dividerColor.withOpacity(0.7),
                                      ).marginSymmetric(
                                        horizontal: 14,
                                      ),
                                      Text(
                                        "Two-step authentication via email".tr,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: FontFamily.vazirLight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return Container(
                                    child: Transform.scale(
                                      scale: 1.1,
                                      child: Switch(
                                        onChanged: (value) => controller.changeVerifyStatus('email'),
                                        value: controller.isEmailVerify.value,
                                        activeColor: Colors.redAccent,
                                        activeTrackColor: Colors.orange,
                                        inactiveThumbColor: Colors.grey.shade600,
                                        inactiveTrackColor: Colors.grey.shade200,
                                      ),
                                    ),
                                  );
                                }).marginSymmetric(
                                  horizontal: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Get.theme.dividerColor.withOpacity(0.4),
                    endIndent: 16,
                    indent: 16,
                  ),
                  Container(
                    height: 50,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      SvgPicture.asset(
                                        Assets.google,
                                        width: 22,
                                        color: Get.theme.dividerColor.withOpacity(0.7),
                                      ).marginSymmetric(
                                        horizontal: 14,
                                      ),
                                      Text(
                                        "Google Authenticator two-step login".tr,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: FontFamily.vazirLight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Obx(() {
                                  return Container(
                                    child: Transform.scale(
                                      scale: 1.1,
                                      child: Switch(
                                        onChanged: (value) => controller.changeVerifyStatus('google'),
                                        value: controller.isGoogleVerify.value,
                                        activeColor: Colors.redAccent,
                                        activeTrackColor: Colors.orange,
                                        inactiveThumbColor: Colors.grey.shade600,
                                        inactiveTrackColor: Colors.grey.shade200,
                                      ),
                                    ),
                                  );
                                }).marginSymmetric(
                                  horizontal: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'To enable or disable this feature, follow the steps below:',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontFamily: FontFamily.vazirBold,
                    ),
                  ).marginOnly(top: 16, right: 8),
                  Text(
                    'SettingSms1'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.dividerColor.withOpacity(0.8),
                      fontFamily: FontFamily.vazirBold,
                    ),
                  ).marginOnly(top: 14, right: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      QrImageView(
                        data: controller.getQrCode(Core.user.setting!.google2FaSecret!),
                        version: QrVersions.auto,
                        size: 200.0,
                        foregroundColor: Get.theme.dividerColor,
                      ),
                    ],
                  ),
                  Text(
                    'Enter a provided key (using the key): Select this option and enter the following code carefully'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.dividerColor.withOpacity(0.8),
                      fontFamily: FontFamily.vazirBold,
                    ),
                  ).marginOnly(top: 14, right: 8),
                  Row(
                    children: <Widget>[
                      Text(
                        Core.user.setting!.google2FaSecret!,
                        style: TextStyle(
                          fontSize: 18,
                          color: Get.theme.dividerColor.withOpacity(1),
                          fontFamily: FontFamily.vazirBold,
                        ),
                      ).marginOnly(top: 14, right: 8, left: 8),
                      InkWell(
                        onTap: () {
                          Clipboard.setData(ClipboardData(text: Core.user.setting!.google2FaSecret!));
                          Get.showSnackbar(
                            Ui.SuccessSnackBar(
                              message: "Copy Successfully".tr,
                            ),
                          );
                        },
                        child: Container(
                          width: 80,
                          height: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: AppColors.green,
                          ),
                          child: Center(
                            child: Text(
                              'Copy',
                              style: TextStyle(
                                fontFamily: FontFamily.vazirBold,
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    '3. Enter the received code (6-digit number) in the box below and click the activation button.'.tr,
                    style: TextStyle(
                      fontSize: 12,
                      color: Get.theme.dividerColor.withOpacity(0.8),
                      fontFamily: FontFamily.vazirBold,
                    ),
                  ).marginOnly(top: 14, right: 8),
                  AuthSmsCustomTextFieldWidget(
                    onChanged: (input) => controller.googleCode.value = input,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
                    initialValue: '',
                    hintText: "Six digit code".tr,
                    labelText: "Six digit code".tr,
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 50,
                      child: MaterialButton(
                        onPressed: () => controller.g2fLoginStatus(),
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: AppColors.orangeColor,
                        child: Text(controller.isGoogleVerify.value ? "Activate Google Authenticator".tr : "Disable Google Authenticator".tr,
                            style: Get.textTheme.labelLarge!.merge(TextStyle(color: Get.theme.primaryColor))),
                        elevation: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Obx(() {
          return controller.isLoading.value
              ? Container(
                  color: Colors.black87.withOpacity(0.5),
                  child: Center(
                    child: CircularLoadingWidget(
                      height: 300,
                    ),
                  ),
                )
              : Container();
        }),
      ],
    );
  }
}
