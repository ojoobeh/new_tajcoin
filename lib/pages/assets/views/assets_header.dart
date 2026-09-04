import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
// import 'package:loading/indicator/ball_pulse_indicator.dart';
// import 'package:loading/loading.dart';
import 'package:webazin/chart/pieChart/pie_chart_sample2.dart';
import 'package:webazin/pages/assets/views/assetsChart.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/assets_controller.dart';
import '../widgets/botton_sheet_deposit_widget.dart';
import '../widgets/botton_sheet_with_drawal_widget.dart';

class AssetsHeader extends GetView<AssetsController> {
  const AssetsHeader({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22),
      child: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Total assets estimate'.tr,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: FontFamily.vazirBold,
                        color: context.theme.dividerColor,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    InkWell(
                      onTap: () => controller.visibleCash(),
                      child: Obx(() {
                        return Icon(
                          controller.isVisibleCash.value ? Icons.visibility : Icons.visibility_off,
                          color: context.theme.dividerColor,
                          size: 20,
                        );
                      }),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () async {
                    await controller.refreshHome();
                  },
                  child: Container(
                    height: 40,
                    child: Obx(() {
                      return
                        // controller.isLoading.value
                          // ? Loading(
                          //     indicator: BallPulseIndicator(),
                          //     size: 40.0,
                          //     color: Colors.white,
                          //   )
                          // :
                      SvgPicture.asset(
                              Assets.refresh,
                              color: context.theme.dividerColor,
                              width: 22,
                            );
                    }),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 14),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      'Cash: '.tr,
                      style: TextStyle(
                        color: context.theme.dividerColor,
                        fontSize: 12,
                        fontFamily: FontFamily.vazirBold,
                      ),
                    ),
                    Obx(() {
                      return controller.myIrt != null
                          ? Text(
                              !controller.isVisibleCash.value ? getPrice(controller.myIrt.value) + " " + " IRT".tr : "*******",
                              style: TextStyle(
                                color: context.theme.dividerColor,
                                fontSize: 16,
                                fontFamily: FontFamily.vazirBold,
                              ),
                            )
                          : Container();
                    }),
                  ],
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Row(
                    children: <Widget>[
                      Obx(() {
                        return controller.myUsd.value != null
                            ? Text(
                                controller.myUsd + " " + "\$".tr,
                                style: TextStyle(
                                  color: context.theme.dividerColor,
                                  fontSize: 16,
                                  fontFamily: FontFamily.vazirBold,
                                ),
                              )
                            : Container();
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Obx((){
            return  controller.listChartModel.length>0? SizedBox(
              width: double.infinity,
              height: 100,
              child: Obx(
                    () => InkWell(
                    onTap: () => Get.to(
                      AssetsChart(
                        list: controller.assets.value,
                        balance: double.parse(controller.myUsd.value ),
                      ),
                    ),
                    child: PieChartSample2(list: controller.listChartModel.value)),
              ),
            ):SizedBox();
          }),
          Obx(() {
            return controller.assetsIRT.value.currency != null
                ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: () {
                            if (controller.assets.length > 0) {
                              debugPrint(controller.assetsIRT.value.currency!.symbol);
                              controller.tTXID.value.text = '';

                              Get.bottomSheet(
                                BottomSheetDepositWidget(
                                  controller.assetsIRT.value,
                                ),
                                isDismissible: !controller.isDismissible.value,
                                enableDrag: controller.isDismissible.value,
                              );
                            }
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: context.theme.colorScheme.secondary,
                              boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 5, offset: Offset(0, 1))],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Deposit".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 16,
                                      color: context.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ),
                                  Icon(Icons.arrow_upward)
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            controller.tTXID.value.text = '';
                            Get.bottomSheet(
                              BottomSheetWithdrawalWidget(
                                controller.assetsIRT.value,
                              ),
                              isDismissible: !controller.isDismissible.value,
                              enableDrag: controller.isDismissible.value,
                            );
                          },
                          child: Container(
                            width: (MediaQuery.of(context).size.width / 3),
                            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: context.theme.colorScheme.secondary,
                              boxShadow: <BoxShadow>[BoxShadow(color: Colors.black54, blurRadius: 5, offset: Offset(0, 1))],
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Withdrawal".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 16,
                                      color: context.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ),
                                  Icon(Icons.arrow_downward)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container();
          })
        ],
      ),
    );
  }
}
