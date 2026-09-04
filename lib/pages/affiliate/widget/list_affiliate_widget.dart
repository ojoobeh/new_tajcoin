import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/pages/affiliate/controllers/affiliate_controller.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utility/global.dart';

class ListAffiliateWidget extends GetWidget<AffiliateController> {

  const ListAffiliateWidget({super.key, this.limit = 0});
  final int limit;

  @override
  Widget build(final BuildContext context) => Flexible(
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: ListView.builder(
              primary: false,
              shrinkWrap: true,
              itemCount: controller.dataAffiliate.value.orders!.length,
              itemBuilder: (final _, final int index) => Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: <Widget>[
                          Flexible(
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  right: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                  left: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                  bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                '#',
                                style: TextStyle(fontSize: 8, fontFamily: FontFamily.vazirLight),
                              )),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                  bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                controller.dataAffiliate.value.orders![index].user!.name!,
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                              )),
                            ),
                          ),
                          Flexible(
                            flex: 5,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                  bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                getPrice(controller.dataAffiliate.value.orders![index].price!),
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                              )),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                border: Border(
                                  left: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                  bottom: BorderSide(color: Get.theme.dividerColor.withOpacity(0.5), width: 0.5),
                                ),
                              ),
                              child: Center(
                                  child: Text(
                                controller.dataAffiliate.value.orders![index].createdAtFa!.toString().contains(" ")
                                    ? controller.dataAffiliate.value.orders![index].createdAtFa!.toString().split(" ")[0].replaceAll("-", "/")
                                    : controller.dataAffiliate.value.orders![index].createdAtFa!.toString().replaceAll("-", "/"),
                                style: TextStyle(fontSize: 10, fontFamily: FontFamily.vazirLight),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ))),
    );
}
