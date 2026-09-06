import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/ui.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/authentication_controller.dart';

class AuthCustomTextFieldWidget extends GetView<AuthenticationController> {
  final String? labelText;
  final String? hintText;
  final TextEditingController? textEditingController;
  final width;
  final keyboardType;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final GestureTapCallback? onTap;


  const AuthCustomTextFieldWidget({
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textAlign,
    this.validator,
    this.textEditingController,
    this.onTap,
    this.width= 0,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      width: width == 0 ? double.infinity : width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            labelText!,
            style: TextStyle(
              fontFamily: FontFamily.vazirLight,
              fontSize: 12,
              color: Get.theme.dividerColor.withOpacity(0.8),
            ),
          ).marginOnly(bottom: 8),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Get.theme.dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: Container(
                    child: TextFormField(
                      maxLines: 1,
                      key: key,
                      keyboardType: keyboardType ?? TextInputType.text,
                      controller: textEditingController,
                      validator: validator,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirLight,
                        fontSize: 14,
                        color: Get.theme.dividerColor,
                      ),
                      obscureText: false,
                      textAlign: textAlign ?? TextAlign.end,
                      decoration: Ui.getInputDecoration(
                        hintText: hintText ?? '',
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).marginOnly(bottom: 8),
        ],
      ),
    );
  }
}
