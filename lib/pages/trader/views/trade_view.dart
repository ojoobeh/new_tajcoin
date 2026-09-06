import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get/get.dart';
import 'package:webazin/chart/line_chart_1.dart';
import 'package:webazin/currency_text_input_formatter.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/widgets/image.dart';

import '../../../utils/helper.dart';
import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../market/widgets/decimal_textInput_formatter.dart';
import '../controllers/trade_controller.dart';
import '../widgets/custom_form_fild.dart';
import '../widgets/navigation_bottom_widget.dart';
import '../widgets/percentage_widget.dart';
import '../widgets/trade_drawer_widget.dart';

class TradeView extends GetView<TradeController> {
  @override
  Widget build(final BuildContext context) {
    // controller.initScrollController();
    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        drawer: TradeDrawerWidget(),
        body: WillPopScope(
          onWillPop: Helper().onWillPop,
          child: Stack(
            children: <Widget>[
              RefreshIndicator(
                onRefresh: () async {
                  await controller.refreshHome(showMessage: true);
                },
                child: Obx(() {
                  //
                  return controller.selectCurrencies.value.id != null
                      ? Container(
                          child: ListView(
                            children: <Widget>[
                              Container(
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
                                                controller.selectCurrencies.value.name ?? '-*-',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: FontFamily.vazirLight,
                                                  color: context.theme.dividerColor.withOpacity(0.9),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }),
                                            SizedBox(width: 8),
                                            Container(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(4),
                                                ),
                                                color: controller.selectCurrencies.value.percent.contains("-") ? Colors.red.withOpacity(0.8) : AppColors.green.withOpacity(0.8),
                                              ),
                                              child: Text(
                                                controller.selectCurrencies.value.percent.toString() + " %",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                  fontFamily: FontFamily.vazirLight,
                                                ),
                                                textDirection: TextDirection.ltr,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Obx(() {
                                              return Text(
                                                getPrice(controller.price.toString()),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: FontFamily.vazirBold,
                                                  color: context.theme.dividerColor.withOpacity(0.9),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        // controller.selectCurrencies.value.symbol == 'USDT'
                                        //     ? Container()
                                        //     : InkWell(
                                        //         onTap: () async {
                                        //           SystemChrome.setPreferredOrientations([
                                        //             DeviceOrientation.landscapeLeft,
                                        //           ]);
                                        //           await Get.to(WebViewView (Core.laravelBaseUrl + 'chart/${controller.selectCurrencies.value.symbol}'));
                                        //
                                        //           SystemChrome.setPreferredOrientations([
                                        //             DeviceOrientation.portraitUp,
                                        //           ]);
                                        //         },
                                        //         child: Container(
                                        //           padding: EdgeInsets.all(2),
                                        //           child: SvgPicture.asset(
                                        //             Assets.candle01,
                                        //             width: 22,
                                        //             height: 22,
                                        //             color: context.theme.dividerColor.withOpacity(0.9),
                                        //           ),
                                        //         ),
                                        //       ),
                                        // SizedBox(
                                        //   width: 8,
                                        // ),
                                        // InkWell(
                                        //   onTap: () => controller.updtaeDataCurrencies(),
                                        //   child: Container(
                                        //     padding: EdgeInsets.all(2),
                                        //     child: SvgPicture.asset(
                                        //       Assets.star_empty,
                                        //       width: 22,
                                        //       height: 22,
                                        //       color: Colors.black54.withOpacity(0.9),
                                        //     ),
                                        //   ),
                                        // ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                             controller.selectCurrencies.value.chartData!.isNotEmpty? LineChartSample():image(Assets.noChart,height: 200),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  dailyButton(isActive: false, param: 'All', index: 0, onClick: (index) {}),
                                  dailyButton(isActive: false, param: '1y', index: 0, onClick: (index) {}),
                                  dailyButton(isActive: false, param: '3m', index: 0, onClick: (index) {}),
                                  dailyButton(isActive: false, param: '1m', index: 0, onClick: (index) {}),
                                  dailyButton(isActive: false, param: '1w', index: 0, onClick: (index) {}),
                                  dailyButton(isActive: true, param: '24h', index: 0, onClick: (index) {}),
                                ],
                              ),
                              Obx(() {
                                return Container(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  margin: const EdgeInsets.all(8),
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
                              }),
                              Container(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Price per unit".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      height: 50,
                                      margin: const EdgeInsets.only(top: 8),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Get.theme.dividerColor.withOpacity(0.8),
                                            width: 1,
                                          ),
                                          borderRadius: BorderRadius.circular(10)),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                getPrice(controller.price.value.toString()),
                                                style: TextStyle(
                                                  color: Get.theme.dividerColor,
                                                  fontSize: 14,
                                                  fontFamily: FontFamily.vazirBold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    //Price
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Amount".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
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
                                              child: CustomFormFiled(
                                                controller.tecQuantity,
                                                focus: controller.focusCount,
                                                inputFormatters: [DecimalTextInputFormatter(int.parse(controller.selectCurrencies.value.decimalSize!))],
                                                keyboardType: TextInputType.numberWithOptions(decimal: true),
                                                onChanged: (value) {
                                                  controller.setChangeCount(value);
                                                },
                                              ),
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
                                    //Quantity
                                    Container(
                                      margin: const EdgeInsets.only(
                                        top: 16,
                                        bottom: 8,
                                      ),
                                      child: PercentageWidget(),
                                    ),
                                    //Percentage
                                    Container(
                                      margin: const EdgeInsets.only(top: 14),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Center(
                                            child: Text(
                                              "Total price".tr + " (Irt) ".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
                                              ),
                                            ),
                                          ),
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
                                            child: Center(
                                              child: CustomFormFiled(
                                                controller.teTotalPrice,
                                                inputFormatters: <TextInputFormatter>[
                                                  CurrencyTextInputFormatter(
                                                    locale: 'ko',
                                                    decimalDigits: 0,
                                                    symbol: '',
                                                  ),
                                                ],
                                                keyboardType: TextInputType.number,
                                                hintText: 'Total price'.tr,
                                                focus: controller.focusTotal,
                                                onChanged: (value) {
                                                  controller.setChangetPrice(value);
                                                },
                                              ),
                                            ),
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

                                    //Total
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Obx(() {
                                            return Text(
                                              "Cash: ".tr +
                                                  (controller.isSell.value
                                                      ? sDouble((controller.selectCurrencies.value.countUser!.usd ?? 0).toString(),
                                                      decimal: int.parse(controller.selectCurrencies.value.decimalSize!)) +
                                                      " ${controller.selectCurrencies.value.symbol}"
                                                      : getPrice(controller.balanceIrt.value.toString()) + " IRT".tr),
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
                                                fontSize: 12,
                                                color: Get.theme.dividerColor.withOpacity(0.8),
                                              ),
                                            );
                                          }),
                                          Container(),
                                        ],
                                      ),
                                    ),

                                    NavigationBottomWidget(),
                                    Stack(
                                      children: <Widget>[
                                        InkWell(
                                          onTap: () {
                                            controller.scaffoldKey.currentState!.openDrawer();
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(top: 20),
                                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                            width: 300,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              border: Border.all(color: AppColors.green, width: 2),
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color(0x41d0cfcc),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "There are more currencies to trade on this page".tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 11,
                                                  fontFamily: FontFamily.vazirBold,
                                                  color: AppColors.green,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 20,
                                          top: 4,
                                          child: Icon(
                                            Icons.notifications,
                                            size: 32,
                                            color: Color(0xff82ff06),
                                          ),
                                        ),
                                      ],
                                    ).marginOnly(top: 32)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : Container();
                }),
              ),
              Obx(() {
                return controller.isLoading.value
                    ? Container(
                        color: Colors.black87.withOpacity(0.5),
                        child: Center(
                          child: CircularLoadingWidget(
                            height: 300,
                          ),
                        ),
                      )
                    : Container();
              })
            ],
          ),
        ),
      ),
    );
  }

  Widget dailyButton({
    required bool isActive,
    required String param,
    required int index,
    required Function(int index) onClick,
  }) {
    return StatefulBuilder(
        builder: (context, setState) => InkWell(
              onTap: () {
                setState(() {
                  onClick(index);
                });
              },
              child: Container(
                width: 50,
                height: 30,
                child: Text(
                  param,
                  style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: isActive ? Colors.green : Get.theme.disabledColor),
                ),
              ),
            ));
  }
}
