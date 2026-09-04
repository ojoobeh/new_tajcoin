import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/generated/assets.dart';

import 'package:webazin/utils/utils.dart';
import 'package:webazin/widgets/image.dart';
import '../controller/pages_cuntact_us_controller.dart';

class PagesCuntactUsView extends GetView<PagesCuntactUsController> {
  Widget _item(String iconData, String link) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: image(
        iconData,
        width: double.infinity,
        height: 54,
        onTap: () {
          launch(link);
        },
      ),
    );
  }

  @override
  Widget build(final BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          controller.title.value.tr,
          style: TextStyle(
            fontFamily: FontFamily.vazirLight,
            color: Get.theme.dividerColor.withOpacity(0.8),
            fontSize: 14,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Get.theme.hintColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
      ),
      body: Obx(() {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: controller.callPage.value != null && controller.callPage.value.data != null && controller.callPage.value.data != '' && controller.callPage.value.data != 'null'
              ? Container(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 100,
                        padding: EdgeInsets.all(8),
                        child: Container(),
                      ),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 80,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _item(Assets.iconWhatsapp, 'https://chat.whatsapp.com/DU82lYXAcsJLZkpQmc42nE'),
                                _item(Assets.iconTelegram, 'https://t.me/ir_tajcoin'),
                                _item(Assets.iconIta, 'https://eitaa.com/taj_coin'),
                                _item(Assets.iconRobika, 'https://rubika.ir/tajcoin_ex'),
                                _item(Assets.iconSms, 'sms://09105956681'),
                                _item(Assets.iconPhone1, 'tel://+989198729736'),
                                _item(Assets.iconPhone2, 'tel://+8632235391'),
                                _item(Assets.iconInstagram, 'https://www.instagram.com/ir_tajcoin'),
                                _item(Assets.iconGmail, 'mailto:EX.tajcoin@gmail.com'),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
        );
      }),
    );
  }
}
