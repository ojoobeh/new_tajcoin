import 'package:get/get.dart';

import '../controller/pages_controller.dart';


class PagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PagesController>(
      () => PagesController(),
    );
   Get.put(PagesController);
  }
}
