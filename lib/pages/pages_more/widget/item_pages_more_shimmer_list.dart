import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../controller/pages_more_controller.dart';

class ItemPagesMoreShimmerList extends GetView<PagesMoreController> {
  @override
  Widget build(final BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Get.theme.cardColor,
      highlightColor: Get.theme.dividerColor.withOpacity(0.5),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            decoration: BoxDecoration(
              color: Get.theme.dividerColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    width: double.infinity,
                    height: 30,
                    color: Colors.grey,
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
