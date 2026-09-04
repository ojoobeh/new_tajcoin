import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/dto/user.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';

class ItemSettingAuthWidget extends StatelessWidget {
  final String? title;
  final String? iconData;
  var onTop;

  ItemSettingAuthWidget({
    this.title,
    this.iconData,
    this.onTop,
  });

  @override
  Widget build(final BuildContext context) {
    DataUser user = Core.user;
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
                              Text(
                                title!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: FontFamily.vazirMedium,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: user.setting!.statusColor == "green"
                                      ? AppColors.green
                                      : user.setting!.statusColor == "orange"
                                          ? Colors.orange
                                          : user.setting!.statusColor == "blue"
                                              ? Colors.blue
                                              : user.setting!.statusColor == "red"
                                                  ? Colors.red
                                                  : Colors.grey,
                                ),
                                child: Text(
                                  user.setting!.statusText!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: FontFamily.vazirMedium,
                                  ),
                                ),
                              ),
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
