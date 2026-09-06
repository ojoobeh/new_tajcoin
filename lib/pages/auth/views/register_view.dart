import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';

import '../../../utils/assets.dart';
import '../controllers/auth_controller.dart';
import '../widget/text_form_field_2_widget.dart';

class RegisterView extends GetView<AuthController> {
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
                    iconData: Assets.email,
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
                        color: Get.theme.dividerColor,
                      ),
                    ),
                  );
                }),

                Obx(() {
                  return TextFormField2Widget(
                    hintText: "Password Confirmation".tr,
                    iconData: Assets.key,
                    // initialValue: controller.currentUser?.value?.password,
                    onChanged: (input) => controller.rePassword.value = input,
                    validator: (input) => input!.length < 3 ? "Should be more than 3 characters".tr : null,
                    obscureText: controller.hideConfirmationPassword.value,
                    keyboardType: TextInputType.visiblePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        controller.hideConfirmationPassword.value = !controller.hideConfirmationPassword.value;
                      },
                      color: Theme.of(context).focusColor,
                      icon: Icon(controller.hideConfirmationPassword.value ?
                      Icons.visibility_outlined : Icons.visibility_off_outlined,
                        color: Get.theme.dividerColor,),

                    ),
                  );
                }),


                TextFormField2Widget(
                  controller: controller.rgParentIdController,
                  hintText: "Identification code".tr,
                  keyboardType: TextInputType.number,
                  onChanged: (input) {
                    return controller.parentId.value = input;
                  },
                  validator: (input) {
                    return input!.length != 11 && !input.startsWith('09') ? "Mobile is not true" : null;
                  },
                  iconData: Assets.person,
                  isLast: false,
                  isFirst: false,
                ),

                SizedBox(
                  width: Get.width,
                  child: InkWell(
                    onTap: () => controller.register(),
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
                              "Register".tr,
                              style: TextStyle(
                                color: Get.theme.primaryColor,
                                fontFamily: FontFamily.vazirBold,
                              ),
                            ),
                          )
                              : SpinKitWave(color: context.theme.canvasColor//todo_selectedRowColor
                            , size: 24, type: SpinKitWaveType.start);
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
