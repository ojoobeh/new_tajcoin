/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    this.onSaved,
    this.onChanged,
    this.controller,
    this.validator,
    this.hintStyle,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.iconData,
    this.labelText,
    this.suffixIcon,
    this.isFirst=false,
    this.obscureText=false,
    this.isLast=false,
    this.style,
    this.textAlign,
    this.suffix,
  });

  final onSaved;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final IconData? iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 14, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            labelText ?? "",
            style: TextStyle(
                fontSize: 12.0,
                fontFamily: FontFamily.vazirBold,
                fontWeight: FontWeight.w400,
                color: Get.theme.dividerColor,
                height: 1.2),
            textAlign: textAlign ?? TextAlign.start,
          ),
          TextFormField(
            maxLines: keyboardType == TextInputType.multiline ? null : 1,
            key: key,
            keyboardType: keyboardType ?? TextInputType.text,
            onSaved: onSaved,
            onChanged: onChanged,
            validator: validator,
            initialValue: initialValue ,
            style: style ??
                TextStyle(
                    fontSize: 12.0,
                    fontFamily: FontFamily.vazirLight,
                    color: Get.theme.dividerColor.withOpacity(0.8),
                    height: 1.2),
            obscureText: obscureText ,
            textAlign: textAlign ?? TextAlign.start,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: Color.fromRGBO(160, 160, 160, 1.0),
              ),
              prefixIcon: iconData != null
                  ? Icon(
                      iconData,
                      color: Get.theme.focusColor,
                      size: 16,
                    ).marginOnly(right: 20, left: 20)
                  : SizedBox(),
              prefixIconConstraints: iconData != null
                  ? BoxConstraints.expand(width: 18, height: 18)
                  : BoxConstraints.expand(width: 0, height: 0),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              contentPadding: EdgeInsets.all(0),
              border: OutlineInputBorder(borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
              suffixIcon: suffixIcon,
              suffix: suffix,
              errorText: errorText,
            ),
          ),
        ],
      ),
    );
  }
}
