import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../../../../webazin/data/dto/dto.dart';

import 'package:webazin/utils/utils.dart';

class HistoryItemListTicket extends StatelessWidget {
  final DataHistory dataHistory;

  const HistoryItemListTicket(this.dataHistory);

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Get.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Colors.black54.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Currency: '.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Row(
                  children: <Widget>[
                    Text(dataHistory.currency!,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirLight,
                          fontSize: 12,
                          color: Get.theme.dividerColor,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Get.theme.dividerColor.withOpacity(0.4),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Created At: '.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(dataHistory.createdAtFa,
                    style: TextStyle(
                      fontFamily: FontFamily.vazirLight,
                      fontSize: 12,
                      color: Get.theme.dividerColor,
                    )),
              ],
            ),
          ),
          Divider(
            height: 1,
            color: Get.theme.dividerColor.withOpacity(0.4),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Price: '.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(dataHistory.price ?? '',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirLight,
                      fontSize: 12,
                      color: Get.theme.dividerColor,
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Wage'.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(dataHistory.wage ?? '',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirLight,
                      fontSize: 12,
                      color: Get.theme.dividerColor,
                    )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Description'.tr,
                  style: TextStyle(
                    fontFamily: FontFamily.vazirBold,
                    fontSize: 14,
                    color: Get.theme.dividerColor,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(dataHistory.description ?? '',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirLight,
                      fontSize: 12,
                      color: Get.theme.dividerColor,
                    )),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.blueGrey.shade100,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                )),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Status: '.tr,
                      style: TextStyle(
                        fontFamily: FontFamily.vazirBold,
                        fontSize: 14,
                        color: Get.theme.scaffoldBackgroundColor,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: dataHistory.statusColor != null
                            ? dataHistory.statusColor == 'green'
                                ? AppColors.green
                                : dataHistory.statusColor == 'blue'
                                    ? Colors.blue.shade800
                                    : Colors.red.shade800
                            : AppColors.green,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: Center(
                        child: Text(dataHistory.statusFaText ?? '',
                            style: TextStyle(
                              fontFamily: FontFamily.vazirLight,
                              fontSize: 10,
                              color: context.theme.highlightColor,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
