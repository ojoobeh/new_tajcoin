import 'package:get/get.dart';

import '../controllers/home_all_order_controller.dart';


class HomeAllOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeAllOrderController>(
      () => HomeAllOrderController(),
    );
   Get.put(HomeAllOrderController);
  }
}
