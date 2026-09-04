import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';


import '../controllers/auth_controller.dart';
import '../widget/material_button_widget.dart';
import '../widget/text_form_field_widget.dart';

class ForgotPasswordView extends GetView<AuthController> {
  //test 2
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Forgot Password".tr,
          style: Get.textTheme.labelLarge,
        ),
        centerTitle: true,
        backgroundColor: Get.theme.primaryColor.withOpacity(0.8),
        automaticallyImplyLeading: false,
        elevation: 3,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: SingleChildScrollView(
          primary: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormFieldWidget(
                labelText: "Email".tr,
                hintText: "Email".tr,
                controller: controller.rgEmailController,
                keyboardType: TextInputType.emailAddress,
                hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: (Get.theme.dividerColor), height: 1.2),
                // initialValue: controller.currentUser.value.mobile.replaceAll('null', ''),
                onChanged: (input) => controller.email.value = input,
                validator: (input) {
                  return input!.length > 3 && !input.contains('@') ? "Email is not true".tr : null;
                },
              ),
              MaterialButtonWidget(
                  onPressed: () {
                    controller.isLoading.isTrue ? null : controller.forgetPasswordStep1();
                  },
                  color: AppColors.orangeColor,
                  text: Obx(() {
                    return controller.isLoading.isTrue
                        ? SpinKitWave(color: Colors.red, size: 24, type: SpinKitWaveType.start).marginOnly(top: 16)
                        : Text(
                            "Get verify code".tr,
                            style: Get.textTheme.bodySmall!.merge(TextStyle(color: Get.theme.primaryColor)),
                          );
                  })).paddingSymmetric(vertical: 10, horizontal: 20),
              Divider(
                height: 1,
                color: Get.theme.dividerColor.withOpacity(0.5),
              ),
              TextFormFieldWidget(
                controller: controller.rgCodeController,
                labelText: "Verify code".tr,
                hintText: "Verify code".tr,
                keyboardType: TextInputType.number,
                onChanged: (String? input) {
                  return controller.code = input??'';
                },
                validator: (input) {
                  return input!.length < 4 ? "Verify code is wrong".tr : null;
                },
                iconData: Icons.verified_user_outlined,
                isLast: false,
                isFirst: false,
              ),
              Obx(() {
                return TextFormFieldWidget(
                  controller: controller.rgPasswordController,
                  labelText: "Password".tr,
                  hintText: "••••••••••••".tr,
                  onChanged: (input) => controller.password.value = input,
                  validator: (input) => input!.length < 6 ? "Should be more than 5 characters".tr : null,
                  obscureText: controller.hidePassword.value,
                  iconData: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isLast: false,
                  isFirst: false,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.hidePassword.value = !controller.hidePassword.value;
                    },
                    color: Theme.of(context).focusColor,
                    icon: Icon(controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                );
              }),
              Obx(() {
                return TextFormFieldWidget(
                  controller: controller.rgRePasswordController,
                  labelText: "Password Confirmation".tr,
                  hintText: "••••••••••••".tr,
                  onChanged: (input) => controller.rePassword.value = input,
                  validator: (input) => input!.length < 6 ? "Should be more than 5 characters".tr : null,
                  obscureText: controller.hideConfirmationPassword.value,
                  iconData: Icons.lock_outline,
                  keyboardType: TextInputType.visiblePassword,
                  isLast: true,
                  isFirst: false,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.hideConfirmationPassword.value = !controller.hideConfirmationPassword.value;
                    },
                    color: Theme.of(context).focusColor,
                    icon: Icon(controller.hideConfirmationPassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                  ),
                );
              }),
              MaterialButtonWidget(
                onPressed: () {
                  controller.isLoading.isTrue ? null : controller.forgetPasswordStep2();
                },
                color: AppColors.orangeColor,
                text: Obx(() {
                  return controller.isLoading.isTrue
                      ? SpinKitWave(color: Colors.red, size: 24, type: SpinKitWaveType.start).marginOnly(top: 16)
                      : Text(
                          "Confirm".tr,
                          style: Get.textTheme.bodySmall!.merge(TextStyle(color: Get.theme.primaryColor)),
                        );
                }),
              ).paddingSymmetric(vertical: 10, horizontal: 20),
            ],
          ),
        ),
      ),
    );
  }
}
