import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';
import 'auth_custom_text_field_widget.dart';

class AuthenticationBottomSheetVerifyMobile extends GetWidget<AuthenticationController> {
  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.symmetric(vertical: 28, horizontal: 16),
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(26),
            topLeft: Radius.circular(26),
          )),
      child: Container(
        color: Colors.red,
        height: 200,
        child: Column(
          children: <Widget>[
            AuthCustomTextFieldWidget(
              textAlign: TextAlign.start,
              keyboardType: TextInputType.number,
              textEditingController: controller.textEditingController,
              validator: (input) => input!.length < 3 ? "Should be more than 3 letters".tr : null,
              hintText: "Verification code".tr,
              labelText: "Verification code".tr,
            ),
          ],
        ),
      ),
    );
  }
}
