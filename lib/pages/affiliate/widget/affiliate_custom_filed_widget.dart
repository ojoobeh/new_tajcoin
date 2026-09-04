import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';

class AffiliateCustomFieldWidget extends StatelessWidget {

  const AffiliateCustomFieldWidget({super.key,
    this.onChange,
    this.param,
    this.title,
    this.initialValue,
    this.iconData,
    this.keyboardType,
    this.validator,
  });
  final ValueChanged<String>? onChange;
  final FormFieldValidator? validator;
  final String? param;
  final String? title;
  final String? iconData;
  final String? initialValue;
  final TextInputType? keyboardType;

  @override
  Widget build(final BuildContext context) => Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Get.theme.dividerColor.withOpacity(0.8),
          )),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: TextFormField(
        key: key,
        keyboardType: keyboardType ?? TextInputType.text,
        onChanged: onChange,
        validator: validator,
        initialValue: initialValue ,
        style: TextStyle(
          fontFamily: FontFamily.vazirBold,
          fontSize: 16,
          color: Get.theme.dividerColor.withOpacity(0.8),
        ),
      ),
    );
}
