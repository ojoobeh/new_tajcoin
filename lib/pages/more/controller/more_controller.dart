import 'package:get/get.dart';

class MoreController extends GetxController {
 final isLoading = false.obs;

  MoreController() {
  }

  @override
  void onInit() {
    super.onInit();
  }
 Future<void> setLoading (final bool _isLoading) async {
   isLoading.value = _isLoading;
   update();
 }



}
