import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../utils/core.dart';

class CalculatorController extends GetxController {
  CurrencySource currencySource = CurrencySource(baseUrl: Core.uri);

  final selectCurrencies = DataCurrency().obs;

  final balanceIrt = 0.0.obs;
  final price = 0.0.obs;
  final totalPrice = 0.obs;
  final perPrice = 0.obs;
  final tPrice = 0.obs;
  final count = 1.0.obs;

  final user = DataUser().obs;
  final isDoneOrder = false.obs;
  final isSell = false.obs;
  final visibleAnim = false.obs;
  final isLoading = false.obs;
  final isLoadingAsset = false.obs;
  final isDone = false.obs;
  final isLimitPage = false.obs;

  final focusPrice = FocusNode();
  final focusCount = FocusNode();
  final focusTotal = FocusNode();
  final page = 0.obs;
  final usdtPrice = "0".obs;
  final pPrice = 0.0.obs;

  final teTotalPrice = TextEditingController();
  final tePerPrice = TextEditingController();
  final tecQuantity = TextEditingController();

  CalculatorController() {
    user.value = Core.user;
  }

  @override
  void onInit() async {
    await loadCurrenciesOfStatus();
    super.onInit();
  }

  final currencies = <DataCurrency>[].obs;

  Future loadCurrenciesOfStatus() async {
    if (!isLoading.value) {
      isLoading.value = true;
      try {
        currencySource.read(
          onResponse: (response) {
            if (response.dataList!.isNotEmpty) {
              currencies.addAll(response.dataList ?? []);
              for (int i = 0; i < currencies.length; i++) {
                if (currencies[i].symbol == "USDT") {
                  usdtPrice.value = currencies[i].irtPrice.toString();
                }
              }
              selectCurrency(response.dataList!.first);
              update();
            } else {
              isDoneOrder(true);
              isLoading(true);
            }
          },
          onError: (errorResponse) {
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            isDoneOrder(true);
            isLoading(true);
          },
          failure: (error) {
            snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving information '.tr + ' currency '.tr);
            isDoneOrder(true);
            isLoading(true);
          },
        );
      } catch (e) {
        isDoneOrder(true);
      } finally {
        isLoading(false);
      }
      update();
    }
  }

  Future selectCurrency(DataCurrency dataCurrencies) async {
    count.value = 1.0;
    selectCurrencies.value = dataCurrencies;
    price.value = (isSell.value ? (dataCurrencies.receivePrice) : (dataCurrencies.sendPrice))!;

    tPrice.value = (count.value * price.value).toInt();

    String ppp = num.parse(gDouble(count.value, decimal: Core.numberCountDecimal2)).toString();
    if (ppp.contains('-')) {
      ppp = '0';
    }

    tecQuantity.text = ppp;
    update();

    // c1.text = price.value.toString();
    updateTotalPrice();
    getTotalPrice();
    // getCurrencies(0, search: '');
  }

  void updateTotalPrice() {
    double f = tPrice.value.toDouble();

    totalPrice.value = f.toInt();
    teTotalPrice.text = getPrice(totalPrice.value.toString());

    updatePPrice();

    update();
  }

  void updatePPrice() {
    pPrice.value = totalPrice.value / double.parse(usdtPrice.value);

    update();
  }

  void setLoading(final bool _isLoading) {
    isLoading.value = _isLoading;
    update();
  }

  void setTPrice(final bool isPlus) {
    totalPrice.value = double.parse(teTotalPrice.text.replaceAll(",", "")).toInt();
    if (isPlus) {
      totalPrice.value++;
    } else {
      totalPrice.value--;
    }
    teTotalPrice.text = getPrice(totalPrice.value.toString());
    count.value = (totalPrice.value) / price.value;
    String pp = num.parse(gDouble(count.value, decimal: Core.numberCountDecimal)).toString();
    if (pp.contains('-')) {
      pp = '0';
    }

    tecQuantity.text = pp;
    updatePPrice();
    update();
    // updateTotalPrice();
  }

  void setPerPrice(final bool isPlus) {
    perPrice.value = double.parse(tePerPrice.text.replaceAll(",", "")).toInt();
    if (isPlus) {
      perPrice.value++;
    } else {
      perPrice.value--;
    }
    tePerPrice.text = getPrice(perPrice.value.toString());

    // totalPrice.value = int.parse(pp * perPrice.value);

    teTotalPrice.text = totalPrice.value.toString();
    update();
    // updateTotalPrice();
  }

  void setCount(final bool isPlus) {
    count.value = double.parse(tecQuantity.text);
    if (isPlus) {
      count.value++;
    } else {
      count.value--;
    }
    tPrice.value = (count.value * price.value).toInt();
    String pp = num.parse(gDouble(count.value, decimal: Core.numberCountDecimal)).toString();
    if (pp.contains('-')) {
      pp = '0';
    }

    tecQuantity.text = pp;
    updateTotalPrice();
  }

  void setChangeCount(String param) {
    if (focusCount.hasFocus) {
      count.value = double.parse(param);
      tPrice.value = (count.value * price.value).toInt();

      updateTotalPrice();
    }
  }

  void setChangetPrice(String params) {
    if (focusTotal.hasFocus) {
      String param = '';
      params == '' ? param = '0' : param = params;
      totalPrice.value = double.parse(param.replaceAll(",", "")).toInt();
      count.value = (totalPrice.value) / price.value;
      String pp = gDouble(count.value, decimal: Core.numberCountDecimal);
      if (pp.contains('-')) {
        pp = '0';
      }

      tecQuantity.text = pp;
      updatePPrice();
      update();

      // count.value = (double.parse(param) / price.value);
      // tPrice.value = (count.value * price.value).toInt();
      // updateTotalPrice();
    }
  }

  Future getTotalPrice() async {
    tPrice.value = (count.value * price.value).toInt();

    update();
  }

  void changeSeller() {
    isSell.value = !isSell.value;

    selectCurrency(selectCurrencies.value);
  }


}
