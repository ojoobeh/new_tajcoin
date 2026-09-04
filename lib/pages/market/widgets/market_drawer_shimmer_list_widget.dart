import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class MarketDrawerShimmerListWidget extends StatelessWidget {

  @override
  Widget build(final BuildContext context) {
    return Container(
      color: Get.theme.scaffoldBackgroundColor,
      child: ListView.builder(
        padding: EdgeInsets.only(bottom: 10, top: 10),
        primary: false,
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: ((_, index) {
          return Shimmer.fromColors(
            baseColor: Get.theme.cardColor,
            highlightColor: Get.theme.dividerColor.withOpacity(0.5),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.zero,
                  height: 64,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            width: 74,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 74,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.grey,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: 70,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ).marginSymmetric(horizontal: 8),
                Divider(
                  height: 1,
                  indent: 8,
                  endIndent: 8,
                  color: Colors.grey,
                )
              ],
            ),
          );
        }),
      ),
    );
  }
}


