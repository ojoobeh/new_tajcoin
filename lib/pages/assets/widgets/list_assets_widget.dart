import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../utils/assets.dart';
import '../controllers/assets_controller.dart';
import 'botton_sheet_deposit_widget.dart';
import 'botton_sheet_with_drawal_widget.dart';

class ListAssetsWidget extends GetWidget<AssetsController> {
  final int limit;

  ListAssetsWidget({this.limit= 0});

  @override
  Widget build(final BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: Obx(() {
          return ListView.builder(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: controller.assets.length,
              itemBuilder: (_, index) {
                var _assets = controller.assets.elementAt(index);
                return InkWell(
                  onTap: () {
                    // DataCurrencies currencies=DataCurrencies.fromJson(controller.assets.elementAt(index).currency.toJson());
                    // if (currencies.symbol!="IRT") {
                    //   Get.find<TradeController>().selectCurrency(currencies);
                    //   Get.find<RootController>().changePage(3);
                    // }
                  },
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    _assets.currency!.iconUrl!.contains(".svg")
                                        ? SvgPicture.network(
                                            _assets.currency!.iconUrl!,
                                            width: 16,
                                          )
                                        : Image.network(
                                            _assets.currency!.iconUrl!,
                                            width: 16,
                                          ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      _assets.currency!.symbol!,
                                      style: TextStyle(
                                        fontFamily: FontFamily.vazirLight,
                                        fontSize: 14,
                                        color: Get.theme.dividerColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '(Cash)'.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 8,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 4),
                                  Text(
                                    _assets.balance?.toString() ?? '',
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 14,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 8),
                                  InkWell(
                                    onTap: () {

                                      if(_assets.currency!.symbol! != 'IRT'&& !getBool(Core.warningAssets)){
                                        controller.warningDialog(action:() {
                                          Get.bottomSheet(
                                            BottomSheetDepositWidget(
                                              _assets,
                                            ),
                                            isDismissible: !controller.isDismissible.value,
                                            enableDrag: controller.isDismissible.value,
                                          );
                                          setData(Core.warningAssets, true);
                                        }, description: 'Warning Assets'.tr,);
                                      }else{
                                        Get.bottomSheet(
                                          BottomSheetDepositWidget(
                                            _assets,
                                          ),
                                          isDismissible: !controller.isDismissible.value,
                                          enableDrag: controller.isDismissible.value,
                                        );

                                      }


                                    },
                                    child: Container(
                                      width: 90,
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.greenAccent,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Deposit".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
                                                fontSize: 13,
                                                color: Colors.black54.withOpacity(0.9),
                                              ),
                                            ),
                                            Container(
                                              child: SvgPicture.asset(
                                                Assets.arrowUp2,
                                                color: Colors.black54.withOpacity(0.4),
                                                width: 16,
                                              ),
                                            ).marginOnly(right: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).marginOnly(bottom: 4, top: 8),

                      ////////////////////////////////////////////

                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Container(
                                child: _assets.currency!.symbol != "IRT" ? Text(_assets.currency!.price!.toString() + " \$") : Text(''),
                              ),
                            ),
                            Container(
                              child: Row(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '(Price per unit)'.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 8,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 4),
                                  Text(
                                    _assets.currency!.symbol! != "IRT" ? getPrice(((double.parse(_assets.currency!.irtPrice.toString().replaceAll(",", "")) * double.parse(_assets.balance?.toString() ?? '0')).toInt()).toString()) + " IRT".tr : getPrice(_assets.balance?.toString() ?? '0'),
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 8),
                                  InkWell(
                                    onTap: () {

                                      if(_assets.currency!.symbol! != 'IRT'&& !getBool(Core.warningAssets)){
                                        controller.warningDialog(action:() {
                                          Get.bottomSheet(
                                            BottomSheetWithdrawalWidget(
                                              _assets,
                                            ),
                                            isDismissible: !controller.isDismissible.value,
                                            enableDrag: controller.isDismissible.value,
                                          );
                                          setData(Core.warningAssets, true);
                                        }, description: 'Warning Assets'.tr,);
                                      }else{
                                        Get.bottomSheet(
                                          BottomSheetWithdrawalWidget(
                                            _assets,
                                          ),
                                          isDismissible: !controller.isDismissible.value,
                                          enableDrag: controller.isDismissible.value,
                                        );

                                      }



                                    },
                                    child: Container(
                                      width: 110,
                                      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Colors.redAccent,
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              "Withdrawal".tr,
                                              style: TextStyle(
                                                fontFamily: FontFamily.vazirBold,
                                                fontSize: 12,
                                                color: Colors.black54.withOpacity(0.9),
                                              ),
                                            ),
                                            Container(
                                              child: SvgPicture.asset(
                                                Assets.arrowDown2,
                                                color: Colors.black54.withOpacity(0.4),
                                                width: 16,
                                              ),
                                            ).marginOnly(right: 4),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ).marginOnly(
                        bottom: 8,
                      ),

                      Divider(
                        height: 1,
                        indent: 8,
                        endIndent: 8,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                );
              });
        }),
      ),
    );
  }
}
