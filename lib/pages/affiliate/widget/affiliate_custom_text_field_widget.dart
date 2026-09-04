import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/utils/ui.dart';

class AffiliateCustomTextFieldWidget extends StatelessWidget {

  const AffiliateCustomTextFieldWidget({super.key,
    this.labelText,
    this.hintText,
    this.keyboardType,
    this.textAlign,
    this.validator,
    this.initialValue,
    this.onChanged,
  });
  final String? labelText;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final FormFieldValidator<String>? validator;
  final String? initialValue;

  @override
  Widget build(final BuildContext context) => Container(
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
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: Get.theme.dividerColor,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: TextFormField(
              key: key,
              keyboardType: keyboardType??TextInputType.text,
              onChanged: onChanged,
              validator: validator,
              initialValue: initialValue ,
              style: TextStyle(
                fontFamily: FontFamily.vazirLight,
                fontSize: 14,
                color: Get.theme.dividerColor,
              ),
              textAlign: textAlign?? TextAlign.end,
              decoration: Ui.getInputDecoration(
                hintText: hintText ?? '',
              ),
            ),
          ).marginOnly(bottom: 8),
        ],
      ),
    );
}
