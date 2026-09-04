import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/utils.dart';


class CustomDivider extends StatelessWidget {
  Color color;
  bool isVertical;
  final EdgeInsetsGeometry? margin;

  CustomDivider({this.color = AppColors.buttonColor, this.margin = EdgeInsets.zero, this.isVertical = false});

  @override
  Widget build(final BuildContext context) {
    return isVertical
        ? Container(
            margin: margin,
            height: double.infinity,
            width: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Get.theme.scaffoldBackgroundColor,
                  color,
                  Get.theme.scaffoldBackgroundColor,
                ],
              ),
            ),
          )
        : Container(
            margin: margin,
            height: 1,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  Get.theme.scaffoldBackgroundColor,
                  color,
                  Get.theme.scaffoldBackgroundColor,
                ],
              ),
            ),
          );
  }
}
