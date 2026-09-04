import 'package:get/get.dart';

import '../controllers/bankCardController.dart';


class BankCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BankCardController>(
      () => BankCardController(),
    );

  }
}
