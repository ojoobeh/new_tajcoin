import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';


import '../controllers/authentication_controller.dart';
import '../widget/auth_custom_text_field_widget.dart';

class AuthenticationPasswordView extends GetView<AuthenticationController> {
  final bool hideAppBar;

  AuthenticationPasswordView({this.hideAppBar = false}) {
    // controller.profileForm = GlobalKey<FormState>();
  }

  @override
  Widget build(final BuildContext context) {
    printInfo(info: 'LastView');
    controller.profileForm = GlobalKey<FormState>();
    return  Scaffold(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        appBar: hideAppBar
            ? null
            : AppBar(
          title: Text(
            "Change password".tr,
            style: context.textTheme.bodySmall,
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
        bottomNavigationBar: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Get.theme.focusColor.withOpacity(0.1), blurRadius: 10, offset: Offset(0, -5)),
            ],
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: MaterialButton(
                  onPressed: () {
                    controller.updatePassword();
                  },
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  color: AppColors.orangeColor,
                  child: Text("Save".tr, style: Get.textTheme.labelLarge!.merge(TextStyle(color: Get.theme.primaryColor))),
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
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              primary: true,
              children: <Widget>[
                AuthCustomTextFieldWidget(
                  textEditingController: controller.oldPasswordController,
                  validator: (input) => input!.length < 6 ? "Should be more than 6 letters".tr : null,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Old Password".tr,
                  labelText: "Old Password".tr,
                ),
                AuthCustomTextFieldWidget(
                  textEditingController: controller.newPasswordController,
                  validator: (input) => input!.length < 6 ? "Should be more than 6 letters".tr : null,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "New Password".tr,
                  labelText: "New Password".tr,
                ),
                AuthCustomTextFieldWidget(
                  textEditingController: controller.confirmPasswordController,
                  validator: (input) => input!.length < 6 ? "Should be more than 6 letters".tr : null,
                  keyboardType: TextInputType.visiblePassword,
                  hintText: "Confirm Password".tr,
                  labelText: "Confirm Password".tr,
                ),
              ],
            ),
          ),
        ));
  }
}
