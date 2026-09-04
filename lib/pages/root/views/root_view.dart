import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/assets.dart';
import '../../../utils/config_app.dart';
import '../../global_widgets/custom_bottom_nav_bar.dart';
import '../controllers/root_controller.dart';

class RootView extends GetView<RootController> {
  @override
  Widget build(final BuildContext context) {
    List<CustomBottomNavigationItem> list = [];

    list.add(CustomBottomNavigationItem(icon: Assets.home, label: "Home".tr));
    list.add(CustomBottomNavigationItem(icon: Assets.wallet, label: "Wallet".tr));
    list.add(CustomBottomNavigationItem(icon: Assets.trade, label: "Trade".tr));
    list.add(CustomBottomNavigationItem(icon: Assets.tradePro, label: "Market".tr));
    if (ConfigApp.portfolio) {
      list.add(CustomBottomNavigationItem(icon: Assets.profit_chart, label: "Instant inventory".tr));
    }

    return Obx(() {
      return Scaffold(
        body: controller.currentPage,
        // body: controller.currentPage,
        bottomNavigationBar: CustomBottomNavigationBar(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          itemColor: context.theme.colorScheme.secondary,
          currentIndex: controller.currentIndex.value,
          onChange: (index) {
            controller.changePage(index);
          },
          children: list,
        ),
      );
    });
  }
}
