import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';
import 'package:webazin/widgets/image.dart';

class ItemStatusWidget extends StatelessWidget {
  final onTap;
  final String? title;
  final String? subTitle;
  final String? icon;
  final Color? color;
  final double? size;

  const ItemStatusWidget({
    this.onTap,
    this.title,
    this.subTitle,
    this.icon,
    this.color,
    this.size,
  });

  @override
  Widget build(final BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.theme.cardColor,
        borderRadius: BorderRadius.circular(8)
      ),
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.symmetric(horizontal: 4),
      child: InkWell(
        onTap: onTap,
        child: Column(
          spacing: 8,
          children: <Widget>[
            image(
              icon!,
              width: 32,
              height: 32,
              color: color
              // width: size,
              // height: size,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Icon(Icons.arrow_back_ios,size: 10,color: color,),
                Text(
                  subTitle!,
                  style: TextStyle(
                    fontSize: 6,
                    fontWeight: FontWeight.w400,
                    fontFamily: FontFamily.vazirBold,
                    color: context.theme.dividerColor,
                  ),
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
