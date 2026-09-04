import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../utils/assets.dart';
import 'package:webazin/utils/utils.dart';

class BankCardItemShimmerListTicket extends StatelessWidget {


  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Assets.card02),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(8),
        boxShadow: <BoxShadow>[
          BoxShadow(color: Get.theme.dividerColor.withOpacity(0.5), blurRadius: 10, offset: Offset(0, 8)),
        ],
      ),
      child: Shimmer.fromColors(
        baseColor: Get.theme.cardColor,
        highlightColor: Get.theme.dividerColor.withOpacity(0.5),
        child: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                    decoration: BoxDecoration(
                      color:  Colors.red.shade800,
                      borderRadius: BorderRadius.circular(32),
                    ),
                    child: Center(
                      child: Text("ddddddd",
                          style: TextStyle(
                            fontFamily: FontFamily.vazirLight,
                            fontSize: 12,
                          )),
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 100,
                        height: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Container(
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                       Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                       Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),
                       Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 60,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.grey,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 100,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Container(
                    width: 200,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
