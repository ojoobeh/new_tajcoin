import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class AuthSmsCustomTextFieldWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const AuthSmsCustomTextFieldWidget({
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.onChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
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
            child: TextFormField(
              maxLines: 1,
              key: key,
              keyboardType: keyboardType ?? TextInputType.number,
              onChanged: onChanged,
              validator: validator,
              initialValue: initialValue ,
              style: TextStyle(
                fontFamily: FontFamily.vazirLight,
                fontSize: 14,
                color: Get.theme.dividerColor,
              ),
              obscureText: false,
              textAlign: TextAlign.center,
              maxLength: 6,
              decoration: InputDecoration(
                hintText: hintText ,
                counter: SizedBox.shrink(),
                border: InputBorder.none,
              ),
            ),
          ).marginOnly(bottom: 8),


        ],
      ),
    );
  }
}
