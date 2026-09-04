import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class ListShimmerMarketOrderBook extends StatelessWidget {
  ListShimmerMarketOrderBook(this.limit,);

  int limit;

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      itemCount: limit,
      itemBuilder: (context, index) => Shimmer.fromColors(
        baseColor: Get.theme.cardColor,
        highlightColor: Get.theme.dividerColor.withOpacity(0.5),
        child: Container(
          height: (200 / 8),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 80,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
