import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/utils.dart';
import '../../global_widgets/circular_loading_widget.dart';
import '../controllers/trade_drawer_controller.dart';

class ListCurrenciesTraderWidget extends GetWidget<TradeDrawerController> {
   int? limit=0;

  ListCurrenciesTraderWidget({this.limit});

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: Obx(() {
        if (controller.currencies.isEmpty) {
          return controller.isDone.value
              ? Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Nothing found".tr,
                        style: TextStyle(
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 14,
                        ),
                      ).marginOnly(bottom: 16),
                      InkWell(
                        onTap: () => controller.refreshHome(action: () => controller.update()),
                        child: Icon(
                          Icons.refresh,
                          size: 32,
                        ),
                      )
                    ],
                  )),
                )
              : CircularLoadingWidget(
                  height: 300,
                );
        } else {
          return Container(
            color: Get.theme.scaffoldBackgroundColor,
            child: ListView.builder(
              padding: EdgeInsets.only(bottom: 10, top: 10),
              primary: false,
              shrinkWrap: true,
              controller: controller.scrollController,
              itemCount: controller.currencies.length + 1,
              itemBuilder: ((_, index) {
                if (index == controller.currencies.length) {
                  return Obx(() {
                    return controller.isLoading.value
                        ? Container(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Opacity(
                                opacity: controller.isLoading.value ? 1 : 0,
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          )
                        : Container();
                  });
                } else {
                  var _currencies = controller.currencies.elementAt(index);
                  return InkWell(
                    onTap: () {
                      controller.selectCurrency(_currencies);
                      Get.back();
                      // Get.toNamed(Routes.CATEGORY, arguments: _category);
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 64,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  _currencies.iconUrl!.contains(".svg")
                                      ? SvgPicture.network(
                                          _currencies.iconUrl!,
                                          width: 16,
                                        ).marginOnly(left: 8,right: 8)
                                      : Image.network(
                                          _currencies.iconUrl!,
                                          width: 16,
                                        ).marginOnly(left: 8,right: 8),
                                  Text(
                                    _currencies.symbol!,
                                    style: TextStyle(
                                      fontFamily: FontFamily.vazirLight,
                                      fontSize: 12,
                                      color: Get.theme.dividerColor,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 16,right: 8),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        getPrice(_currencies.irtPrice.toString()),
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirBold,
                                          fontSize: 12,
                                          color: Get.theme.dividerColor.withOpacity(0.9),
                                        ),
                                      ),
                                      Text(
                                        '\$ ' + _currencies.price.toString(),
                                        style: TextStyle(
                                          fontFamily: FontFamily.vazirLight,
                                          fontSize: 10,
                                          color: Get.theme.dividerColor.withOpacity(0.6),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 65,
                                height: 24,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                decoration: BoxDecoration(
                                    color: _currencies.percent == "0"
                                        ? Colors.grey
                                        : _currencies.percent.length > 1 && _currencies.percent.contains("-")
                                            ? Colors.red
                                            : AppColors.green,
                                    borderRadius: BorderRadius.all(Radius.circular(14))),
                                child: Center(
                                    child: Text(
                                  _currencies.percent.toString() + " %",
                                  style: TextStyle(fontFamily: FontFamily.vazirBold, fontSize: 12),
                                  textDirection: TextDirection.ltr,
                                )),
                              )
                            ],
                          ),
                        ).marginSymmetric(horizontal: 16),
                        Divider(
                          height: 1,
                          indent: 8,
                          endIndent: 8,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  );
                }
              }),
            ),
          );
        }
      }),
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
    //                                         : AppColors.green,
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
