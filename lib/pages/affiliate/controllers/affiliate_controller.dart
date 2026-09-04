import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';

import '../../../../webazin/utilities.dart';

class AffiliateController extends GetxController {
  AffiliateController() {}

  Rx<DataAffiliate> dataAffiliate = DataAffiliate().obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    printInfo();
    getParam();
    super.onInit();
  }

  Future<void> getParam() async {
    AffiliateSource affiliateSource = AffiliateSource(baseUrl: Core.uri);
    try {
      affiliateSource.read(
        onResponse: (response) {
          dataAffiliate.value = response.data!;
          setLoading(false);
        },
        onError: (errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setLoading(false);
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr );
          setLoading(false);
        },
      );

      update();
    } on Exception catch (_) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  // ignore: avoid_positional_boolean_parameters
  void setLoading(final bool _isLoading) {
    isLoading.value = _isLoading;
    update();
  }
}
