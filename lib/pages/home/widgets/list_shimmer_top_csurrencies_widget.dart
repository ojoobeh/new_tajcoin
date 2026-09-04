import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';


class ListShimmerTopCurrenciesWidget extends StatelessWidget {
  ListShimmerTopCurrenciesWidget(this.limit);

  int limit;

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 82,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: limit,
          itemBuilder: (_, index) {
            return Shimmer.fromColors(
                baseColor: Get.theme.cardColor,
                highlightColor: Get.theme.dividerColor.withOpacity(0.5),
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: Container(
                          width: 40,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        width: 60,
                        height: 16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: Container(
                          width: 40,
                          height: 10,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          }),
    );
  }
}
