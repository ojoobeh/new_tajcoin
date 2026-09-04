import 'package:flutter/material.dart';
import 'package:get/get.dart';


import 'package:webazin/utils/utils.dart';
import '../controllers/market_controller.dart';

class MarketPercentageProWidget extends StatelessWidget {
  @override
  Widget build(final BuildContext context) {
    MarketController controller = Get.find<MarketController>();
    return Container(
      width: Get.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () => controller.setPercentageProCurrency(25),
            child: Obx(() {
              return Container(
                width: (Get.width / 8)+4,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value == 25
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
            onTap: () => controller.setPercentageProCurrency(50),
            child: Obx(() {
              return Container(
                width: (Get.width / 8)+4,
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
            onTap: () => controller.setPercentageProCurrency(75),
            child: Obx(() {
              return Container(
                width: (Get.width / 8)+4,
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
            onTap: () => controller.setPercentageProCurrency(100),
            child: Obx(() {
              return Container(
                width: (Get.width / 8)+4,
                padding: EdgeInsets.only(top: 8, bottom: 4),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: controller.persentageValue.value >90
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
