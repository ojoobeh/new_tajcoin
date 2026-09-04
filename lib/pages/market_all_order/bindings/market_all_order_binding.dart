import 'package:get/get.dart';

import '../controllers/market_all_order_controller.dart';


class MarketAllOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MarketAllOrderController>(
      () => MarketAllOrderController(),
    );
   Get.put(MarketAllOrderController);
  }
}
