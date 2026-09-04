import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AssetsFormFiled extends StatelessWidget {
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final inputFormatters;
  final FocusNode? focus;
  final int? maxLength;

  final TextInputType? keyboardType;

  final TextEditingController? textController;

  const AssetsFormFiled(this.textController, {
    this.hintText,
    this.keyboardType,
    this.maxLength,
    this.inputFormatters,
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
      inputFormatters: inputFormatters,
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
