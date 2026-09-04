import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class AuthCustomTextWidget extends StatelessWidget {
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final keyboardType;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  const AuthCustomTextWidget({
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
            width: double.infinity,
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Get.theme.dividerColor,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  initialValue ?? '',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirLight,
                    fontSize: 14,
                    color: Get.theme.dividerColor.withOpacity(0.7),
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
