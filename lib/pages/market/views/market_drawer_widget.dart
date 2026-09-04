/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../trader/widgets/trade_custom_text_field_widget.dart';
import '../controllers/market_controller.dart';
import '../controllers/market_drawer_controller.dart';
import '../widgets/market_drawer_shimmer_list_widget.dart';

class MarketDrawerWidget extends GetWidget<MarketDrawerController> {
  @override
  Widget build(final BuildContext context) {
    return Drawer(
      child: Container(
        color: Get.theme.scaffoldBackgroundColor,
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 32),
              color: Get.theme.scaffoldBackgroundColor,
              padding: EdgeInsets.symmetric(horizontal: 8),
              height: 50,
              child: Row(
                children: <Widget>[
                  SvgPicture.asset(
                    Assets.search,
                    width: 22,
                    color: Get.theme.dividerColor,
                  ),
                  Flexible(
                      child: Container(
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Get.theme.dividerColor.withOpacity(0.8),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () => controller.refreshHome(
                            action: () => controller.update(),
                          ),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8,left: 8),
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Get.theme.dividerColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.green, width: 1),
                            ),
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 12,
                                color: Colors.green,
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Obx(() {
                            return controller.isOkk.value
                                ? TradeCustomTextFieldWidget(
                                    textController: controller.tecParamSearch,
                                    hintText: 'Desired currency'.tr,
                                    hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontFamily: FontFamily.vazirLight,
                                    ),
                                    keyboardType: TextInputType.text,
                                    maxLength: 50,
                                  )
                                : Container();
                          }),
                        ),
                        InkWell(
                          onTap: () => controller.resetSearch(),
                          child: Center(
                            child: Icon(
                              Icons.close,
                              size: 16,
                              color: Get.theme.dividerColor.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
            Flexible(
              child: Obx(() {
                return Container(
                  child: controller.stateSearching.isLoaded()
                      ? controller.marketList.length > 0
                          ? ListView.builder(
                              padding: EdgeInsets.only(bottom: 10, top: 10),
                              primary: false,
                              shrinkWrap: true,
                              controller: controller.scrollController,
                              itemCount: controller.marketList.length + 1,
                              itemBuilder: ((_, index) {
                                debugPrint("OK");
                                if (index == controller.marketList.length) {
                                  return Obx(() {
                                    return Container(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: Opacity(
                                          opacity: controller.stateLoading.isLoading() ? 1 : 0,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ),
                                    );
                                  });
                                } else {
                                  var currencies = controller.marketList.elementAt(index);
                                  if (currencies.symbol == "AVAX-USDT") {
                                    debugPrint("OK");
                                  }
                                  return Column(
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Get.find<MarketController>().changeCurrency(currencies);
                                          Get.back();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.zero,
                                          height: 64,
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Row(
                                                children: <Widget>[
                                                  currencies.icon!.contains(".svg")
                                                      ? SvgPicture.network(
                                                          currencies.icon!,
                                                          width: 20,
                                                          fit: BoxFit.cover,
                                                        ).marginOnly(left: 8,right: 8)
                                                      : Image.network(
                                                          currencies.icon!,
                                                          width: 20,
                                                          fit: BoxFit.cover,
                                                        ).marginOnly(left: 8,right: 8),
                                                  Text(
                                                    currencies.symbol,
                                                    style: TextStyle(
                                                      fontFamily: FontFamily.vazirLight,
                                                      fontSize: 13,
                                                      color: Get.theme.dividerColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Container(
                                                    margin: const EdgeInsets.only(left: 8,right: 8),
                                                    child: Text(
                                                      '\$ ' + sDouble(currencies.price.toString(), decimal: int.parse(currencies.decimal)),
                                                      style: TextStyle(
                                                        fontFamily: FontFamily.vazirLight,
                                                        fontSize: 12,
                                                        color: Get.theme.dividerColor.withOpacity(0.6),
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
                                                            : currencies.percent.contains("-")
                                                                ? Colors.red
                                                                : Colors.green,
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
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ).marginSymmetric(horizontal: 8),
                                      ),
                                      Divider(
                                        height: 1,
                                        indent: 8,
                                        endIndent: 8,
                                        color: Colors.grey,
                                      )
                                    ],
                                  );
                                }
                              }),
                            )
                          : Container(
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Nothing found".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ).marginOnly(bottom: 16),
                                  InkWell(
                                    onTap: () => controller.refreshHome(action: () => controller.update()),
                                    child: Icon(
                                      Icons.refresh,
                                      size: 32,
                                    ),
                                  )
                                ],
                              )),
                            )
                      : MarketDrawerShimmerListWidget(),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
