import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:webazin/utils/utils.dart';

class AssetsWdButton extends StatelessWidget {
  String iconData;
  String title;
  Color color;
  GestureTapCallback onTap;

   AssetsWdButton({required this.iconData,required this.title,required this.color,required this.onTap});

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap:onTap,
      child: Container(
        width: 100,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: color,
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontFamily: FontFamily.vazirBold,
                  fontSize: 12,
                  color: Colors.black54.withOpacity(0.9),
                ),
              ),
              Container(
                child: SvgPicture.asset(
                  iconData,
                  color: Colors.black54.withOpacity(0.4),
                  width: 10,
                ),
              ).marginOnly(right: 2),
            ],
          ),
        ),
      ),
    );
  }
}
