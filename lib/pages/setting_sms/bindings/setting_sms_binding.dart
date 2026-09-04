import 'package:get/get.dart';

import '../controllers/setting_sms_controller.dart';

class SettingSmsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SettingSmsController>(
      () => SettingSmsController(),
    );
   Get.put(SettingSmsController);
  }
}
