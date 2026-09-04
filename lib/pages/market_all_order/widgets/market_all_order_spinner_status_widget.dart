import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/string_model.dart';

import '../controllers/market_all_order_controller.dart';

class MarketAllOrderSpinnerStatus extends GetView<MarketAllOrderController> {
  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.status.length>0
          ? Container(
        child: DropdownButton<StringModel>(
          dropdownColor: Get.theme.scaffoldBackgroundColor,
          underline: Container(),
          value: controller.selectStatus.value,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 0,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (StringModel? value) {
            controller.selectIndexStatus(value!);
          },
          items: controller.status.map((StringModel dataCards) {
            return DropdownMenuItem<StringModel>(
              value: dataCards,
              child: Container(
                child: Text(
                  dataCards.title!,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Get.theme.dividerColor),
                ),
              ),
            );
          }).toList(),
        ),
      )
          : Container(
              child: SpinKitWave(color: context.theme.highlightColor, size: 24, type: SpinKitWaveType.start),
            );
    });
  }
}
