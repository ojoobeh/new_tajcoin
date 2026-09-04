import 'package:get/get.dart';

import '../controllers/order_controller.dart';


class OrderCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderController>(
      () => OrderController(),
    );

  }
}
