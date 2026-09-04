import 'package:flutter/material.dart';
import '../../../../webazin/utilities.dart';
import '../../../utils/core.dart';

class HistoryController extends GetxController {
  WalletSource walletSource = WalletSource(baseUrl: Core.uri);
  ScrollController scrollController = ScrollController();
  final isDone = false.obs;
  final isLoading = false.obs;
  final page = 0.obs;

  final historyList = <DataHistory>[].obs;

  final editingControllerCardNumber = TextEditingController();
  final myController = TextEditingController();

  var user = DataUser().obs;
  final isSearching = true.obs;
  late GlobalKey<FormState> profileForm;

  final selectOrder = DataOrder().obs;

  HistoryController() {
  }

  Future<void> refreshList() async {
    isSearching.value = true;
    page.value = 0;
    historyList.clear();
    await getHistoryList();
  }

  @override
  void onInit() async {
    user.value = Core.user;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        if (historyList.value.length > 10) {
          getHistoryList();
        }
      }
    });
    await refreshList();
    super.onInit();
  }

  Future<void> getHistoryList() async {
    if (!isLoading.value) {
      try {
        isLoading.value = true;
        isDone.value = false;
        page.value++;
        update();
        walletSource.readHistory(
          page: page.value,
          perPage: Core.perPage,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              isSearching.value = false;
              historyList.addAll(response.dataList ?? []);
            } else {
              isDone.value = true;
            }
            isSearching(false);
            isLoading(false);
            update();
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            isSearching(false);
            isLoading(false);
            isDone(true);
            update();
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle: 'Error getting history'.tr);
            isSearching(false);
            isLoading(false);
            isDone(true);
            update();
          },
        );
      } catch (e) {
        isDone(true);
      } finally {
      }
    }
  }
}
