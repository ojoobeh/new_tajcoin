import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/data/extensions/widget_extension.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/assets.dart';
import '../controllers/home_controller.dart';
import '../widgets/item_status_widget.dart';

class HomeMenu extends GetView<HomeController> {
  const HomeMenu();

  @override
  Widget build(final BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8, left: 10),
      color: context.theme.scaffoldBackgroundColor,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          // crossAxisAlignment: WrapCrossAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            ItemStatusWidget(
              onTap: () {
                return Get.toNamed(Routes.ORDER);
              },
              title: "Orders".tr,
              subTitle: 'مدیریت سفارشات',
              icon: Assets.svTopic,
              size: 26,
              color: Color(0xff7149e5),
            ).expanded(),

            ItemStatusWidget(
              onTap: () {
                return Get.toNamed(Routes.BANKCARD);
              },
              title: "Bank card".tr,
              subTitle: 'افزودن و برداشت',
              icon: Assets.svHistory,
              size: 26,
              color: Color(0xff1c5b36),
            ).expanded(),

            ItemStatusWidget(
              onTap: () {
                return Get.toNamed(Routes.TicketS);
              },
              title: "Support".tr,
              subTitle: 'پشتیبانی 24 ساعته',
              icon: Assets.alarm,
              size: 26,
              color: Color(0xff425ddd),
            ).expanded(),

            Container(
              key: controller.keyButton1,

              child: ItemStatusWidget(
                onTap: () {
                  Get.toNamed(Routes.MORE);
                },
                title: "More".tr,
                subTitle: 'خدمات بیشتر',
                icon: Assets.svEmail,
                color: Color(0xfff48d1c),
              ),
            ).expanded(),



            /******* LINE 2 ************/
          ],
        ),
      ),
    );
  }


}
