import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/socket/socket_list_up_down.dart';

import '../controllers/market_controller.dart';

class ListMarketOrderBook extends StatelessWidget {
  ListMarketOrderBook(
    this.list,
    this.color, {
    this.limit = 0,
    this.reverse= false,
  });

  List<SocketListUpDown> list;
  MarketController controller = Get.find<MarketController>();
  int limit;

  Color color;
  bool reverse;

  @override
  Widget build(final BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      reverse: reverse,
      itemBuilder: (context, index) => Container(
        height: (200 / 8),
        child: Container(
          child: Stack(
            children: <Widget>[
              Container(
                width: (Get.width / 2 - 80) / 100 * (double.parse(list[index].volume!)),
                height: double.infinity,
                child: Container(
                  color: color.withOpacity(0.2),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: () => controller.changeTPrice2(list[index].price!),
                      child: Text(
                        list[index].price!,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      double.parse(list[index].percentage!).toStringAsFixed(2),
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 8,
                        color: Get.theme.dividerColor.withOpacity(0.6),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
