
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/utils/ui.dart';


class AnswerTicketsCustomTextFieldWidget extends StatelessWidget {
  const AnswerTicketsCustomTextFieldWidget({super.key,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.hintStyle,
    this.keyboardType,
    this.initialValue,
    this.hintText='',
    this.colorIconData,
    this.errorText,
    this.iconData,
    this.labelText,
    this.sizeIconData,
    this.obscureText=false,
    this.suffixIcon,
    this.isFirst=false,
    this.isLast=false,
    this.maxLength,
    this.style,
    this.textAlign,
    this.suffix,
  });

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? maxLength;
  final double? sizeIconData;
  final Color? colorIconData;
  final String hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(final BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            SvgPicture.asset(
              iconData!,
              width: 22,
              color: Get.theme.dividerColor.withOpacity(0.5),
            ).marginSymmetric(horizontal: 8),
            Text(
              labelText ?? "",
              style: TextStyle(
                color: Get.theme.dividerColor,
                fontSize: 14,
                fontFamily: FontFamily.vazirBold,
              ),
              textAlign: textAlign ?? TextAlign.start,
            ),
            Flexible(
              child: TextFormField(
                maxLines: keyboardType == TextInputType.multiline ? null : 1,
                key: key,
                keyboardType: keyboardType ?? TextInputType.text,
                onSaved: onSaved,
                onChanged: onChanged,
                validator: validator,
                maxLength: maxLength,
                initialValue: initialValue ,
                style: style ?? Get.textTheme.labelLarge,
                obscureText: obscureText ,
                textAlign: textAlign ?? TextAlign.end,
                decoration: Ui.getInputDecoration(
                  hintText: hintText ,
                  colorIconData: colorIconData,
                  sizeIconData: sizeIconData,
                  suffixIcon: suffixIcon,
                  suffix: suffix,
                  errorText: errorText,
                ),
              ),
            ),
          ],
        ),
      ],
    );

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return const BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return const BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return  const BorderRadius.all(Radius.circular(1));
    }
    return const BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if (isFirst != null && isFirst) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if (isLast != null && isLast) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
