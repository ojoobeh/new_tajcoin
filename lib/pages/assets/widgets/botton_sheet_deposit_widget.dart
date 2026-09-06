import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webazin/currency_text_input_formatter.dart';
import 'package:webazin/pages/assets/widgets/type_assets_widget.dart';
import 'package:webazin/webazin/utilities.dart';


import 'package:webazin/utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/assets_controller.dart';
import 'assets_form_fild.dart';
import 'assets_wallet_tag_address_widget.dart';
import 'networks_assets_widget.dart';

class BottomSheetDepositWidget extends GetWidget<AssetsController> {
  final DataWallet dataAssets;

  BottomSheetDepositWidget(this.dataAssets);

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
                  ? Column(
                      children: <Widget>[
                        InkWell(
                            onTap: () => Get.back(),
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Get.theme.dividerColor.withOpacity(0.5),
                              size: 32,
                            )),
                        Text(
                          'Deposit'.tr,
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
                        NetWorksAssetsWidget(
                          dataAssets,
                        ),
                        TypeAssetsWidget(
                          dataAssets,
                        ),
                        Container(
                          child: AssetsWalletTagAddressWidget(
                            dataAssets,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (controller.c1.text.length > 0) controller.depositCurrency(dataAssets);
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
                                child: controller.isLoading()
                                    ? CircularLoadingWidget(
                                        height: 30,
                                      )
                                    : Text(
                                        'Submit'.tr,
                                        style: TextStyle(
                                          color: context.theme.canvasColor//todo_selectedRowColor
                                        ),
                                      ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        Text(
                          'Deposit'.tr,
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
                                    inputFormatters: <TextInputFormatter>[
                                      CurrencyTextInputFormatter(
                                        locale: 'ko',
                                        decimalDigits: 0,
                                        symbol: '',
                                      ),
                                    ],
                                    keyboardType: TextInputType.number,
                                    focus: controller.focusPrice,
                                    onChanged: (value) {
                                      controller.setChangetPrice(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () => controller.depositIRT(),
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
                                child: controller.isLoading()
                                    ? CircularLoadingWidget(
                                        height: 30,
                                      )
                                    : Text(
                                        'Submit'.tr,
                                        style: TextStyle(
                                          color: context.theme.canvasColor//todo_selectedRowColor
                                        ),
                                      ),
                              );
                            }),
                          ),
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}
