import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/data.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/utilities.dart';

import 'market_controller.dart';

class MarketDrawerController extends GetxController {
  final Rx<PageState> stateDone = PageState.initial.obs;
  final Rx<PageState> stateLoading = PageState.initial.obs;
  final Rx<PageState> stateSearching = PageState.initial.obs;
  ScrollController scrollController = ScrollController();

  // final isDone = false.obs;
  // final isLoading = false.obs;
  // final isSearching = true.obs;
  final page = 0.obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final marketList = <DataMarket>[].obs;

  final selectMarketList = DataMarket().obs;
  final tecParamSearch = TextEditingController();
  final isOkk = true.obs;

  var user = DataUser().obs;

  MarketDrawerController() {}

  @override
  Future<void> onInit() async {
    // connectToServer();
    user.value = await Core.user;
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !stateDone.isDone()) {
        if (marketList.value.length > 10) {
          getMarkets(search: tecParamSearch.text, action: () => update());
        }
      }
    });

    refreshHome(
      action: () {
        if (marketList.length > 0) {
          selectMarketList.value = marketList[0];
          selectCurrency(
            selectMarketList.value,
          );
          update();
        }
      },
    );

    super.onInit();
  }

  // @override
  // void onClose() {
  //   scrollController.dispose();
  // }

  void refreshHome({bool showMessage= false, required VoidCallback action}) {
    page.value = 0;
    marketList.clear();
    marketList.value = [];
    update();
    getMarkets(search: tecParamSearch.text, action: action);
    update();
  }

  void refreshHome2({bool showMessage= false, required VoidCallback action}) {
    page.value = 0;
    marketList.clear();
    marketList.value = [];
    tecParamSearch.text = "";
    getMarkets(search: tecParamSearch.text, action: action);
    if (marketList.length > 0) {
      selectMarketList.value = marketList[0];
      Get.find<MarketController>().changeCurrency(selectMarketList.value);
    }
    update();
  }

  void selectCurrency(
    DataMarket dataMarketList,
  ) {
    if (dataMarketList != null && dataMarketList.id != null) {
      MarketController tradeController = Get.find<MarketController>();
      selectMarketList.value = dataMarketList;
      update();

      if (dataMarketList.id != null) {
        getMarkets(search: '', action: () => update());
        tradeController.changeCurrency(
          dataMarketList,
        );
      }
    }
  }

  MarketSource marketSource = MarketSource(baseUrl: Core.uri);

  void getMarkets({String search= '', required VoidCallback action}) {
    if (!stateLoading.isLoading()) {
      try {
        stateLoading.loading();
        stateDone.loading();
        page.value++;

        marketSource.read(
          page: page.value,
          perPage: 25,
          search: search,
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              marketList.addAll(response.dataList ?? []);
              stateLoading.loaded();
              stateSearching.loaded();
              action();
            } else {
              stateDone.done();
              stateLoading.loaded();
              stateSearching.loaded();
              action();
            }
          },
          onError: (errorResponse) {
            stateLoading.loaded();
            stateSearching.loaded();
          },
          failure: (error) {
            stateLoading.loaded();
            stateSearching.loaded();
          },
        );
      } catch (e) {
        stateDone.done();
        stateLoading.loaded();
        stateSearching.loaded();
        // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      } finally {
        stateLoading.loaded();
        stateSearching.loaded();
      }
      update();
    }
  }

  void resetSearch() {
    tecParamSearch.text = '';
    refreshHome(action: () => update());
    update();
  }

  void updateSelectMarket(DataMarket dataMarketList) {
    for (int i = 0; i < marketList.length; i++) {
      DataMarket market = marketList[i];
      if (market.id == dataMarketList.id) {
        marketList.removeAt(i);
        marketList.insert(i, dataMarketList);
        update();
      }
    }
  }
}
