import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/data.dart';
import 'package:webazin/webazin/utilities.dart';

import '../../../../webazin/data/dto/dto.dart';
import 'trade_controller.dart';

class TradeDrawerController extends GetxController {
  final Rx<PageState> state = PageState.initial.obs;
  CurrencySource currencySource = CurrencySource(baseUrl: Core.uri);

  final selectCurrencies = DataCurrency().obs;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final currencies = <DataCurrency>[].obs;
  final currencies2 = <DataCurrency>[].obs;

  final tecParamSearch = TextEditingController();
  final page = 0.obs;
  final isLoading = false.obs;
  final isDone = false.obs;
  final isOkk = true.obs;

  ScrollController scrollController = ScrollController();

  TradeDrawerController() {}

  @override
  Future<void> onInit() async {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        getCurrencies(
          search: tecParamSearch.text,
          action: () {
            update();
          },
        );
      }
    });

    refreshHome(
      action: () {
        if (currencies.length > 0) {
          selectCurrencies.value = currencies[0];
          selectCurrency(selectCurrencies.value);
          update();
        }
      },
    );

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  void refreshHome({required VoidCallback action, bool showMessage= false}) {
    page.value = 0;
    currencies.clear();
    currencies.value = [];
    getCurrencies(search: tecParamSearch.text, action: action);
    update();
  }

  Future changeBalance(String symbol, double balanceOne, double irtPrice) async {
    bool isDon = false;
    currencies2.assignAll(currencies.value);
    update();
    for (int i = 0; i < currencies.length; i++) {
      DataCurrency dataAssets = currencies[i];
      if (dataAssets.symbol == symbol) {
        dataAssets.irtPrice = irtPrice;
        dataAssets.countUser!.usd = balanceOne;
        if (!isDon) {
          currencies2[i] = dataAssets;
          currencies.assignAll(currencies2.value);
          debugPrint('Assets >>>>>> ${currencies.length.toString()}');
          update();
          isDon = true;
        }
      }
    }
  }

  void getCurrencies({String search = '', required VoidCallback action}) {
    try {
      isLoading.value = true;
      update();
      isDone.value = false;
      page.value++;
      currencySource.read(
        page: page.value,
        perPage: 25,
        search: search,
        onResponse: (response) {
          if (response.dataList!.isNotEmpty) {
            currencies.addAll(response.dataList ?? []);
            action();
          } else {
            isDone.value = true;
            action();
          }
        },
        onError: (errorResponse) {},
        failure: (error) {},
      );
    } catch (e) {
      isDone.value = true;
    } finally {
      isLoading.value = false;
    }

    update();
  }

  Future resetSearch() async {
    tecParamSearch.text = '';
    refreshHome(
      action: () => update(),
    );
  }

  Future resetSearch2() async {
    tecParamSearch.text = '';
    page.value = 0;
    currencies.clear();
    currencies.value = [];
    getCurrencies(
      search: tecParamSearch.text,
      action: () {
        if (currencies.length > 0) {
          selectCurrencies.value = currencies[0];
          selectCurrency(selectCurrencies.value);
          update();
        }
        update();
      },
    );
  }

  Future selectCurrency(DataCurrency dataCurrencies) async {
    if (dataCurrencies != null && dataCurrencies.id != null) {
      TradeController tradeController = Get.find<TradeController>();
      selectCurrencies.value = dataCurrencies;
      update();

      if (dataCurrencies.id != null) {
        getCurrencies(
          search: '',
          action: () {},
        );
        tradeController.selectCurrency(dataCurrencies);
      }
    }
  }
}
