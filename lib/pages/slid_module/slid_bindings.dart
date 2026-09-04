import 'package:get/get.dart';
import 'package:webazin/pages/slid_module/slid_controller.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class slidBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => slidController());
  }
}