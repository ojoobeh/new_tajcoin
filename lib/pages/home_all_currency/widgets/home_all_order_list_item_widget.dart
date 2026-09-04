/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../../webazin/data/dto/dto.dart';

import 'package:webazin/utils/utils.dart';
import '../../root/controllers/root_controller.dart';
import '../../trader/controllers/trade_controller.dart';
import '../controllers/home_all_order_controller.dart';

class HomeAllOrderListItemWidget extends GetView<HomeAllOrderController> {
  DataCurrency dataMarketOrderList;
  String status;
  int index;

  HomeAllOrderListItemWidget({required this.dataMarketOrderList, required this.status, required this.index});

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      DataCurrency currencies = controller.currencies.value[index];
      debugPrint('dddddddddddddd');
      return Column(
        children: <Widget>[
          InkWell(
            onTap: () {
              RootController rootController = Get.find<RootController>();
              TradeController tradeController = Get.find<TradeController>();
              tradeController.selectCurrency(currencies);
              rootController.changePage(2);
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.zero,
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      currencies.iconUrl!.contains(".svg")
                          ? SvgPicture.network(
                              currencies.iconUrl!,
                              width: 20,
                              fit: BoxFit.cover,
                            ).marginOnly(left: 8)
                          : Image.network(
                              currencies.iconUrl!,
                              width: 20,
                              fit: BoxFit.cover,
                            ).marginOnly(left: 8),
                      Text(
                        currencies.symbol!,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirLight,
                          fontSize: 13,
                          color: context.theme.dividerColor,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text(
                                getPrice(currencies.irtPrice.toString(), limit: 0),
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 14,
                                  color: context.theme.dividerColor.withOpacity(0.9),
                                ),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                ' IRT'.tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 10,
                                  color: context.theme.dividerColor.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$ ' + currencies.price.toString(),
                            style: TextStyle(
                              fontFamily: FontFamily.vazirLight,
                              fontSize: 12,
                              color: context.theme.dividerColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: currencies.percent == "0"
                            ? Colors.grey
                            : currencies.percent.length > 1 && currencies.percent.contains("-")
                                ? Colors.red
                                : AppColors.green,
                        borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Center(
                        child: Text(
                      currencies.percent.toString() + " %",
                      style: TextStyle(
                        fontFamily: FontFamily.vazirBold,
                        fontSize: 12,
                      ),
                      textDirection: TextDirection.ltr,
                    )),
                  )
                ],
              ),
            ).marginSymmetric(horizontal: 16),
          ),
          Divider(
            height: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          )
        ],
      );
    });
  }
}
