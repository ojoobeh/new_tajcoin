import 'package:flutter/material.dart';
import 'package:webazin/generated/assets.dart';
import 'package:webazin/pages/settings/controllers/settings_controller.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';
import 'package:webazin/widgets/image.dart';

class BottomSheetSelectLanguageWidget extends GetWidget<SettingsController> {
  BottomSheetSelectLanguageWidget();

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(26),
            topLeft: Radius.circular(26),
          )),
      child: SingleChildScrollView(
        child: Container(
            child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap: () {
                    updateLocale(Locale('fa'));
                    setData('language', 'fa');
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Persian'.tr,
                        style: context.textTheme.headlineLarge,
                      ),
                      image(Assets.iconIrFlag, width: 36),
                    ],
                  )),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: InkWell(
                  onTap:() {
                    updateLocale(Locale('en'));
                    setData('language', 'en');
                    Get.back();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'English'.tr,
                        style: context.textTheme.headlineLarge,
                      ),
                      image(Assets.iconEnFlag, width: 36),
                    ],
                  )),
            ),
          ],
        )),
      ),
    );
  }
}
