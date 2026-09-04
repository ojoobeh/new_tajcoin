/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';


import 'package:webazin/utils/utils.dart';
import '../../../webazin/utilities.dart';
import '../controllers/market_all_order_controller.dart';

class MarketAllOrderListItemWidget extends GetView<MarketAllOrderController> {
  DataOrderMarket dataMarketOrderList;
  String status;

  MarketAllOrderListItemWidget({required this.dataMarketOrderList, required this.status});

  @override
  Widget build(final BuildContext context) {
    Color color = dataMarketOrderList.status == "Open".tr
        ? Colors.blue
        : dataMarketOrderList.status == "Cancel".tr
            ? Colors.red
            : AppColors.green;
    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          color: Get.theme.dividerColor.withOpacity(0.05),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              status == "All" || status == "AllAll"
                  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        width: Get.width - 46,
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      dataMarketOrderList.type == "فروش"
                                          ? Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                              size: 16,
                                            )
                                          : Icon(
                                              Icons.arrow_downward_rounded,
                                              color: AppColors.green,
                                              size: 16,
                                            ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        dataMarketOrderList.type!,
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirBold,
                                          color: dataMarketOrderList.type == "فروش" ? Colors.red : AppColors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        dataMarketOrderList.market!,
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirBold,
                                          color: Get.theme.dividerColor,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Get.theme.dividerColor.withOpacity(0.05),
                                  ),
                                  child: Text(
                                    dataMarketOrderList.createdAt!,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: Get.theme.dividerColor,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ).marginOnly(top: 8),
                            Divider(
                              height: 1,
                              color: Get.theme.dividerColor.withOpacity(1),
                            ).marginOnly(top: 8),
                            Container(
                              margin: const EdgeInsets.only(top: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text((dataMarketOrderList.count ?? 0).toString()).marginOnly(top: 8),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "(${dataMarketOrderList.market!.replaceAll("USDT", "").replaceAll("-", "")})",
                                              ),
                                              Text(
                                                "Count".tr,
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text((dataMarketOrderList.price ?? 0).toString()).marginOnly(top: 8),
                                        Text("Exchange rate".tr,style: TextStyle(
                                          fontSize: 12,),),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text((dataMarketOrderList.sumPrice ?? 0).toString()).marginOnly(top: 8),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "(USDT)",
                                              ),
                                              Text(
                                                "Cost of".tr,
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(dataMarketOrderList.wage!).marginOnly(top: 8),
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "Wage".tr,
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8, bottom: 4, right: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: color,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Center(child: Text(dataMarketOrderList.status!.trim())),
                                        ),
                                        Text("Status".tr),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : Directionality(
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
                                      dataMarketOrderList.type == "فروش"
                                          ? Icon(
                                              Icons.arrow_upward,
                                              color: Colors.red,
                                              size: 16,
                                            )
                                          : Icon(
                                              Icons.arrow_downward_rounded,
                                              color: AppColors.green,
                                              size: 16,
                                            ),
                                      SizedBox(
                                        width: 2,
                                      ),
                                      Text(
                                        dataMarketOrderList.type!,
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirBold,
                                          color: dataMarketOrderList.type == "فروش" ? Colors.red : AppColors.green,
                                          fontSize: 12,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        dataMarketOrderList.market!,
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
                                          dataMarketOrderList.createdAt!,
                                          style: TextStyle(
                                            fontFamily: FontFamily.vazirBold,
                                            color: Get.theme.dividerColor,
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.cancelOrder(context, dataMarketOrderList),
                                  child: Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.red, width: 2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Cancel'.tr,
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ).marginOnly(top: 8),
                            Container(
                              margin: const EdgeInsets.only(top: 16),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                "(USDT)",
                                              ),
                                              Text(
                                                "Cost of".tr,
                                                style: TextStyle(
                                                  fontSize: 12,
                                                ),
                                                textDirection: TextDirection.rtl,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          (dataMarketOrderList.sumPrice ?? 0).toString(),
                                        ).marginOnly(top: 8),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                         "Count".tr+ " (${dataMarketOrderList.market!.replaceAll("USDT", "").replaceAll("-", "")})",
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(
                                          dataMarketOrderList.count.toString(),
                                        ).marginOnly(top: 8),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Wage".tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text(dataMarketOrderList.wage!).marginOnly(top: 8),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(top: 8),
                                    child: Column(
                                      children: <Widget>[
                                        Text(
                                          "Exchange rate".tr,
                                          style: TextStyle(
                                            fontSize: 12,
                                          ),
                                        ),
                                        Text((dataMarketOrderList.price ?? 0).toString()).marginOnly(top: 8),
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
