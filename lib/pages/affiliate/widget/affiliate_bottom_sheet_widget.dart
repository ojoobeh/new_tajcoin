import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/affiliate/controllers/affiliate_controller.dart';

class AffiliateBottomSheetWidget extends GetWidget<AffiliateController> {

  const AffiliateBottomSheetWidget({super.key, 
    this.onChange,
    this.initialValue,
    this.title,
    this.validator,
    this.hintText,
    this.labelText,
    this.iconData,
    this.keyboardType,
  });
  final Function(String)? onChange;
  final FormFieldValidator? validator;
  final String? initialValue;
  final String? title;
  final String? hintText;
  final String? labelText;
  final IconData? iconData;
  final TextInputType? keyboardType;

  @override
  Widget build(final BuildContext context) => Container(
      height: 305,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
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
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
        ],
      ),
    );
}
