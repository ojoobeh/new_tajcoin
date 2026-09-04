import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/profile_controller.dart';
import '../widget/custom_text_field_widget.dart';

class ProfileView extends GetView<ProfileController> {
  final bool hideAppBar;

  ProfileView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: hideAppBar
            ? null
            : AppBar(
                title: Text(
                  "Profile".tr,
                  style: context.textTheme.bodySmall,
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                automaticallyImplyLeading: false,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios,
                      color: Get.theme.hintColor),
                  onPressed: () => Get.back(),
                ),
                elevation: 0,
              ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Get.theme.focusColor.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    controller.saveProfileForm();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  color: AppColors.orangeColor,
                  child: Text("Save".tr,
                      style: Get.textTheme.labelLarge!
                          .merge(TextStyle(color: Get.theme.primaryColor))),
                  elevation: 0,
                ),
              ),
              // SizedBox(width: 10),
              // MaterialButton(
              //   onPressed: () {
              //     controller.resetProfileForm();
              //   },
              //   padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10)),
              //   color: Get.theme.hintColor.withOpacity(0.1),
              //   child: Text("Reset".tr, style: Get.textTheme.labelLarge),
              //   elevation: 0,
              // ),
            ],
          ).paddingSymmetric(vertical: 10, horizontal: 20),
        ),
        body: Form(
          key: controller.profileForm,
          child: ListView(
            primary: true,
            children: <Widget>[
              Text("Profile details".tr,
                  style: TextStyle(
                    color: Get.theme.dividerColor,
                  )).paddingOnly(top: 25, bottom: 10, right: 22, left: 22),
              CustomTextFieldWidget(
                controller:  controller.nameController,
                validator: (input) => input!.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                hintText: "Name".tr,
                labelText: "Name".tr,
                iconData: Assets.userName,
              ),
              Divider(
                height: 0.3,
                color: Get.theme.dividerColor.withOpacity(0.4),
                indent: 16,
                endIndent: 16,
              ),
              CustomTextFieldWidget(
                controller:  controller.userNameController,
                validator: (input) => input!.length < 3
                    ? "Should be more than 3 letters".tr
                    : null,
                hintText: "User Name".tr,
                labelText: "User Name".tr,
                iconData: Assets.userName,
              ),
              Divider(
                height: 0.3,
                color: Get.theme.dividerColor.withOpacity(0.4),
                indent: 16,
                endIndent: 16,
              ),
              CustomTextFieldWidget(
                controller:  controller.emailController,
                validator: (input) =>
                    !input!.contains('@') ? "Should be a valid email" : null,
                hintText: "Email",
                labelText: "Email".tr,
                iconData: Assets.svEmail,
              ),
              Divider(
                height: 0.3,
                color: Get.theme.dividerColor.withOpacity(0.4),
                indent: 16,
                endIndent: 16,
              ),
              CustomTextFieldWidget(
                controller:  controller.mobileController,
                keyboardType: TextInputType.phone,
                validator: (input) =>
                    input!.length != 11 && !input.startsWith('09')
                        ? "Mobile is not true".tr
                        : null,
                hintText: "Mobile".tr,
                labelText: "Mobile".tr,
                iconData: Assets.mobile,
              ),
              Text(
                "Change password".tr,
                style: TextStyle(
                  color: Get.theme.dividerColor,
                  fontSize: 16,
                  fontFamily: FontFamily.vazirBold,
                ),
              ).paddingOnly(top: 25, bottom: 0, right: 22, left: 22),
              Obx(() {
                return CustomTextFieldWidget(
                  controller:  controller.passwordController,
                  labelText: "New Password".tr,
                  hintText: "••••••••••••".tr,
                  validator: (input) {
                    if (input!.length > 0 && input.length < 3) {
                      return "Should be more than 3 letters".tr;
                    } else if (input != controller.confirmPassword.value) {
                      return "Passwords do not match".tr;
                    } else {
                      return null;
                    }
                  },
                  obscureText: controller.hidePassword.value,
                  iconData: Assets.password_2,
                  keyboardType: TextInputType.visiblePassword,
                  isFirst: false,
                  isLast: false,
                );
              }),
              Obx(() {
                return CustomTextFieldWidget(
                  controller:  controller.confirmPasswordController,
                  labelText: "Confirm Password".tr,
                  hintText: "••••••••••••".tr,
                  validator: (input) {
                    if (input!.length > 0 && input.length < 3) {
                      return "Should be more than 3 letters".tr;
                    } else if (input != controller.newPassword.value) {
                      return "Passwords do not match".tr;
                    } else {
                      return null;
                    }
                  },
                  obscureText: controller.hidePassword.value,
                  iconData: Assets.password_2,
                  keyboardType: TextInputType.visiblePassword,
                  isFirst: false,
                  isLast: true,
                );
              }),
              InkWell(
                onTap: () async {
                  debugPrint('Login Repeat>>>> 4');
                  await Get.offNamedUntil(
                    Routes.LOGIN,
                    (Route route) {
                      if (route.settings.name == Routes.LOGIN) {
                        return true;
                      }
                      return false;
                    },
                  );
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Get.theme.dividerColor, width: 1),
                  ),
                  child: Center(
                    child: Text('Log out'.tr),
                  ),
                ),
              ),
              controller.user.value.setting!.status!
                  ? Container()
                  : InkWell(
                      onTap: () => Get.toNamed(Routes.AUTHENTICATION),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.orangeColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                              color: Get.theme.dividerColor, width: 1),
                        ),
                        child: Center(
                          child: Text('Authentication'.tr),
                        ),
                      ),
                    ),
              Container(
                child: Text("Version: ${VERSIONNAME}",style: TextStyle(
                  fontFamily: FontFamily.vazirBold,
                  color: Get.theme.dividerColor,
                ),),
              ).marginSymmetric(horizontal: 16),
              // Container(
              //   padding: EdgeInsets.symmetric(vertical: 5),
              //   margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              //   decoration: Ui.getBoxDecoration(),
              //   child: Column(
              //     children: <Widget>[
              //       RadioListTile(
              //         value: ThemeMode.light,
              //         groupValue: controller.selectedThemeMode.value,
              //         onChanged: (value) {
              //           controller.changeThemeMode(value);
              //         },
              //         title: Text("Light Theme".tr, style: Get.textTheme.labelLarge),
              //       ),
              //       RadioListTile(
              //         value: ThemeMode.dark,
              //         groupValue: controller.selectedThemeMode.value,
              //         onChanged: (value) {
              //           controller.changeThemeMode(value);
              //         },
              //         title: Text("Dark Theme".tr, style: Get.textTheme.labelLarge),
              //       ),
              //
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
