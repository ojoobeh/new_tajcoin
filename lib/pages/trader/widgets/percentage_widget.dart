import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:webazin/utils/utils.dart';
import '../controllers/trade_controller.dart';

class PercentageWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    TradeController controller = Get.find<TradeController>();
    return Container(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => controller.setPercentageCurrency(25),
            child: Obx(() {
              return Container(
                width: (Get.width / 4) - 12,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value == 25
                          ? AppColors.orangeColor.withOpacity(
                              0.7,
                            )
                          : Get.theme.dividerColor.withOpacity(0.7),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '25%',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                ),
              );
            }),
          ),
          InkWell(
            onTap: () => controller.setPercentageCurrency(50),
            child: Obx(() {
              return Container(
                width: (Get.width / 4) - 12,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value == 50
                          ? AppColors.orangeColor.withOpacity(
                              0.7,
                            )
                          : Get.theme.dividerColor.withOpacity(
                              0.7,
                            ),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '50%',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                ),
              );
            }),
          ),
          InkWell(
            onTap: () => controller.setPercentageCurrency(75),
            child: Obx(() {
              return Container(
                width: (Get.width / 4) - 12,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value == 75
                          ? AppColors.orangeColor.withOpacity(
                              0.7,
                            )
                          : Get.theme.dividerColor.withOpacity(
                              0.7,
                            ),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '75%',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                ),
              );
            }),
          ),
          InkWell(
            onTap: () => controller.setPercentageCurrency(controller.isSell.value ? 100 : 99.75),
            child: Obx(() {
              return Container(
                width: (Get.width / 4) - 12,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value > 90
                          ? AppColors.orangeColor.withOpacity(
                              0.7,
                            )
                          : Get.theme.dividerColor.withOpacity(
                              0.7,
                            ),
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    '100%',
                    style: TextStyle(
                      fontFamily: FontFamily.vazirBold,
                      color: Get.theme.dividerColor,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
