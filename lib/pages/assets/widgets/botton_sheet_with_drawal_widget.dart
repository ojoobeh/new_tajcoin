import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';
import 'package:webazin/currency_text_input_formatter.dart';
import 'package:webazin/pages/assets/widgets/type_assets_widget.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../utils/core.dart';
import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../../market/widgets/decimal_textInput_formatter.dart';
import '../controllers/assets_controller.dart';
import 'assets_form_fild.dart';
import 'assets_spinner_card_list_widget.dart';
import 'assets_wallet_tag_address_widget.dart';
import 'assets_wallet_tag_address_withdrawal_widget.dart';
import 'networks_assets_widget.dart';

class BottomSheetWithdrawalWidget extends GetWidget<AssetsController> {
  final DataWallet dataAssets;

  BottomSheetWithdrawalWidget(this.dataAssets);

  @override
  Widget build(final BuildContext context) {
    controller.selectNetworksIndex.value = 0;
    return WillPopScope(
      onWillPop: () async => !controller.isDismissible.value,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
            color: Get.theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(26),
              topLeft: Radius.circular(26),
            )),
        child: SingleChildScrollView(
          child: Container(
            child: dataAssets.currency!.symbol! != 'IRT'
                ? Obx(() => Column(
                      children: <Widget>[
                        InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Get.theme.dividerColor.withOpacity(0.5),
                              size: 32,
                            )),
                        Text(
                          'Withdrawal'.tr,
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 14,
                            color: Get.theme.dividerColor,
                          ),
                        ).marginOnly(bottom: 16),
                        Divider(
                          height: 1,
                          color: Get.theme.dividerColor.withOpacity(0.3),
                          endIndent: 16,
                          indent: 16,
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                controller.tecQuantity.text = dataAssets.balanceFree.toString();
                                controller.update();
                              },
                              child: Container(
                                width: 80,
                                margin: EdgeInsets.symmetric(horizontal: 4),
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.green.withOpacity(0.9) ,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Center(
                                  child: Text(
                                    "Max".tr,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white ,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Quantity'.tr,
                              style: TextStyle(
                                fontSize: 12,
                                color: Get.theme.dividerColor.withOpacity(0.5),
                                fontFamily: FontFamily.vazirLight,
                              ),
                            ).marginOnly(top: 16, bottom: 8),
                          ],
                        ),
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
                                  decoration: BoxDecoration(color: Get.theme.dividerColor.withOpacity(0.1), borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
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
                                  child: AssetsFormFiled(
                                    controller.tecQuantity,
                                    hintText: 'Quantity'.tr,
                                    inputFormatters: [DecimalTextInputFormatter(Core.numberCountDecimal)],
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    focus: controller.focusPrice,
                                    onChanged: (value) {
                                      controller.setChangetPrice(value);
                                    },
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => controller.setCount(false),
                                child: Container(
                                  decoration: BoxDecoration(color: Get.theme.dividerColor.withOpacity(0.1), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
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
                        TypeAssetsWidget(
                          dataAssets,
                        ),
                        controller.selectTypeIndex.value != 1
                            ? NetWorksAssetsWidget(
                                dataAssets,
                              )
                            : SizedBox(),
                        Container(
                          child: AssetsWalletTagAddressWithdrawalWidget(
                            dataAssets,
                          ),
                        ),
                        InkWell(
                          onTap: () => controller.withdrawalCurrency(dataAssets),
                          child: Container(
                            height: 40,
                            margin: const EdgeInsets.only(
                              top: 16,
                            ),
                            padding: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                              color: Colors.red,
                            ),
                            child: Obx(() {
                              return Center(
                                child: !controller.isLoading()
                                    ? Text(
                                        'Submit'.tr,
                                        style: TextStyle(
                                          color: context.theme.canvasColor//todo_selectedRowColor

                                        ),
                                      )
                                    : CircularLoadingWidget(
                                        height: 30,
                                      ),
                              );
                            }),
                          ),
                        ),
                      ],
                    ))
                : Column(
                    children: <Widget>[
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Get.theme.dividerColor.withOpacity(0.5),
                        size: 32,
                      ),
                      Text(
                        'Withdrawal'.tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirLight,
                          fontSize: 14,
                          color: Get.theme.dividerColor,
                        ),
                      ).marginOnly(bottom: 16),
                      Divider(
                        height: 1,
                        color: Get.theme.dividerColor.withOpacity(0.3),
                        endIndent: 16,
                        indent: 16,
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Amount'.tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.5),
                                  fontFamily: FontFamily.vazirLight,
                                ),
                              ).marginOnly(top: 16, bottom: 8),
                            ],
                          ),
                          Container(
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
                                    child: AssetsFormFiled(
                                      controller.c1,
                                      hintText: 'Amount'.tr,
                                      focus: controller.focusPrice,
                                      inputFormatters: <TextInputFormatter>[
                                        CurrencyTextInputFormatter(
                                          locale: 'ko',
                                          decimalDigits: 0,
                                          symbol: '',
                                        ),
                                      ],
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        controller.setChangetPrice(value);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(
                                'Bank card for deposit'.tr,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.5),
                                  fontFamily: FontFamily.vazirLight,
                                ),
                              ).marginOnly(top: 16, bottom: 8),
                            ],
                          ),
                          Container(
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
                                    child: AssetsSpinnerCardListWidget(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dataAssets.currency!.symbol! != 'IRT'
                              ? NetWorksAssetsWidget(
                                  dataAssets,
                                )
                              : Container(),
                          dataAssets.currency!.symbol! != 'IRT'
                              ? Container(
                                  child: AssetsWalletTagAddressWidget(
                                    dataAssets,
                                  ),
                                )
                              : Container(),
                          InkWell(
                            onTap: () async {
                              controller.withdrawalIRT();
                            },
                            child: Container(
                              height: 40,
                              margin: const EdgeInsets.only(
                                top: 16,
                              ),
                              padding: EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                                color: AppColors.green,
                              ),
                              child: Obx(() {
                                return Center(
                                  child: !controller.isLoading()
                                      ? Text(
                                          'Submit'.tr,
                                          style: TextStyle(
                                            color: context.theme.canvasColor//todo_selectedRowColor

                                          ),
                                        )
                                      : CircularLoadingWidget(
                                          height: 30,
                                        ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
