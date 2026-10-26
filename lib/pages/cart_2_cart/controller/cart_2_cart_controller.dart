import 'package:get/get.dart';

class Cart2CartController extends GetxController {
 final isLoading = false.obs;

 Cart2CartController() {
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
