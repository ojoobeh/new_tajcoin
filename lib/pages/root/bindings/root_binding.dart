import 'package:get/get.dart';

import '../../assets/controllers/assets_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../market/controllers/market_controller.dart';
import '../../market/controllers/market_drawer_controller.dart';
import '../../portfolio/controllers/portfolioController.dart';
import '../../trader/controllers/trade_controller.dart';
import '../../trader/controllers/trade_drawer_controller.dart';
import '../controllers/root_controller.dart';

class RootBinding extends Bindings {
  @override
  void dependencies() async {
    Get.lazyPut<RootController>(
      () => RootController(),
    );
    await Get.put(HomeController(), permanent: false);
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.put(TradeController(), permanent: true);
    Get.lazyPut<TradeController>(
      () => TradeController(),
    );
    Get.put(MarketController(), permanent: true);
    Get.lazyPut<MarketController>(
      () => MarketController(),
    );
    Get.put(PortfolioController(), permanent: true);
    Get.lazyPut<PortfolioController>(
      () => PortfolioController(),
    );

    Get.put(AuthController(), permanent: true);
    Get.lazyPut<AuthController>(
      () => AuthController(),
    );
    Get.put(TradeDrawerController(), permanent: true);
    Get.lazyPut<TradeDrawerController>(
      () => TradeDrawerController(),
    );
    Get.put(MarketDrawerController(), permanent: true);
    Get.lazyPut<MarketDrawerController>(
      () => MarketDrawerController(),
    );

    Get.put(AssetsController());
    Get.lazyPut<AssetsController>(
      () => AssetsController(),
    );

  }
}
