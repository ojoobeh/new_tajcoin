/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class TicketTextFormField2Widget extends StatelessWidget {
  const TicketTextFormField2Widget({
    this.onSaved,
    this.onChanged,
    this.controller,
    this.validator,
    this.hintStyle,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.errorText,
    required this.iconData,
    this.suffixIcon,
    this.isFirst = false,
    this.obscureText = false,
    this.isLast = false,
    this.style,
    this.textAlign,
    this.suffix,
  });

  final onSaved;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final TextAlign? textAlign;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String iconData;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(final BuildContext context) {


    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: EdgeInsets.only(top: 10, bottom: 8, left: 10, right: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Image.asset(
              iconData,
              width: 26,
              height: 26,
              color: context.theme.dividerColor.withOpacity(0.7),
            ),
            Container(
              margin: const EdgeInsets.only(right: 18),
              width: Get.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFormField(
                    maxLines: keyboardType == TextInputType.multiline ? null : 1,
                    key: key,
                    keyboardType: keyboardType ?? TextInputType.text,
                    onChanged: onChanged,
                    style: style ??
                        TextStyle(
                          fontSize: 14.0,
                          fontFamily: FontFamily.vazirBold,
                          color: Get.theme.dividerColor.withOpacity(0.8),
                        ),
                    obscureText: obscureText ,
                    textAlign: textAlign ?? TextAlign.start,
                    decoration: InputDecoration(

                      hintText: hintText,
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(160, 160, 160, 1.0),
                        fontSize: 14.0,
                        fontFamily: FontFamily.vazirBold,
                      ),
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
                  Divider(
                    height: 3,
                    color: Get.theme.dividerColor.withOpacity(0.5),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );

  }
}
