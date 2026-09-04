import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/models/string_model.dart';

import '../../../webazin/utilities.dart';
import '../../portfolio/controllers/portfolioController.dart';

class MarketAllOrderController extends GetxController {
  MarketSource marketSource = MarketSource(baseUrl: Core.uri);
  OrderSource orderSource = OrderSource(baseUrl: Core.uri);

  final marketOrderList = <DataOrderMarket>[].obs;
  final statusMarket = 'All'.obs;

  DataMarket selectMarketList = DataMarket();

  final pageOrder = 0.obs;
  final isSearching = true.obs;
  final isLoadingOrder = false.obs;
  final isDoneOrder = false.obs;

  final tecParamSearch = TextEditingController().obs;
  final status = <StringModel>[].obs;
  final type = <StringModel>[].obs;

  final selectStatus = StringModel().obs;
  final selectType = StringModel().obs;

  ScrollController scrollOrderController = ScrollController();

  MarketAllOrderController() {
    debugPrint('DDDDD');
  }

  @override
  Future<void> onInit() async {
    selectMarketList = Get.arguments;
    scrollOrderController.addListener(() {
      if (scrollOrderController.position.pixels == scrollOrderController.position.maxScrollExtent && !isDoneOrder.value) {
        if (marketOrderList.value.length > 10) {
          loadCurrenciesOfStatus(statusId: statusMarket.value);
        }
      }
    });
    changeTab("All");

    insertSpinner();

    super.onInit();
  }

  @override
  void onClose() {
    scrollOrderController.dispose();
  }

  void selectIndexStatus(StringModel stringModel) {
    selectStatus.value = stringModel;
    refreshHome();
    update();
  }

  void selectIndexType(StringModel stringModel) {
    selectType.value = stringModel;
    refreshHome();
    update();
  }

  void insertSpinner() {
    status.add(StringModel(id: 1, title: "All", param: ""));
    status.add(StringModel(id: 1, title: "Pending".tr, param: "init"));
    status.add(StringModel(id: 2, title: "Done".tr, param: "done"));
    status.add(StringModel(id: 3, title: "Canceled".tr, param: "cancel"));
    selectStatus.value = status[0];

    type.add(StringModel(id: 1, title: "All".tr, param: ""));
    type.add(StringModel(id: 1, title: "Buy".tr, param: "buy"));
    type.add(StringModel(id: 1, title: "Sale".tr, param: "sell"));
    selectType.value = type[0];

    update();
  }

  Future refreshHome({bool showMessage = false, String? statusId}) async {
    try {
      pageOrder.value = 0;

      changeTab(statusMarket.value);

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setLoading(final bool _isLoading) {
    isLoadingOrder.value = _isLoading;
    update();
  }

  Future resetSearch() async {
    tecParamSearch.value.text = "";
    update();
    refreshHome();
  }

  void cancelOrder(BuildContext context, DataOrderMarket dataMarketOrderList) async {
    if (isLoadingOrder.value == false) {
      setLoading(true);
      marketSource.canselOrderMarket(
        orderId: 1,
        onResponse: (response) {
          getUser();
          Get.find<PortfolioController>().refreshHome();
          changeTab(statusMarket.value);
          setLoading(false);
          update();
        },
        onError: (errorResponse) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          update();
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' Orders'.tr);
          debugPrint(error);
          update();
        },
      );
    }
  }

  UserSource userSource = UserSource(baseUrl: Core.uri);

  void getUser() {
    userSource.readUser(
      onResponse: (onResponse) {
        Core.user = onResponse.dataList!.first;
      },
      onError: (response) {},
      failure: (error) {},
    );
  }

  void changeTab(String statusId)  {
    this.marketOrderList.clear();
    this.marketOrderList.value = [];
    statusMarket.value = statusId;
    isSearching.value = true;
    isLoadingOrder.value = false;
    update();

    pageOrder.value = 0;
    if (selectMarketList.id != null) {
       loadCurrenciesOfStatus(statusId: statusMarket.value);
    }
  }

  void loadCurrenciesOfStatus({String? statusId})  {
    try {
      if (!isLoadingOrder.value) {
        isLoadingOrder.value = true;
        isDoneOrder.value = false;
        pageOrder.value++;
        Get.log(marketOrderList.length.toString());

        marketSource.readAllOrder(
          marketId: statusId == "AllAll" ? -1 : selectMarketList.id ?? 0,
          status: statusId == "All"
              ? "all"
              : statusId == "AllAll"
                  ? "all"
                  : "open",
          market: tecParamSearch.value.text,
          type: selectType.value.param??'',
          marketStatus: selectStatus.value.param??'',
          page: pageOrder.value,
          perPage: Core.perPage,
          onResponse: (response) {

            if (response.dataList!.isNotEmpty) {
              isSearching.value = false;
              marketOrderList.addAll(response.dataList ?? []);
            } else {
              isDoneOrder.value = true;
            }
            isSearching(false);
            isLoadingOrder(false);
            update();




          },
          onError: (errorResponse) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            update();
          },
          failure: (error) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' Orders'.tr);
            debugPrint(error);
            update();
          },
        );
      }
    } catch (e) {
      isDoneOrder.value = true;
      isSearching.value = false;
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      // isLoadingOrder.value = false;
    }
    update();
  }
}
