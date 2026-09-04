import 'package:flutter/material.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../routes/app_routes.dart';
import 'package:webazin/utils/utils.dart';
import '../controllers/assets_controller.dart';

class AssetsSpinnerCardListWidget extends GetView<AssetsController> {
  @override
  Widget build(final BuildContext context) {
    return Obx(() {
      return controller.cardList.length > 0
          ? Container(
        child: DropdownButton<DataCards>(
          dropdownColor: Get.theme.scaffoldBackgroundColor,
          value: controller.selectCard.value,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 0,
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: (DataCards? value) {
            controller.selectIndexCard(value!);
          },
          items: controller.cardList.map((DataCards dataCards) {
            return DropdownMenuItem<DataCards>(
              value: dataCards,
              child: Container(
                child: Text(
                  dataCards.cardNumber!,
                  textAlign: TextAlign.start,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(color: Get.theme.dividerColor),
                ),
              ),
            );
          }).toList(),
        ),
      )
          : InkWell(
        onTap: () async {
          return Get.toNamed(Routes.BANKCARD);
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: Center(
            child: Text(
              'Bank card is not registered'.tr,
              style: TextStyle(
                fontFamily: FontFamily.vazirBold,
                color: Colors.red,
              ),
            ),
          ),
        ),
      );
    });
  }
}
