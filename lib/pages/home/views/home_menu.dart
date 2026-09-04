import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              width: (Get.width / 4) - 5,
              child: ItemStatusWidget(
                onTap: () {
                  return Get.toNamed(Routes.ORDER);
                },
                title: "Orders".tr,
                icon: Assets.orders,
                size: 26,
              ),
            ),

                        Container(
              width: (Get.width / 4) - 5,
              child: ItemStatusWidget(
                onTap: () {
                  return Get.toNamed(Routes.BANKCARD);
                },
                title: "Bank card".tr,
                icon: Assets.bankCards,
                size: 26,
              ),
            ),

                                    Container(
              width: (Get.width / 4) - 5,
              child: ItemStatusWidget(
                onTap: () {
                  return Get.toNamed(Routes.TicketS);
                },
                title: "Support".tr,
                icon: Assets.support,
                size: 26,
              ),
            ),


            Container(
              key: controller.keyButton1,
              width: (Get.width / 4) - 5,
              child: ItemStatusWidget(
                onTap: () {
                  Get.toNamed(Routes.MORE);
                },
                title: "More".tr,
                icon: Assets.more,
                size: 22,
              ),
            ),

            /******* LINE 2 ************/
          ],
        ),
      ),
    );
  }
}
