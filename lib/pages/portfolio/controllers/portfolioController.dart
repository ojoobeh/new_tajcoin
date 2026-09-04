import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../../webazin/utilities.dart';

class PortfolioController extends GetxController {
  ScrollController scrollController = ScrollController();
  final isDone = false.obs;
  final isLoading = false.obs;
  final page = 0.obs;
  final isSearching = true.obs;

  late Timer timer;
  late Timer timer2;

  final currentStatus = '1'.obs;
  final selectLimit = ''.obs;

  final dataPortfolio = <DataPortfolio>[].obs;

  final isDismissible = true.obs;

  final isPortfolioHide = false.obs;
  final isAcceptPortFolio = false.obs;

  PortfolioController() {}

  @override
  Future<void> onInit() async {
    isPortfolioHide.value = getBool(Core.isPortFolioTrue);
    // scrollController.addListener(() {
    //   if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
    //     if (dataPortfolio.value.length > 10) {
    //       getPortfolio();
    //     }
    //   }
    // });
    await refreshHome();
    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future portfolioIsTrue(final BuildContext context) async {
    if (isAcceptPortFolio.value) {
      setData(Core.isPortFolioTrue, true);
      isPortfolioHide.value = getBool(Core.isPortFolioTrue);
      Navigator.pop(context);
    } else {
      Navigator.pop(context);
    }
    update();
    return "";
  }

  Future setIsAcceptPortFolio() async {
    isAcceptPortFolio.value = !isAcceptPortFolio.value;
    update();
  }

  Future refreshHome({bool showMessage = false, String? statusId}) async {
    printInfo();
    isLoading.value = false;
    dataPortfolio.value.clear();
    isSearching.value = true;
    page.value = 0;
    dataPortfolio.clear();
    await getPortfolio();
  }

  Future<void> getPortfolio() async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        isDone.value = false;
        page.value++;

        PortfolioSource portfolioSource = PortfolioSource(baseUrl: Core.uri);
        portfolioSource.read(
          page: page.value,
          perPage: Core.perPage,
          onResponse: (response) {
            if (response.dataList?.isNotEmpty ?? false) {
              dataPortfolio.addAll(response.dataList ?? []);
              update();
            } else {
              isDone(true);
            }
            isSearching(false);
            isLoading(false);
          },
          onError: (response) {
            retRyDialog(action: () => getPortfolio, description: response.message);
            isSearching(false);
            isLoading(false);
          },
          failure: (error) {
            retRyDialog(action: () => getPortfolio, description:'Error in receiving information '.tr + 'Portfolio'.tr);
            isSearching(false);
            isLoading(false);
          },
        );
      } catch (e) {
        isDone(true);
        // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        // isLoading.value = false;
      }
    }
  }

  void setLoading(final bool _isLoading) {
    isLoading.value = _isLoading;
    isDismissible.value = _isLoading;
    update();
  }

  void initScrollController() {
    scrollController = ScrollController();
    scrollController.addListener(() {});
  }
}
