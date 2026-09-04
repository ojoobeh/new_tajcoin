import 'package:get/get.dart';

import '../controller/default_controller.dart';


class DefaultBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DefaultController>(
      () => DefaultController(),
    );
   Get.put(DefaultController);

  }
}
