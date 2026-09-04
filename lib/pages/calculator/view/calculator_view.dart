import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/assets.dart';

import '../../../utils/core.dart';
import '../../../utils/custom_devider.dart';
import 'package:webazin/utils/utils.dart';
import '../controller/calculator_controller.dart';
import '../widget/calculator_a_widget.dart';
import '../widget/calculator_b_widget.dart';

class CalculatorView extends GetView<CalculatorController> {
  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Calculator'.tr,
          style: TextStyle(
            color: context.theme.dividerColor,
            fontSize: 16,
            fontFamily: FontFamily.vazirBold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        automaticallyImplyLeading: false,
        elevation: 10,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.dividerColor),
          onPressed: () => {Get.back()},
        ),
      ),
      body: Container(
        child: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 32,
                ),
                Text('Digital currency converter'.tr),
                Image.asset(
                  Assets.vac,
                  width: 400,
                  height: 200,
                ),
                SizedBox(
                  height: 32,
                ),
                controller.isSell.value ? CalculatorAWidget() : CalculatorBWidget(),
                InkWell(
                  onTap: () => controller.changeSeller(),
                  child: Image.asset(
                    Assets.change,
                    width: 64,
                    height: 64,
                  ),
                ),
                !controller.isSell.value ? CalculatorAWidget() : CalculatorBWidget(),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: context.theme.dividerColor.withOpacity(0.2)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    Assets.usa,
                                    width: 32,
                                    height: 32,
                                  ),
                                  Text(
                                    'USDT equivalent'.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 14,
                                      color: context.theme.dividerColor.withOpacity(0.8),
                                    ),
                                  ).marginOnly(right: 8)
                                ],
                              ),
                            ),
                            Obx(() {
                              return Text(
                                '${getPrice(controller.pPrice.value.toString(),limit: Core.numberCountDecimal2)}\$',
                                style: TextStyle(fontSize: 14, fontFamily: FontFamily.vazirBold, color: AppColors.green),
                              );
                            }).marginSymmetric(horizontal: 16)
                          ],
                        ),
                      ),
                      CustomDivider(
                        color: AppColors.green,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                right: 16,
                                left: 16,
                                top: 8,
                                bottom: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    Assets.usdt,
                                    width: 32,
                                    height: 32,
                                  ),
                                  Text(
                                    'Calculation with Tether rate'.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 14,
                                      color: context.theme.dividerColor.withOpacity(0.8),
                                    ),
                                  ).marginOnly(right: 8)
                                ],
                              ),
                            ),
                            Text(
                              ' Irt '.tr+'${getPrice(controller.usdtPrice.value)} ',
                              style: TextStyle(fontSize: 14, fontFamily: FontFamily.vazirBold, color: context.theme.dividerColor.withOpacity(0.6)),
                            ).marginSymmetric(horizontal: 16)
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}
