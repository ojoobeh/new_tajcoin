/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/dto/dto.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/market_controller.dart';

class MarketListItemWidget extends GetView<MarketController> {
  DataOrderMarket? dataMarketOrderList;
  String? status;

  MarketListItemWidget({this.dataMarketOrderList, this.status});

  @override
  Widget build(final BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: Get.theme.dividerColor.withOpacity(0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Directionality(
                textDirection: TextDirection.ltr,
                child: Container(
                  width: Get.width - 46,
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Row(
                              children: <Widget>[
                                dataMarketOrderList!.type == "فروش"
                                    ? Icon(
                                        Icons.arrow_upward,
                                        color: Colors.red,
                                        size: 16,
                                      )
                                    : Icon(
                                        Icons.arrow_downward_rounded,
                                        color: Colors.green,
                                        size: 16,
                                      ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  dataMarketOrderList!.type!,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirBold,
                                    color: dataMarketOrderList!.type == "فروش" ? Colors.red : Colors.green,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  dataMarketOrderList!.market!,
                                  style: TextStyle(
                                    fontFamily: FontFamily.vazirBold,
                                    color: Get.theme.dividerColor,
                                    fontSize: 12,
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Get.theme.dividerColor.withOpacity(0.05),
                                  ),
                                  child: Text(
                                    dataMarketOrderList!.createdAt!,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () => controller.cancelOrder(context, dataMarketOrderList!),
                            child: Container(
                              width: 80,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.red, width: 2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Text(
                                  'لغو',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          )
                        ],
                      ).marginOnly(top: 8),
                      Container(
                        margin: const EdgeInsets.only(top: 16, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: <Widget>[
                                  Text("Total price".tr),
                                  Text(
                                    (dataMarketOrderList?.sumPrice ?? '0').toString(),
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                      fontSize: 12,
                                    ),
                                  ).marginOnly(top: 8),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Text("Count".tr+" (${dataMarketOrderList!.market!.replaceAll("USDT", "").replaceAll("-", "")})"),
                                  Text(
                                    dataMarketOrderList!.count.toString(),
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                      fontSize: 12,
                                    ),
                                  ).marginOnly(top: 8),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: <Widget>[
                                  Text("Wage".tr),
                                  Text(
                                    dataMarketOrderList!.wage!,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                      fontSize: 12,
                                    ),
                                  ).marginOnly(top: 8),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                children: <Widget>[
                                  Text("Price".tr),
                                  Text(
                                    (dataMarketOrderList?.price ?? '0').toString(),
                                    style: TextStyle(fontFamily: FontFamily.vazirBold, color: Get.theme.dividerColor, fontSize: 12),
                                  ).marginOnly(top: 8),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ).marginSymmetric(horizontal: 16),
      ],
    );
  }
}
