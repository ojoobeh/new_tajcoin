import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/assets_controller.dart';

class ListShimmerAssetsWidget extends GetWidget<AssetsController> {
  final int limit=0;


  ListShimmerAssetsWidget();

  @override
  Widget build(final BuildContext context) {
    return Flexible(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ListView.builder(
            primary: false,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (_, index) {
              return Shimmer.fromColors(
                baseColor: Get.theme.cardColor,
                highlightColor: Get.theme.dividerColor.withOpacity(0.5),
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
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Container(
                                    width: 54,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      color: Colors.grey,
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

                                Container(
                                  width: 54,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.grey,
                                  ),
                                ).marginOnly(left: 8),
                                Container(
                                  width: 90,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.grey,
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
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                  Container(
                                    width: 88,
                                    height: 24,
                                    color: Colors.grey,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 84,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(2),
                                    color: Colors.grey,
                                  ),
                                ).marginOnly(left: 4),

                                Container(
                                  width: 90,
                                  height: 24,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ).marginOnly(bottom: 4, top: 8),
                    // Container(
                    //   padding: EdgeInsets.symmetric(horizontal: 16),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: <Widget>[
                    //       Container(
                    //         child: Container(
                    //           child: _assets.currency!.symbol != "IRT" ? Text(_assets.currency!.price! + " \$") : Text(''),
                    //         ),
                    //       ),
                    //       Container(
                    //         child: Row(
                    //           // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //           children: <Widget>[
                    //             Text(
                    //               '(Price per unit)'.tr,
                    //               style: TextStyle(
                    //                 fontFamily: FontFamily.vazirBold,
                    //                 fontSize: 8,
                    //                 color: Get.theme.dividerColor.withOpacity(0.9),
                    //               ),
                    //             ).marginOnly(left: 4),
                    //             Text(
                    //               _assets.currency!.symbol! != "IRT"
                    //                   ? getPrice(((double.parse(_assets.currency!.irtPrice.toString().replaceAll(",", "")) * double.parse(_assets.balance!)).toInt())
                    //                           .toString()) +
                    //                       " IRT".tr
                    //                   : getPrice(_assets.balance!),
                    //               style: TextStyle(
                    //                 fontFamily: FontFamily.vazirBold,
                    //                 fontSize: 12,
                    //                 color: Get.theme.dividerColor.withOpacity(0.9),
                    //               ),
                    //             ).marginOnly(left: 8),
                    //             InkWell(
                    //               onTap: () {
                    //                 Get.bottomSheet(
                    //                   BottomSheetWithdrawalWidget(
                    //                     _assets,
                    //                   ),
                    //                   isDismissible: !controller.isDismissible.value,
                    //                   enableDrag: controller.isDismissible.value,
                    //                 );
                    //               },
                    //               child: Container(
                    //                 width: 90,
                    //                 padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    //                 decoration: BoxDecoration(
                    //                   borderRadius: BorderRadius.circular(4),
                    //                   color: Colors.redAccent,
                    //                 ),
                    //                 child: Center(
                    //                   child: Row(
                    //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //                     children: <Widget>[
                    //                       Text(
                    //                         "Withdrawal".tr,
                    //                         style: TextStyle(
                    //                           fontFamily: FontFamily.vazirBold,
                    //                           fontSize: 13,
                    //                           color: Colors.black54.withOpacity(0.9),
                    //                         ),
                    //                       ),
                    //                       Container(
                    //                         child: SvgPicture.asset(
                    //                           Assets.arrowDown2,
                    //                           color: Colors.black54.withOpacity(0.4),
                    //                           width: 16,
                    //                         ),
                    //                       ).marginOnly(right: 4),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ).marginOnly(
                    //   bottom: 8,
                    // ),

                    Divider(
                      height: 1,
                      indent: 8,
                      endIndent: 8,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
