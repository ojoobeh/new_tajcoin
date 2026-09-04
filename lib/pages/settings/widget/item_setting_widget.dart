import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

class ItemSettingWidget extends StatelessWidget {
  final String? title;
  final String? iconData;
  var onTop;

  ItemSettingWidget({
    this.title,
    this.iconData,
    this.onTop,
  });

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: onTop,
          child: Container(
            height: 50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              SvgPicture.asset(
                                iconData!,
                                width: 22,
                                color: context.theme.dividerColor.withOpacity(0.7),
                              ).marginSymmetric(
                                horizontal: 14,
                              ),
                              Text(title??'', style: context.textTheme.titleLarge)
                            ],
                          ),
                        ),
                        SvgPicture.asset(
                          Assets.arrowLeft,
                          width: 12,
                          color: context.theme.dividerColor.withOpacity(0.7),
                        ).marginSymmetric(
                          horizontal: 16,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          color: context.theme.dividerColor.withOpacity(0.4),
          endIndent: 16,
          indent: 16,
        ),
      ],
    );
  }
}
