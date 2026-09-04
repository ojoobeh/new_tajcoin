/*
 * Copyright (c) 2020 .
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/parents/custom_page_model.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/config_app.dart';
import '../../assets/views/assets_view.dart';
import '../../home/views/home_view.dart';
import '../../market/views/market_view.dart';
import '../../portfolio/views/portfolioView.dart';
import '../../trader/views/trade_view.dart';

class RootController extends GetxController {
  final currentIndex = 0.obs;
  final notificationsCount = 0.obs;
  final customPages = <CustomPage>[].obs;

  RootController() {}

  @override
  void onInit() async {
    if (Get.arguments != null && Get.arguments is int) {
      changePageInRoot(Get.arguments as int);
    } else {
      changePageInRoot(0);
    }
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    pages.add(HomeView());
    pages.add(AssetsView());
    pages.add(TradeView());
    pages.add(MarketView());
    if (ConfigApp.portfolio) {
      pages.add(PortfolioView());
    }

    super.onInit();
  }

  List pages = [];

  Widget get currentPage => pages[currentIndex.value];

  /**
   * change page in route
   * */
  void changePageInRoot(int _index) {
    currentIndex.value = _index;
    // if (currentIndex.value == 1) {
    //   Get.find<AssetsController>().getAssets();
    // }
  }

  void changePageOutRoot(int _index) {
    currentIndex.value = _index;
    debugPrint('Root Repeat>>>> 3');
    Get.offNamedUntil(Routes.ROOT, (Route route) {
      if (route.settings.name == Routes.ROOT) {
        return true;
      }
      return false;
    }, arguments: "ssss");
  }

  Future<void> changePage(int _index) async {
    debugPrint('Root Repeat>>>> 4');
    if (Get.currentRoute == Routes.ROOT) {
      changePageInRoot(_index);
    } else {
      changePageOutRoot(_index);
    }
    // await refreshPage(_index);
  }

  Future<void> refreshPage(int _index) async {
    switch (_index) {
      case 0:
        {
          // await Get.find<HomeController>().refreshHome();
          break;
        }
    }
  }
}
