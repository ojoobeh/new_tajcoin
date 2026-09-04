import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketCustomFormFiled extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final inputFormatters;
  final FocusNode? focus;
  final int? maxLength;

  final TextInputType? keyboardType;

  final TextEditingController? textController;

  const MarketCustomFormFiled(this.textController, {
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    this.focus,
    this.onChanged,
  });

  @override
  Widget build(final BuildContext context) {
    return TextFormField(
      maxLines: 1,
      keyboardType: keyboardType ??
          TextInputType.numberWithOptions(decimal: true),
      controller: textController,
      key: key,
      focusNode: focus,
      onChanged: onChanged,

      validator: (input) =>
      input!.length < 3 ?
      "Should be more than 3 characters".tr : null,
      style: TextStyle(
        color: Get.theme.dividerColor,
      ),
      obscureText: false,
      inputFormatters: inputFormatters,
      textAlign: TextAlign.center,
      maxLength: maxLength??100,
      buildCounter: (context, {required currentLength, required isFocused, maxLength}) => null,
      textAlignVertical: TextAlignVertical.center,

      decoration: InputDecoration(
        hintText: hintText ,
        hintStyle: TextStyle(
          color: Get.theme.dividerColor,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: EdgeInsets.all(0),
        border: OutlineInputBorder(borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
      ),
    );
  }
}
