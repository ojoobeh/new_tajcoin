/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controllers/home_all_order_controller.dart';

class HomeAllCurrencyShimmerListItemWidget extends GetView<HomeAllOrderController> {
  HomeAllCurrencyShimmerListItemWidget();

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.only(bottom: 10, top: 10),
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 10,
      itemBuilder: ((_, index) {

        return Shimmer.fromColors(
          baseColor: Get.theme.cardColor,
          highlightColor: Get.theme.dividerColor.withOpacity(0.5), child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.zero,
              height: 64,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        width: 32,
                        height: 32,
                      ).marginOnly(left: 8),
                      Container(
                        width: 100,
                        height: 10,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            width: 130,
                            height: 10,
                            color: Colors.grey,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 8,
                            ),
                            width: 100,
                            height: 10,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 70,
                    height: 30,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(14))),
                    child: Center(
                        child: Container(
                          width: 100,
                          height: 10,
                          color: Colors.grey,
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
        ));
      }),
    );
  }
}
