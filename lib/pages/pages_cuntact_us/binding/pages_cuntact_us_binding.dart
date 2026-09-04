import 'package:get/get.dart';

import '../controller/pages_cuntact_us_controller.dart';


class PagesCuntactUsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PagesCuntactUsController>(
      () => PagesCuntactUsController(),
    );
   Get.put(PagesCuntactUsController);
  }
}
