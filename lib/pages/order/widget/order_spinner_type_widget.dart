import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/string_model.dart';

import '../controllers/order_controller.dart';

class OrderSpinnerType extends GetView<OrderController> {
  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.type.length > 0
          ? Container(
              child: DropdownButton<StringModel>(
                dropdownColor: Get.theme.scaffoldBackgroundColor,
                value: controller.selectType.value,
                underline: Container(),
                icon: const Icon(Icons.arrow_downward),
                iconSize: 0,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (StringModel? value) {
                  controller.selectIndexType(value!);
                },
                items: controller.type.map((StringModel dataCards) {
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
              child: SpinKitWave(color: context.theme.canvasColor//todo_selectedRowColor
                , size: 24, type: SpinKitWaveType.start),
            );
    });
  }
}
