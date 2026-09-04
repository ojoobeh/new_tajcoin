/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/trade_drawer_controller.dart';
import 'list_csurrencies_trader_widget.dart';
import 'trade_custom_text_field_widget.dart';

class TradeDrawerWidget extends GetWidget<TradeDrawerController> {
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
                          onTap: () => controller.refreshHome(action: () => controller.update()),
                          child: Container(
                            margin: const EdgeInsets.only(right: 8,left: 8),
                            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                            decoration: BoxDecoration(
                              color: Get.theme.dividerColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.green, width: 1),
                            ),
                            child: Text(
                              'Search'.tr,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 12,
                                color: AppColors.green,
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
            Expanded(
              child: Container(
                color: Colors.red,
                child: ListCurrenciesTraderWidget(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
