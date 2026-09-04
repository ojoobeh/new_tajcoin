import 'package:get/get.dart';
import 'package:webazin/pages/affiliate/controllers/affiliate_controller.dart';


class AffiliateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffiliateController>(
      AffiliateController.new,
    );
  }
}
