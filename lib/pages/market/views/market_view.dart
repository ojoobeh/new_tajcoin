
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../root/controllers/root_controller.dart';
import '../controllers/market_controller.dart';
import 'market_drawer_widget.dart';
import 'market_limit_view.dart';
import 'market_pro_view.dart';

class MarketView extends GetView<MarketController> {
  @override
  Widget build(final BuildContext context) {
    controller.connectToServer();
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async{
          Get.find<RootController>().changePage(0);
          return false;
        },
        child: Scaffold(
          key: controller.scaffoldKey,
          backgroundColor: Get.theme.scaffoldBackgroundColor,
          drawer: MarketDrawerWidget(),
          body: RefreshIndicator(
            onRefresh: () async {
              controller.refreshHome(showMessage: true);
            },
            child: Obx(() {
              return controller.isLimit.value
                  ? MarketLimitView()
                  : MarketProView();
            }),
          ),
        ),
      ),
    );
  }
}
