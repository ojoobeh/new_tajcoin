import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/assets.dart';

import '../../../utils/config_app.dart';
import '../../../utils/core.dart';
import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/market_controller.dart';
import '../widgets/decimal_textInput_formatter.dart';
import '../widgets/list_market_order_book.dart';
import '../widgets/list_shimmer_market_order_book.dart';
import '../widgets/market_custom_form_fild.dart';
import '../widgets/market_list_item_widget.dart';
import '../widgets/market_percentage_widget.dart';
import 'market_webview.dart';

class MarketLimitView extends GetView<MarketController> {
  @override
  Widget build(final BuildContext context) {
    bool isShowHelper = getBool('${Core.helperMarket}');

    if (!isShowHelper) {
      controller.showTutorial(context);
    }

    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Stack(
        children: <Widget>[
          Container(
            height: 50,
            width: double.infinity,
            color: context.theme.colorScheme.secondary,
          ),
          Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        controller.scaffoldKey.currentState!.openDrawer();
                      },
                      child: Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesome.align_right,
                              color: context.theme.dividerColor.withOpacity(0.9),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Obx(() {
                              return Text(
                                controller.isSelectMarket.value ? controller.selectMarketList.value.symbol : "---",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: FontFamily.vazirLight,
                                  color: context.theme.dividerColor.withOpacity(0.9),
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                            SizedBox(
                              width: 8,
                            ),
                            Obx(() {
                              return !controller.isLoadingOrder.value && controller.isSelectMarket.value
                                  ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(4),
                                  ),
                                  color: (controller.isSelectMarket.value ? controller.selectMarketList.value.percent : "0").contains("-") ? Colors.red.withOpacity(0.8) : Colors.green.withOpacity(0.8),
                                ),
                                child: Text(
                                  (controller.isSelectMarket.value ? controller.selectMarketList.value.percent : "0") + " %",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontFamily: FontFamily.vazirLight,
                                  ),
                                  textDirection: TextDirection.ltr,
                                ),
                              )
                                  : Shimmer.fromColors(
                                baseColor: Get.theme.cardColor,
                                highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(4),
                                    ),
                                    color: Colors.green.withOpacity(0.8),
                                  ),
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  width: 50,
                                  height: 24,
                                ),
                              );
                            }),
                            SizedBox(
                              width: 8,
                            ),
                            Obx(() {
                              return !controller.isLoadingOrder.value && controller.isSelectMarket.value
                                  ? Text(
                                      controller.close.value.toString(),
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: FontFamily.vazirBold,
                                        color: context.theme.dividerColor.withOpacity(0.9),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : Shimmer.fromColors(
                                      baseColor: Get.theme.cardColor,
                                      highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(vertical: 4),
                                        width: 50,
                                        height: 16,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(2),
                                          color: Colors.grey,
                                        ),
                                      ),
                                    );
                            }),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        controller.selectMarketList.value.symbol == 'USDT'
                            ? Container()
                            : InkWell(
                                onTap: () async {
                                  await SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.landscapeLeft,
                                    DeviceOrientation.landscapeRight,
                                  ]);
                                  String web = Core.laravelBaseUrl + 'chart/${controller.selectMarketList.value.symbol}';
                                  await Get.to(MarketWebView(web));

                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitDown,
                                  ]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(2),
                                  child: SvgPicture.asset(
                                    Assets.candle01,
                                    width: 22,
                                    height: 22,
                                    color: context.theme.dividerColor.withOpacity(0.9),
                                  ),
                                ),
                              ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Container(
                  height: Get.height - 50,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(top: 16),
                          color: Get.theme.scaffoldBackgroundColor,
                          width: double.infinity,
                          height: 450,
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                width: Get.width / 2 - 80,
                                height: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Transaction".tr,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Get.theme.dividerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Price".tr,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Get.theme.dividerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Container(
                                        height: 180,
                                        child: Obx(() {
                                          return controller.listDown.length > 0
                                              ? ListMarketOrderBook(
                                                  controller.listDown,
                                                  Colors.green,
                                                  reverse: true,
                                                  limit: 7,
                                                )
                                              : ListShimmerMarketOrderBook(7);
                                        }),
                                      ),
                                    ),
                                    Obx(() {
                                      return controller.isLoadingOrder.value || controller.close == '0'
                                          ? Shimmer.fromColors(
                                              baseColor: Get.theme.cardColor,
                                              highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                                              child: Container(
                                                height: 30,
                                                child: Container(
                                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                                  width: 80,
                                                  height: 16,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(2),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () => controller.changeTPrice2(controller.close.value),
                                              child: Container(
                                                height: 30,
                                                child: Center(
                                                  child: Text(
                                                    sDouble(controller.close.value, decimal: int.parse(controller.selectMarketList.value.decimal)),
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Get.theme.dividerColor.withOpacity(0.8),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                    }),
                                    Container(
                                      height: 20,
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            "Transaction".tr,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Get.theme.dividerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            "Price".tr,
                                            textDirection: TextDirection.ltr,
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: Get.theme.dividerColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Directionality(
                                      textDirection: TextDirection.ltr,
                                      child: Container(
                                        height: 180,
                                        child: Obx(() {
                                          return controller.listUp.length > 0
                                              ? ListMarketOrderBook(
                                                  controller.listUp,
                                                  Colors.red,
                                                  reverse: false,
                                                  limit: 7,
                                                )
                                              : ListShimmerMarketOrderBook(7);
                                        }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: Get.width / 2 + 50,
                                height: double.infinity,
                                child: Column(
                                  children: <Widget>[
                                    Obx(
                                      () {
                                        return Container(
                                          padding: EdgeInsets.symmetric(vertical: 8),
                                          child: Directionality(
                                            textDirection: TextDirection.rtl,
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.end,
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    controller.changeSeller(true);
                                                  },
                                                  child: Stack(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                        Assets.sell01,
                                                        width: 104,
                                                        height: 38,
                                                        color: controller.isSell.value ? AppColors.strongWordsColor : Colors.grey.shade400,
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'SELL'.tr,
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.vazirBold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    controller.changeSeller(false);
                                                  },
                                                  child: Stack(
                                                    children: <Widget>[
                                                      SvgPicture.asset(
                                                        Assets.buy01,
                                                        width: 104,
                                                        height: 38,
                                                        color: !controller.isSell.value ? AppColors.cursorColor : Colors.grey.shade400,
                                                      ),
                                                      Positioned.fill(
                                                        child: Align(
                                                          alignment: Alignment.center,
                                                          child: Text(
                                                            'BUY'.tr,
                                                            style: TextStyle(
                                                              fontFamily: FontFamily.vazirBold,
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(top: 4),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Exchange rate".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirLight,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          ConfigApp.orderPlane
                                              ? Wrap(
                                                  children: <Widget>[
                                                    Container(
                                                      key: controller.keyButton1,
                                                      width: 80,
                                                      height: 25,
                                                      child: InkWell(
                                                        onTap: () => controller.setIsLimit(false),
                                                        child: Container(
                                                          width: 80,
                                                          height: 25,
                                                          decoration: BoxDecoration(
                                                              color: Colors.blueGrey.withOpacity(0.5),
                                                              borderRadius: BorderRadius.circular(4),
                                                              border: Border.all(
                                                                color: Colors.blueGrey,
                                                              )),
                                                          child: Center(
                                                            child: Text(
                                                              "Market".tr,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                color: context.theme.dividerColor.withOpacity(
                                                                  0.5,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      key: controller.keyButton2,
                                                      width: 80,
                                                      margin: const EdgeInsets.only(right: 8),
                                                      height: 25,
                                                      decoration: BoxDecoration(
                                                          color: Colors.red.withOpacity(0.5),
                                                          borderRadius: BorderRadius.circular(4),
                                                          border: Border.all(
                                                            color: Colors.red,
                                                          )),
                                                      child: Center(
                                                        child: Text(
                                                          "limit".tr,
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            color: context.theme.dividerColor.withOpacity(
                                                              0.5,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ) //
                                              : Container(),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.dividerColor.withOpacity(0.8),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () => controller.setTPrice(true),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
                                              width: 50,
                                              height: 40,
                                              child: Icon(
                                                FontAwesome5.plus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Obx(() => Center(
                                                  child: MarketCustomFormFiled(
                                                    controller.tePerPrice,
                                                    focus: controller.focusPrice,
                                                    inputFormatters: [DecimalTextInputFormatter(int.parse(controller.selectMarketList.value.decimal))],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    onChanged: (value) {
                                                      controller.changeTPrice(value);
                                                    },
                                                  ),
                                                )),
                                          ),
                                          InkWell(
                                            onTap: () => controller.setTPrice(false),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
                                              width: 50,
                                              height: double.infinity,
                                              child: Icon(
                                                FontAwesome5.minus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Amount".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirLight,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    //Dolor Price
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.dividerColor.withOpacity(0.8),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8)),
                                      height: 45,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () => controller.setCount(true),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
                                              width: 50,
                                              height: double.infinity,
                                              child: Icon(
                                                FontAwesome5.plus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Obx(() => MarketCustomFormFiled(
                                                    controller.tecQuantity,
                                                    inputFormatters: [DecimalTextInputFormatter(int.parse(controller.selectMarketList.value.decimal))],
                                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                    focus: controller.focusCount,
                                                    onChanged: (value) {
                                                      controller.changeCount(value);
                                                    },
                                                  )),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => controller.setCount(false),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), bottomLeft: Radius.circular(8))),
                                              width: 50,
                                              height: double.infinity,
                                              child: Icon(
                                                FontAwesome5.minus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 16,
                                      ),
                                      child: MarketPercentageWidget(),
                                    ),
                                    //Percentage
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Total price".tr + " (USDT)",
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirLight,
                                              ),
                                            ),
                                          ),
                                          Container(),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      height: 45,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.dividerColor.withOpacity(0.8),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(8)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () => controller.setTotalPrice(true),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
                                              width: 50,
                                              height: 40,
                                              child: Icon(
                                                FontAwesome5.plus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: MarketCustomFormFiled(
                                                controller.teTotalPrice,
                                                focus: controller.focusTotal,
                                                inputFormatters: [DecimalTextInputFormatter(Core.numberCountDecimal2)],
                                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                onChanged: (value) {
                                                  controller.changeTotalPrice(value);
                                                },
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () => controller.setTotalPrice(false),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Get.theme.dividerColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
                                              width: 50,
                                              height: double.infinity,
                                              child: Icon(
                                                FontAwesome5.minus,
                                                size: 14,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    Container(
                                      margin: const EdgeInsets.only(top: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Obx(() {
                                            return !controller.isLoadingOrder.value && controller.isSelectMarket.value
                                                ? Container(
                                                    height: 24,
                                                    child: Center(
                                                      child: Text(
                                                        "Cash: ".tr +
                                                            (controller.isSell.value
                                                                ? sDouble(controller.selectMarketList.value.balanceOne.toString(),
                                                                        decimal: int.parse(controller.selectMarketList.value.decimal)) +
                                                                    " (${controller.selectMarketList.value.symbol.replaceAll("USDT", "").replaceAll("-", "")})"
                                                                : sDouble(controller.selectMarketList.value.balanceTwo.toString(), decimal: Core.numberCountDecimal2) + " (USDT)"),
                                                        style: TextStyle(
                                                          fontFamily: FontFamily.vazirBold,
                                                          fontSize: 12,
                                                          color: Get.theme.dividerColor.withOpacity(0.8),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Shimmer.fromColors(
                                                    baseColor: Get.theme.cardColor,
                                                    highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                                                    child: Container(
                                                      margin: const EdgeInsets.symmetric(vertical: 4),
                                                      width: 120,
                                                      height: 16,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(2),
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  );
                                          }),
                                          Container(),
                                        ],
                                      ),
                                    ),

                                    Obx(() {
                                      return controller.isSell.value
                                          ? InkWell(
                                              onTap: () => controller.sellOrder(context),
                                              child: Container(
                                                height: 32,
                                                margin: const EdgeInsets.only(top: 8),
                                                width: MediaQuery.of(context).size.width - 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: AppColors.redGmail,
                                                ),
                                                child: Center(
                                                  child: controller.isLoadingOrder.value
                                                      ? Container()
                                                      : Text(
                                                          'Sell'.tr + " " + (controller.selectMarketList.value.symbol),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: FontFamily.vazirBold,
                                                            color: Get.theme.dividerColor,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () => controller.buyOrder(context),
                                              child: Container(
                                                height: 32,
                                                margin: const EdgeInsets.only(top: 8),
                                                width: MediaQuery.of(context).size.width - 100,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  color: AppColors.cursorColor,
                                                ),
                                                child: Center(
                                                  child: controller.isLoadingOrder.value
                                                      ? Container()
                                                      : Text(
                                                          'Buy'.tr + " " + (controller.selectMarketList.value.symbol != null ? controller.selectMarketList.value.symbol : ""),
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontFamily: FontFamily.vazirBold,
                                                            color: Get.theme.dividerColor,
                                                          ),
                                                        ),
                                                ),
                                              ),
                                            );
                                      // : InkWell(
                                      //     onTap: () => controller.buyOrder(context),
                                      //     child: Container(
                                      //       margin: const EdgeInsets.only(top: 16),
                                      //       width: MediaQuery.of(context).size.width - 100,
                                      //       padding: EdgeInsets.symmetric(vertical: 12),
                                      //       decoration: BoxDecoration(
                                      //         borderRadius: BorderRadius.circular(8),
                                      //         color: Get.theme.cursorColor,
                                      //       ),
                                      //       child: Obx(
                                      //         () {
                                      //           return Center(
                                      //             child: controller.isLoading.value
                                      //                 ? Loading(indicator: BallPulseIndicator(), size: 10.0)
                                      //                 : Text(
                                      //                     'Buy'.tr +
                                      //                         " " +
                                      //                         (Get.locale.languageCode == "fa" ? controller.selectCurrencies.value.name : controller.selectCurrencies.value.symbol),
                                      //                     style: TextStyle(
                                      //                       fontSize: 12,
                                      //                       fontFamily: FontFamily.vazirBold,
                                      //                       color: Get.theme.dividerColor,
                                      //                     ),
                                      //                   ),
                                      //           );
                                      //         },
                                      //       ),
                                      //     ),
                                      //   );
                                    }),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(right: 16, left: 16, top: 8),
                          height: 36,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: context.theme.colorScheme.secondary,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              InkWell(
                                onTap: () => Get.toNamed(Routes.MARKETALLORDER, arguments: controller.selectMarketList.value),
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.description,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      "Total orders".tr,
                                      style: TextStyle(
                                        fontFamily: FontFamily.vazirBold,
                                        color: Get.theme.dividerColor,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ],
                                ).marginOnly(right: 8),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "(Open orders)".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: context.theme.dividerColor.withOpacity(0.4),
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    "Open order",
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      color: context.theme.dividerColor.withOpacity(0.6),
                                    ),
                                  ).marginSymmetric(horizontal: 4),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return controller.isDoneOrder.value
                              ? controller.marketOrderList.isEmpty
                                  ? Center(
                                      child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 16,
                                      ),
                                      child: Text(
                                        'Order not found'.tr,
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirBold,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                  : Container(
                                      color: Get.theme.scaffoldBackgroundColor,
                                      child: ListView.builder(
                                        padding: EdgeInsets.only(bottom: 10, top: 10),
                                        primary: false,
                                        shrinkWrap: true,
                                        itemCount: controller.marketOrderList.length + 1,
                                        itemBuilder: ((_, index) {
                                          if (index == controller.marketOrderList.length) {
                                            return Obx(() {
                                              return Container(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Center(
                                                  child: Opacity(
                                                    opacity: controller.isLoadingOrder.value ? 1 : 0,
                                                    child: CircularProgressIndicator(),
                                                  ),
                                                ),
                                              );
                                            });
                                          } else {
                                            var _marketOrder = controller.marketOrderList.elementAt(index);

                                            return MarketListItemWidget(
                                              dataMarketOrderList: _marketOrder,
                                              status: "Open",
                                            );
                                          }
                                        }),
                                      ),
                                    )
                              : Center(
                                  child: CircularLoadingWidget(
                                    height: 100,
                                  ),
                                );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
