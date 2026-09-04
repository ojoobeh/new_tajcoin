import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/data.dart';

import '../../../../webazin/data/dto/dto.dart';
import '../../../webazin/utilities.dart';

class HomeAllOrderController extends GetxController {
  CurrencySource currencySource = CurrencySource(baseUrl: Core.uri);

  final currencies = <DataCurrency>[].obs;
  final statusMarket = 'All'.obs;
  final typeMarket = ''.obs;

  final pageOrder = 0.obs;
  final isLoadingOrder = false.obs;
  final isSearching = true.obs;
  final isDoneOrder = false.obs;

  ScrollController scrollOrderController = ScrollController();

  HomeAllOrderController() {
    debugPrint('DDDDD');
  }

  @override
  Future<void> onInit() async {
    // selectMarketList = Get.arguments;
    scrollOrderController.addListener(() {
      if (scrollOrderController.position.pixels == scrollOrderController.position.maxScrollExtent && !isDoneOrder.value) {
        if (currencies.value.length > 10) {
          loadCurrenciesOfStatus(statusId: statusMarket.value, type: typeMarket.value);
        }
      }
    });
    changeTab("All", '');

    super.onInit();
  }

  @override
  void onClose() {
    scrollOrderController.dispose();
  }

  Future refreshHome({bool showMessage = false, String statusId = ''}) async {
    try {
      pageOrder.value = 0;
      changeTab(statusMarket.value, typeMarket.value);
      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setLoading(final bool _isLoading) {
    isLoadingOrder.value = _isLoading;
    update();
  }

  void changeTab(String statusId, String type) {
    this.currencies.clear();
    this.currencies.value = [];
    statusMarket.value = statusId;
    typeMarket.value = type;
    update();
    pageOrder.value = 0;
    isSearching(true);
    isLoadingOrder(true);
    loadCurrenciesOfStatus(statusId: statusMarket.value, type: type);
  }

  void loadCurrenciesOfStatus({String statusId = '', String type = ''}) {
    try {
      isLoadingOrder.value = true;
      isDoneOrder.value = false;
      pageOrder.value++;

      if (statusId == "All") {
        currencySource.read(
          page: pageOrder.value,
          perPage: 25,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              isSearching.value = false;
              currencies.addAll(response.dataList ?? []);
            } else {
              isDoneOrder.value = true;
            }
            isSearching(false);
            isLoadingOrder(false);
            update();
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            isSearching(false);
            isLoadingOrder(false);
            isDoneOrder(true);
            update();
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' currency '.tr);
            isSearching(false);
            isLoadingOrder(false);
            isDoneOrder(true);
            update();
          },
        );
      } else {
        currencySource.readOscillation(
          page: pageOrder.value,
          type: type,
          perPage: 25,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              isSearching.value = false;
              currencies.addAll(response.dataList ?? []);
            } else {
              isDoneOrder.value = true;
            }
            isSearching(false);
            isLoadingOrder(false);
            update();
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            isSearching(false);
            isLoadingOrder(false);
            isDoneOrder(true);
            update();
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' currency '.tr);
            isSearching(false);
            isLoadingOrder(false);
            isDoneOrder(true);
            update();
          },
        );
      }
      update();
    } catch (e) {
      isDoneOrder.value = true;
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      isLoadingOrder.value = false;
    }
    update();
  }
}
