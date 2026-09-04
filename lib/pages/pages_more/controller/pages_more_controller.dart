import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/data.dart';
import 'package:webazin/webazin/utilities.dart';


class PagesMoreController extends GetxController {
  MorePageSource morePageSource = MorePageSource(baseUrl: Core.uri);
  final isLoading = false.obs;
  final isSearching = false.obs;
  final isDone = false.obs;
  var page = 0.obs;
  var link = '';
  var title = '';
  final list = <DataMorePage>[].obs;

  ScrollController scrollController = ScrollController();

  PagesMoreController() {}

  @override
  void onInit() async {
    link = Get.arguments[0];
    title = Get.arguments[1];
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        if (list.value.length > 10) {
          getList();
        }
      }
    });
    await refreshHome();
    super.onInit();
  }

  Future refreshHome({bool showMessage = false, String? statusId}) async {
    printInfo();
    list.value.clear();
    isSearching.value = true;
    page.value = 0;
    list.clear();
    await getList();
  }

  Future<void> setLoading(final bool _isLoading) async {
    isLoading.value = _isLoading;
    update();
  }

  Future<void> getList() async {
    // MorePageSource morePageSource=MorePageSource(baseUrl: Core.uri);
    if (!isLoading.value) {
      try {
        isLoading(true);
        isDone(false);
        page.value++;

        morePageSource.read(
          page: page.value,
          perPage: Core.perPage,
          pageUrl: link,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              list.addAll(response.dataList ?? []);
              isLoading(false);
              isSearching(false);
              update();
            } else {
              isDone(true);
              isLoading(false);
              isSearching(false);
            }

            update();
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            isLoading(false);
            isSearching(false);
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + '');
            isLoading(false);
            isSearching(false);
          },
        );
      } catch (e) {
        isDone.value = true;
        // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        // isLoading.value = false;
      }
    }
  }
}
