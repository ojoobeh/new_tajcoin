import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/bankCardController.dart';

class BankCardBottomSheetWidget extends GetWidget<BankCardController> {
  final Function(String)? onChange;
  final FormFieldValidator? validator;
  final String? initialValue;
  final String? title;
  final String? hintText;
  final String? labelText;
  final IconData? iconData;
  final TextInputType? keyboardType;

  BankCardBottomSheetWidget({
    this.onChange,
    this.initialValue,
    this.title,
    this.validator,
    this.hintText,
    this.labelText,
    this.iconData,
    this.keyboardType,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 305,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Center(
              child: Text(
                title!,
                style: TextStyle(
                  color: Get.theme.dividerColor,
                ),
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}
