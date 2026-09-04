
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class CustomButtonMore extends StatelessWidget {
  String? title;
  String? iconData;
  GestureTapCallback? onTap;

  CustomButtonMore({this.title, this.iconData, this.onTap});

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        width: Get.width / 4 - 5,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              width: 36,
              height: 36,
              child: iconData != ""
                  ? Image.asset(
                iconData!,
              )
                  : Container(),
            ),
            Text(
              title!,
              style: TextStyle(
                color: Get.theme.dividerColor,
                fontFamily: FontFamily.vazirBold,
                fontSize: 11,
              ),
            )
          ],
        ),
      ),
    );
  }
}