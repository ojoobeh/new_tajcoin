

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../../../../webazin/data/dto/order.dart';
import '../controllers/bankCardController.dart';

class BankCardSpinnerOrderListWidget extends GetView<BankCardController> {
  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.orderList != null && controller.orderList.length > 0
          ? Container(
              child: DropdownButton<DataOrder>(
                dropdownColor: Get.theme.scaffoldBackgroundColor,
                value: controller.selectOrder.value,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 0,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                onChanged: (DataOrder? value) {
                  controller.selectIndexOrder(value!);
                },
                items: controller.orderList.map((DataOrder vahed) {
                  return DropdownMenuItem<DataOrder>(
                    value: vahed,
                    child: Container(
                      child: Text(
                        'Order id '.tr.replaceAll('id', vahed.id.toString()),
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                            color: Colors.black54),
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          :  Container(
        width: 200,
        padding: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Get.theme.dividerColor.withOpacity(0.7)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SpinKitWave(color: Get.theme.dividerColor, size: 24, type: SpinKitWaveType.start),
        ),
      );
    });
  }
}
