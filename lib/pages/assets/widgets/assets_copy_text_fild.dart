import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../utils/ui.dart';

class AssetsCopyTextFiled extends StatelessWidget {
  final String? param;

  const AssetsCopyTextFiled({
    this.param,
  });

  @override
  Widget build(final BuildContext context) {
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: param??''));
        Get.showSnackbar(
          Ui.SuccessSnackBar(
            message: "Copy Successfully".tr,
          ),
        );
      },
      child: Container(
        height: 80,
        decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.dividerColor.withOpacity(0.8),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Center(child: Text(param!)),
      ),
    );
  }
}
