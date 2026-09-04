import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../utils/core.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/trade_controller.dart';

class NavigationBottomWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    TradeController controller = Get.find<TradeController>();
    return Container(
      width: Get.width,
      child: Obx(() {
        return Core.user.apiToken != null
            ? Column(
                children: <Widget>[
                  controller.isSell.value
                      ? InkWell(
                          onTap: () => controller.sellOrder(context),
                          child: Container(
                            height: 50,
                            margin: const EdgeInsets.only(top: 16),
                            width: MediaQuery.of(context).size.width - 100,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.redGmail,
                            ),
                            child: Obx(() {
                              return Container();
                              // return Center(
                              //   child: controller.isLoading.value
                              //       ? Loading(indicator: BallPulseIndicator(), size: 10.0)
                              //       : Text(
                              //           'Sell'.tr + " " + (Get.locale!.languageCode == "fa" ? controller.selectCurrencies.value.name! : controller.selectCurrencies.value.symbol!),
                              //           style: TextStyle(
                              //             fontSize: 12,
                              //             fontFamily: FontFamily.vazirBold,
                              //             color: Get.theme.dividerColor,
                              //           ),
                              //         ),
                              // );
                            }),
                          ),
                        )
                      : InkWell(
                          onTap: () => controller.buyOrder(context),
                          child: Container(
                            margin: const EdgeInsets.only(top: 16),
                            width: MediaQuery.of(context).size.width - 100,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: AppColors.cursorColor,
                            ),
                            child: Obx(
                              () {
                                return Container();
                                // return Center(
                                //   child: controller.isLoading.value
                                //       ? Loading(indicator: BallPulseIndicator(), size: 10.0)
                                //       : Text(
                                //           'Buy'.tr +
                                //               " " +
                                //               (Get.locale!.languageCode == "fa" ? controller.selectCurrencies.value.name ?? '-*-' : controller.selectCurrencies.value.symbol ?? '-*-'),
                                //           style: TextStyle(
                                //             fontSize: 12,
                                //             fontFamily: FontFamily.vazirBold,
                                //             color: Get.theme.dividerColor,
                                //           ),
                                //         ),
                                // );
                              },
                            ),
                          ),
                        ),
                ],
              )
            : InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 16),
                  width: MediaQuery.of(context).size.width - 100,
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.orangeColor,
                  ),
                  child: Center(
                    child: Text(
                      'Log in/Sign Up'.tr,
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: FontFamily.vazirBold,
                        color: Get.theme.secondaryHeaderColor,
                      ),
                    ),
                  ),
                ),
              );
      }),
    );
  }
}
