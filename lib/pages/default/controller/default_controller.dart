import 'package:get/get.dart';

class DefaultController extends GetxController {
 final isLoading = false.obs;

  DefaultController() {
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
