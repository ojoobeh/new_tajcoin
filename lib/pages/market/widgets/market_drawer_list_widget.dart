import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

import 'package:webazin/utils/utils.dart';
import '../controllers/market_controller.dart';
import '../controllers/market_drawer_controller.dart';

class MarketDrawerListWidget extends GetWidget<MarketDrawerController> {
  MarketDrawerListWidget();

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        primary: false,
        shrinkWrap: true,
        controller: controller.scrollController,
        itemCount: controller.marketList.length + 1,
        itemBuilder: ((_, index) {
          debugPrint("OK");
          if (index == controller.marketList.length) {
            return Obx(() {
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Opacity(
                    opacity: controller.stateLoading.isLoading() ? 1 : 0,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            });
          } else {
            var currencies = controller.marketList.elementAt(index);
            if (currencies.symbol == "AVAX-USDT") {
              debugPrint("OK");
            }
            return Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Get.find<MarketController>().changeCurrency(currencies);
                    Get.back();
                  },
                  child: Container(
                    padding: EdgeInsets.zero,
                    height: 64,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            currencies.icon!.contains(".svg")
                                ? SvgPicture.network(
                                    currencies.icon!,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ).marginOnly(left: 8,right: 8)
                                : Image.network(
                                    currencies.icon!,
                                    width: 20,
                                    fit: BoxFit.cover,
                                  ).marginOnly(left: 8,right: 8),
                            Text(
                              currencies.symbol,
                              style: TextStyle(
                                fontFamily: FontFamily.vazirLight,
                                fontSize: 13,
                                color: Get.theme.dividerColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(left: 8),
                              child: Text(
                                '\$ ' + sDouble(currencies.price.toString(), decimal: int.parse(currencies.decimal)),
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirLight,
                                  fontSize: 12,
                                  color: Get.theme.dividerColor.withOpacity(0.6),
                                ),
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 30,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: currencies.percent == "0"
                                      ? Colors.grey
                                      : currencies.percent.contains("-")
                                          ? Colors.red
                                          : Colors.green,
                                  borderRadius: BorderRadius.all(Radius.circular(14))),
                              child: Center(
                                  child: Text(
                                currencies.percent.toString() + " %",
                                style: TextStyle(
                                  fontFamily: FontFamily.vazirBold,
                                  fontSize: 12,
                                ),
                                textDirection: TextDirection.ltr,
                              )),
                            ),
                          ],
                        )
                      ],
                    ),
                  ).marginSymmetric(horizontal: 8),
                ),
                Divider(
                  height: 1,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey,
                )
              ],
            );
          }
        }),
      ),
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     color: Get.theme.scaffoldBackgroundColor,
    //   ),
    //   margin: const EdgeInsets.only(bottom: 15),
    //   child: Obx(() {
    //     return controller.currencies.length > 0
    //         ? ListView.builder(
    //             primary: false,
    //             shrinkWrap: true,
    //             itemCount: limit == 0 ? controller.currencies.length : limit,
    //             itemBuilder: (_, index) {
    //               var _currencies = controller.currencies.elementAt(index);
    //               return InkWell(
    //                 onTap: () {
    //                   controller.selectCurrency(_currencies);
    //                   Get.back();
    //                   // Get.toNamed(Routes.CATEGORY, arguments: _category);
    //                 },
    //                 child: Column(
    //                   children: <Widget>[
    //                     Container(
    //                       height: 64,
    //                       child: Row(
    //                         crossAxisAlignment: CrossAxisAlignment.center,
    //                         mainAxisAlignment: MainAxisAlignment.center,
    //                         children: <Widget>[
    //                           Row(
    //                             children: <Widget>[
    //                               _currencies.iconUrl.contains(".svg")
    //                                   ? SvgPicture.network(
    //                                       _currencies.iconUrl,
    //                                       width: 16,
    //                                     ).marginOnly(left: 8)
    //                                   : Image.network(
    //                                       _currencies.iconUrl,
    //                                       width: 16,
    //                                     ).marginOnly(left: 8),
    //                               Text(
    //                                 _currencies.symbol,
    //                                 style: TextStyle(
    //                                   fontFamily: FontFamily.vazirLight,
    //                                   fontSize: 12,
    //                                   color: Get.theme.dividerColor,
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           Expanded(
    //                             child: Container(
    //                               margin: const EdgeInsets.only(left: 16),
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 crossAxisAlignment: CrossAxisAlignment.end,
    //                                 children: <Widget>[
    //                                   Text(
    //                                     getPrice(_currencies.irtPrice.toString()),
    //                                     style: TextStyle(
    //                                       fontFamily: FontFamily.vazirBold,
    //                                       fontSize: 12,
    //                                       color: Get.theme.dividerColor
    //                                           .withOpacity(0.9),
    //                                     ),
    //                                   ),
    //                                   Text(
    //                                     '\$ ' + _currencies.price.toString(),
    //                                     style: TextStyle(
    //                                       fontFamily: FontFamily.vazirLight,
    //                                       fontSize: 10,
    //                                       color: Get.theme.dividerColor
    //                                           .withOpacity(0.6),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                           Container(
    //                             width: 65,
    //                             height: 24,
    //                             padding: EdgeInsets.symmetric(
    //                                 horizontal: 8, vertical: 4),
    //                             decoration: BoxDecoration(
    //                                 color: _currencies.percent == "0"
    //                                     ? Colors.grey
    //                                     : _currencies.percent.contains("-")
    //                                         ? Colors.red
    //                                         : Colors.green,
    //                                 borderRadius:
    //                                     BorderRadius.all(Radius.circular(14))),
    //                             child: Center(
    //                                 child: Text(
    //                               _currencies.percent.toString() + " %",
    //                               style: TextStyle(
    //                                   fontFamily: FontFamily.vazirLight,
    //                                   fontSize: 10),
    //                               textDirection: TextDirection.ltr,
    //                             )),
    //                           )
    //                         ],
    //                       ),
    //                     ).marginSymmetric(horizontal: 16),
    //                     Divider(
    //                       height: 1,
    //                       indent: 8,
    //                       endIndent: 8,
    //                       color: Colors.grey,
    //                     )
    //                   ],
    //                 ),
    //               );
    //             })
    //         : Container();
    //     ;
    //   }),
    // );
  }
}
