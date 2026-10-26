import 'package:get/get.dart';
import 'package:webazin/pages/cart_2_cart/controller/cart_2_cart_controller.dart';



class Cart2CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Cart2CartController>(
      () => Cart2CartController(),
    );
   Get.put(Cart2CartController);

  }
}
