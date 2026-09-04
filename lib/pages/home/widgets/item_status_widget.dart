import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class ItemStatusWidget extends StatelessWidget {
  final onTap;
  final String? title;
  final String? icon;
  final double? size;

  const ItemStatusWidget({
    this.onTap,
    this.title,
    this.icon,
    this.size,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 60,
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            Image.asset(
              icon!,
              width: 32,
              height: 32,
              // width: size,
              // height: size,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              title!,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                fontFamily: FontFamily.vazirBold,
                color: context.theme.dividerColor,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
