import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/helper.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../controllers/auth_controller.dart';
import '../widget/text_form_field_2_widget.dart';

class LoginView extends GetView<AuthController> {
  @override
  Widget build(final BuildContext context) {
    return WillPopScope(
      onWillPop: Helper().onWillPop,
      child: Scaffold(
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
                      hintText: "Email or phone".tr,
                      iconData: Assets.person,
                      keyboardType: TextInputType.emailAddress,
                      hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, color: (Get.theme.dividerColor), height: 1.2),
                      // initialValue: controller.currentUser.value.mobile.replaceAll('null', ''),
                      onChanged: (input) => controller.email.value = input,
                    ),
                  ),
                  Obx(() {
                    return TextFormField2Widget(
                      hintText: "Password".tr,
                      iconData: Assets.key,
                      // initialValue: controller.currentUser?.value?.password,
                      onChanged: (input) => controller.password.value = input,
                      validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                      obscureText: controller.hidePassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.hidePassword.value = !controller.hidePassword.value;
                        },
                        color: Theme.of(context).focusColor,
                        icon: Icon(
                          controller.hidePassword.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                    );
                  }),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.FORGOT_PASSWORDSTEP1);
                        },
                        child: Text("Forgot Password ?".tr),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text(
                          "You don't have an account ?".tr,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ).paddingSymmetric(vertical: 20),
                    ],
                  ).paddingSymmetric(horizontal: 20),
                  SizedBox(
                    width: Get.width,
                    child: InkWell(
                      onTap: () => controller.login(),
                      child: Container(
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
                                "Login".tr,
                                style: TextStyle(
                                  color: Get.theme.primaryColor,
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 14,
                                ),
                              ),
                            )
                                : SpinKitWave(color: context.theme.highlightColor, size: 24, type: SpinKitWaveType.start);
                          }),
                        ),
                      ).paddingOnly(top: 15, bottom: 5, right: 20, left: 20),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
