import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import '../../../webazin/utilities.dart';
import '../../global_widgets/custom_expansion_tiles.dart';
import '../controllers/assets_controller.dart';
import '../widgets/assets_wd_button.dart';
import '../widgets/botton_sheet_deposit_widget.dart';
import '../widgets/botton_sheet_with_drawal_widget.dart';

class AssetsListItemWidget extends GetWidget<AssetsController> {
  AssetsListItemWidget(this.index);

  int index;

  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      var _assets = controller.assets.elementAt(index);
      return Container(
        key: index == 1 ? controller.keyButton1 : null,
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.black87.withOpacity(0.1), blurRadius: 20, offset: Offset(0, 8)),
          ],
        ),
        child: CustomExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: Container(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            AssetsWdButton(
                              iconData: Assets.arrowUp2,
                              title: "Deposit".tr,
                              color: Colors.greenAccent,
                              onTap: () {
                                controller.tTXID.value.text = '';

                                if (_assets.currency!.symbol == "IRT" || _assets.currency!.networks!.length > 0) {


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



                                } else {
                                  snackbarRed(title: 'Error'.tr, subtitle: 'Network is down, contact support'.tr);
                                }
                              },
                            ),
                             AssetsWdButton(
                              iconData: Assets.arrowDown2,
                              title: "Withdrawal".tr,
                              color: Colors.redAccent,
                              onTap: () {
                                if (_assets.currency!.symbol == "IRT" || _assets.currency!.networks!.length > 0) {
                                  controller.tTXID.value.text = '';
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


                                } else {
                                  snackbarRed(title: 'Error'.tr, subtitle: 'Network is down, contact support'.tr);
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _assets.currency!.symbol!,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirBold,
                                fontSize: 14,
                                color: Get.theme.dividerColor,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            _assets.currency!.iconUrl!.contains(".svg")
                                ? SvgPicture.network(
                                    _assets.currency!.iconUrl!,
                                    width: 22,
                                  )
                                : Image.network(
                                    _assets.currency!.iconUrl!,
                                    width: 22,
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _assets.currency!.symbol == "IRT"
                    ? Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                left: 16,
                                right: 16,
                                top: 32,
                                bottom: 16,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Property value: '.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 4),
                                  Text(
                                    getPrice(_assets.balance!.toString()) + "  " + " IRT".tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 80,
                        child: Column(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.keyboard_arrow_down_rounded).marginOnly(left: 4),
                                        Obx(() => controller.isChange.value
                                            ? Text(
                                                _assets.balance?.toString() ?? '',
                                                style: TextStyle(
                                                  fontFamily: FontFamily.vazirBold,
                                                  fontSize: 12,
                                                  color: Get.theme.dividerColor.withOpacity(0.9),
                                                ),
                                              )
                                            : Container())
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Property value: '.tr,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ).marginOnly(left: 4),
                                  Obx(() => controller.isChange.value
                                      ? Text(
                                          getPrice(((double.parse(_assets.currency!.irtPrice.toString().replaceAll(",", "")) *
                                                          double.parse(
                                                            _assets.balance?.toString() ?? '0',
                                                          ))
                                                      .toInt())
                                                  .toString()) +
                                              "  " +
                                              " IRT".tr,
                                          style: TextStyle(
                                            fontFamily: FontFamily.vazirBold,
                                            fontSize: 12,
                                            color: Get.theme.dividerColor.withOpacity(0.9),
                                          ),
                                        )
                                      : Container()),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          children: <Widget>[
            (_assets.currency!.symbol != "IRT")
                ? Container(
                    child: Column(
                      children: <Widget>[
                        Divider(
                          height: 1,
                          indent: 8,
                          endIndent: 8,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Currency value: '.tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.9),
                                ),
                              ).marginOnly(left: 4),
                              Container(
                                child: Container(
                                  child: Text(
                                    double.parse((_assets.currency!.price!).toString()).toStringAsFixed(int.parse(_assets.currency!.decimal!)) + " \$",
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirBold,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor.withOpacity(0.9),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Available stock: '.tr,
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.9),
                                ),
                              ),
                              Text(
                                _assets.balanceFree?.toString() ?? '0',
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.9),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container()
          ],
        ),
      );

      // return Container(
      //   margin: const EdgeInsets.all(8),
      //   decoration: BoxDecoration(
      //     color: Get.theme.scaffoldBackgroundColor,
      //
      //     borderRadius: BorderRadius.circular(8),
      //     boxShadow: <BoxShadow>[
      //       BoxShadow(color: Colors.black87.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
      //     ],
      //   ),
      //   child: CustomExpansionTile(
      //
      //     tilePadding: EdgeInsets.zero,
      //     title: Container(
      //       child: Column(
      //         children: <Widget>[
      //           Container(
      //             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Container(
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: <Widget>[
      //                       _assets.currency!.iconUrl!.contains(".svg")
      //                           ? SvgPicture.network(
      //                         _assets.currency!.iconUrl!,
      //                         width: 16,
      //                       )
      //                           : Image.network(
      //                         _assets.currency!.iconUrl!,
      //                         width: 16,
      //                       ),
      //                       SizedBox(
      //                         width: 8,
      //                       ),
      //                       Text(
      //                         _assets.currency!.symbol!,
      //                         style: TextStyle(
      //                           fontFamily: FontFamily.vazirLight,
      //                           fontSize: 14,
      //                           color: Get.theme.dividerColor,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Container(
      //                   child: Row(
      //                     children: <Widget>[
      //                       InkWell(
      //                         onTap: () {
      //                           Get.bottomSheet(
      //                             BottomSheetDepositWidget(
      //                               _assets,
      //                             ),
      //                             isDismissible: !controller.isDismissible.value,
      //                             enableDrag: controller.isDismissible.value,
      //                           );
      //                         },
      //                         child: Container(
      //                           width: 90,
      //                           margin: const EdgeInsets.symmetric(horizontal: 8),
      //                           padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(4),
      //                             color: AppColors.greenAccent,
      //                           ),
      //                           child: Center(
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                               children: <Widget>[
      //                                 Text(
      //                                   "Deposit".tr,
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 13,
      //                                     color: Colors.black54.withOpacity(0.9),
      //                                   ),
      //                                 ),
      //                                 Container(
      //                                   child: SvgPicture.asset(
      //                                     Assets.arrowUp2,
      //                                     color: Colors.black54.withOpacity(0.4),
      //                                     width: 16,
      //                                   ),
      //                                 ).marginOnly(right: 4),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                       InkWell(
      //                         onTap: () {
      //                           Get.bottomSheet(
      //                             BottomSheetWithdrawalWidget(
      //                               _assets,
      //                             ),
      //                             isDismissible: !controller.isDismissible.value,
      //                             enableDrag: controller.isDismissible.value,
      //                           );
      //                         },
      //                         child: Container(
      //                           width: 90,
      //                           padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      //                           decoration: BoxDecoration(
      //                             borderRadius: BorderRadius.circular(4),
      //                             color: Colors.redAccent,
      //                           ),
      //                           child: Center(
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                               children: <Widget>[
      //                                 Text(
      //                                   "Withdrawal".tr,
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 13,
      //                                     color: Colors.black54.withOpacity(0.9),
      //                                   ),
      //                                 ),
      //                                 Container(
      //                                   child: SvgPicture.asset(
      //                                     Assets.arrowDown2,
      //                                     color: Colors.black54.withOpacity(0.4),
      //                                     width: 16,
      //                                   ),
      //                                 ).marginOnly(right: 4),
      //                               ],
      //                             ),
      //                           ),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 )
      //               ],
      //             ),
      //           ),
      //           _assets.currency!.symbol == "IRT"
      //               ? Container(
      //             height: 50,
      //             child: Center(
      //               child: Container(
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: <Widget>[
      //                     Text(
      //                       style: TextStyle(
      //                         fontFamily: FontFamily.vazirBold,
      //                         fontSize: 14,
      //                         color: Get.theme.dividerColor.withOpacity(0.9),
      //                       ),
      //                     ).marginOnly(left: 4),
      //                     Container(
      //                       child: Container(
      //                         // child: _assets.currency!.symbol != "IRT" ? Text(_assets.currency!.price! + " \$") : Text(_assets.balance!),
      //                         child: Text(
      //                           controller.assets[index].balance!,
      //                           style: TextStyle(
      //                             fontFamily: FontFamily.vazirBold,
      //                             fontSize: 14,
      //                             color: Get.theme.dividerColor.withOpacity(0.9),
      //                           ),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               ),
      //             ),
      //           )
      //               : Container(
      //             height: 80,
      //             child: Column(
      //               children: <Widget>[
      //                 Container(
      //                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       Container(
      //                         child: Row(
      //                           children: <Widget>[
      //                             Text(
      //                               style: TextStyle(
      //                                 fontFamily: FontFamily.vazirBold,
      //                                 fontSize: 12,
      //                                 color: Get.theme.dividerColor.withOpacity(0.9),
      //                               ),
      //                             ).marginOnly(left: 4),
      //                             Container(
      //                               child: Container(
      //                                 child: _assets.currency!.symbol != "IRT"
      //                                     ? Text(
      //                                   _assets.currency!.price! + " \$",
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 12,
      //                                     color: Get.theme.dividerColor.withOpacity(0.9),
      //                                   ),
      //                                 )
      //                                     : Text(
      //                                   _assets.balance!,
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 14,
      //                                     color: Get.theme.dividerColor.withOpacity(0.9),
      //                                   ),
      //                                 ),
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //                       Container(
      //                         child: Row(
      //                           children: <Widget>[
      //                             Text(
      //                               style: TextStyle(
      //                                 fontFamily: FontFamily.vazirBold,
      //                                 fontSize: 12,
      //                                 color: Get.theme.dividerColor.withOpacity(0.9),
      //                               ),
      //                             ).marginOnly(left: 4),
      //                             Text(
      //                               _assets.currency!.symbol! != "IRT"
      //                                   ? getPrice(
      //                                   ((double.parse(_assets.currency!.irtPrice.toString().replaceAll(",", "")) * double.parse(_assets.balance!)).toInt())
      //                                       .toString()) +
      //                                   " IRT".tr
      //                                   : getPrice(_assets.balance!),
      //                               style: TextStyle(
      //                                 fontFamily: FontFamily.vazirBold,
      //                                 fontSize: 12,
      //                                 color: Get.theme.dividerColor.withOpacity(0.9),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //                 Container(
      //                   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[
      //                       Container(
      //                         child: Row(
      //                           children: <Widget>[
      //                             Text(
      //                               style: TextStyle(
      //                                 fontFamily: FontFamily.vazirBold,
      //                                 fontSize: 12,
      //                                 color: Get.theme.dividerColor.withOpacity(0.9),
      //                               ),
      //                             ).marginOnly(left: 4),
      //                             Container(
      //                               child: Container(
      //                                 // child: _assets.currency!.symbol != "IRT" ? Text(_assets.currency!.price! + " \$") : Text(_assets.balance!),
      //                                 child: Text(
      //                                   controller.assets[index].balance!,
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 12,
      //                                     color: Get.theme.dividerColor.withOpacity(0.9),
      //                                   ),
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                       Container(
      //                         child: Row(
      //                           children: <Widget>[
      //                             Text(
      //                               style: TextStyle(
      //                                 fontFamily: FontFamily.vazirBold,
      //                                 fontSize: 12,
      //                                 color: Get.theme.dividerColor.withOpacity(0.9),
      //                               ),
      //                             ).marginOnly(left: 4),
      //                             Container(
      //                               child: Container(
      //                                 child: Text(
      //                                   _assets.balanceFree!,
      //                                   style: TextStyle(
      //                                     fontFamily: FontFamily.vazirBold,
      //                                     fontSize: 12,
      //                                     color: Get.theme.dividerColor.withOpacity(0.9),
      //                                   ),
      //                                 ),
      //                               ),
      //                             )
      //                           ],
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 16),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Container(
      //                   child: Row(
      //                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ).marginOnly(bottom: 4, top: 8),
      //
      //           ////////////////////////////////////////////
      //
      //           Container(
      //             padding: EdgeInsets.symmetric(horizontal: 16),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: <Widget>[
      //                 Container(
      //                   child: Row(
      //                     // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: <Widget>[],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ).marginOnly(
      //             bottom: 8,
      //           ),
      //
      //           Divider(
      //             height: 1,
      //             indent: 8,
      //             endIndent: 8,
      //             color: Colors.grey,
      //           ),
      //         ],
      //       ),
      //     ),
      //     children: <Widget>[
      //       Container(
      //         width: 100,
      //         height: 50,
      //         color: Colors.red,
      //       )
      //     ],
      //   ),
      // );
    });
  }
}
