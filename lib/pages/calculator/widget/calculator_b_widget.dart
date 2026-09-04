import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get/get.dart';

import '../../market/widgets/decimal_textInput_formatter.dart';
import '../controller/calculator_controller.dart';
import 'calculator_custom_form_fild.dart';

class CalculatorBWidget extends GetView<CalculatorController> {
  const CalculatorBWidget({Key? key}) : super(key: key);

  @override
  Widget build(final BuildContext context) {
    return Container(
      height: 50,
      width: Get.width - 10,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: context.theme.dividerColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 110,
            decoration: BoxDecoration(),
            child: Center(
              child: Text('IRT'),
            ),
          ),
          Container(
            height: 50,
            width: 1,
            color: context.theme.dividerColor.withOpacity(0.2),
          ),
          InkWell(
            onTap: () => controller.setTPrice(true),
            child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.dividerColor.withOpacity(0.1), borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), topRight: Radius.circular(8))),
              width: 50,
              height: double.infinity,
              child: Icon(
                FontAwesome5.plus,
                size: 14,
              ),
            ),
          ),
          Expanded(
            child: Center(
              child: CalculatorCustomFormFiled(
                controller.teTotalPrice,
                focus: controller.focusTotal,
                inputFormatters: [DecimalTextInputFormatter(0)],
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  controller.setChangetPrice(value);
                },
              ),
            ),
          ),
          InkWell(
            onTap: () => controller.setTPrice(false),
            child: Container(
              decoration: BoxDecoration(
                  color: Get.theme.dividerColor.withOpacity(0.1), borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8))),
              width: 50,
              height: double.infinity,
              child: Icon(
                FontAwesome5.minus,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
