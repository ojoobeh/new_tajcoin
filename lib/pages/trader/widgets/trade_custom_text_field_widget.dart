/*
 * Copyright (c) 2020 .
 */


import 'package:flutter/material.dart';
import 'package:get/get.dart';


class TradeCustomTextFieldWidget extends StatelessWidget {
  const TradeCustomTextFieldWidget({
    Key? key,
    this.onSaved,
      this.onChanged,
    this.validator,
    this.hintStyle,
    this.inputFormatters,
    this.keyboardType,
    this.initialValue,
    this.hintText,
    this.colorIconData,
    this.errorText,
    this.labelText,
    this.sizeIconData,
    this.suffixIcon,
    this.obscureText=false,
    this.isFirst=false,
    this.isLast=false,
    this.maxLength,
    this.textController,
    this.style,
    this.textAlign,
    this.suffix,
  }) : super(key: key);

  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final String? initialValue;
  final int? maxLength;
  final  inputFormatters;
  final double? sizeIconData;
  final Color? colorIconData;
  final String? hintText;
  final TextEditingController? textController;
  final String? errorText;
  final TextAlign? textAlign;
  final String? labelText;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final bool obscureText;
  final bool isFirst;
  final bool isLast;
  final Widget? suffixIcon;
  final Widget? suffix;

  @override
  Widget build(final BuildContext context) {
    return  TextFormField(
      maxLines: 1,
      keyboardType: keyboardType ??
          TextInputType.numberWithOptions(decimal: true),
      controller: textController,
      key: key,
      validator: (input) =>
      input!.length < 3 ?
      "Should be more than 3 characters".tr : null,
      style: TextStyle(
        color: Get.theme.dividerColor,
      ),
      obscureText: false,
      inputFormatters: inputFormatters,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,

      maxLength: maxLength??100,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        hintText: hintText ,
        hintStyle:hintStyle?? TextStyle(
          color: Get.theme.dividerColor,
        ),
        hintTextDirection: TextDirection.ltr,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }

  BorderRadius get buildBorderRadius {
    if (isFirst != null && isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast != null && isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (isFirst != null && !isFirst && isLast != null && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }

  double get topMargin {
    if ((isFirst != null && isFirst)) {
      return 20;
    } else if (isFirst == null) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast != null && isLast)) {
      return 10;
    } else if (isLast == null) {
      return 10;
    } else {
      return 0;
    }
  }
}
