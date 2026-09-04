import 'package:get/get.dart';

import '../controller/pages_more_controller.dart';


class PagesMoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PagesMoreController>(
      () => PagesMoreController(),
    );
   Get.put(PagesMoreController);

  }
}
