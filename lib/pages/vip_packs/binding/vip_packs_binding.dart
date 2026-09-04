import 'package:get/get.dart';

import '../controller/vip_packs_controller.dart';


class VipPacksBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VipPacksController>(
      () => VipPacksController(),
    );
   Get.put(VipPacksController);

  }
}
