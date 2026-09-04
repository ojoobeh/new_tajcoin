import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/data/remote_datasource/user_source.dart';
import 'package:webazin/webazin/utility/global.dart';

import '../../../../webazin/data/data.dart';
import '../../../../webazin/data/dto/dto.dart';
import '../../../../webazin/utilities.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/core.dart';
import '../../../utils/getMultipart.dart';
import 'trade_drawer_controller.dart';

class TradeController extends GetxController {
  WalletSource walletSource = WalletSource(baseUrl: Core.uri);
  OrderSource orderSource = OrderSource(baseUrl: Core.uri);

  final selectCurrencies = DataCurrency().obs;

  // final callAssetsIrt = CallAssets().obs;
  final balanceIrt = 0.0.obs;
  final price = 0.0.obs;
  final totalPrice = 0.obs;
  final perPrice = 0.obs;
  final tPrice = 0.obs;
  final count = 1.0.obs;

  final user = DataUser().obs;
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

  final teTotalPrice = TextEditingController();
  final tePerPrice = TextEditingController();
  final tecQuantity = TextEditingController();

  RxList<FlSpot> list = <FlSpot>[].obs;
  double min = 0;
  double max = 0;

  late ScrollController scrollController;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  TradeController() {
    user.value = Core.user;
  }

  @override
  Future<void> onInit() async {
    await refreshHome();
    await getAssetsIrt();
    // connectToServer();

    super.onInit();
  }

  @override
  void onClose() {
    scrollController.dispose();
  }

  Future refreshHome({bool showMessage = false, String statusId = ''}) async {
    try {
      page.value = 0;
      selectCurrency(selectCurrencies.value);

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future getAssetsIrt() async {
    if (isLoadingAsset.value == false) {
      try {
        var user = Core.user;
        if (user.apiToken != null && user.apiToken!.length > 5) {
          walletSource.read(
            search: "IRT",
            onResponse: (response) {
              balanceIrt.value = double.parse(response.dataList?[0].balance?.toString() ?? '0');
              update();
            },
            onError: (errorResponse) {},
            failure: (error) {},
          );
        }
      } catch (e) {
        setLoadingAssets(false);
      }
    }
  }

  //selectCurrencies.value
  Future selectCurrency(DataCurrency dataCurrencies) async {
    count.value = 0;
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
    setChartParam();
    // getCurrencies(0, search: '');
  }

  Future changeBalance(String symbol, double balanceOne, double irtPrice) async {
    if (selectCurrencies.value.symbol == symbol) {
      selectCurrencies.value.countUser!.usd = balanceOne;
    }
    await getAssetsIrt();
    update();
  }

  void setChartParam() {
    List<double> f = [];
    list.clear();
    for (int i = 0; i < selectCurrencies.value.chartData!.length; i++) {
      f.add(selectCurrencies.value.chartData![i]);
    }

    f.sort((a, b) {
      var adate = a.toString(); //before -> var adate = a.expiry;
      var bdate = b.toString(); //before -> var bdate = b.expiry;
      return bdate.compareTo(adate); //to get the order other way just switch `adate & bdate`
    });
    min = f[f.length - 1];
    max = f[0];
    for (int i = 0; i < selectCurrencies.value.chartData!.length; i++) {
      list.add(FlSpot(double.parse(i.toString()), selectCurrencies.value.chartData![i]));
    }

    update();
  }

  final qrCodeWallet = 'non'.obs;

  // Future<void> scanWalletCode() async {
  //   final qrWalletBarcode = FlutterBarcodeScanner.scanBarcode(
  //     '#3F4786',
  //     'Cancel'.tr,
  //     true,
  //     ScanMode.QR,
  //   );
  //
  //   // if(!mounted) return;
  //
  // }

  final persentageValue = 0.0.obs;

  void setPercentageCurrency(double percentage) {
    persentageValue.value = percentage;
    if (isSell.value) {
      count.value = selectCurrencies.value.countUser?.usd ?? 0;
      double pp = (percentage / 100) * count.value;

      String ppp = num.parse(gDouble(pp, decimal: int.parse(selectCurrencies.value.decimalSize ?? "0"))).toString();
      if (ppp.contains('-')) {
        ppp = '0';
      }

      tecQuantity.text = ppp;

      double cc = double.parse(price.value.toString());
      tPrice.value = (cc * (pp)).toInt();
    } else {
      double balanceUser = balanceIrt.value;
      // double balanceUser = double.parse('4000000');
      double balance = balanceUser;
      debugPrint(balance.toString());
      double pp = (percentage / 100) * balance;
      double pr = price.value;
      count.value = pp / pr;
      String ppp = num.parse(gDouble(count.value, decimal: int.parse(selectCurrencies.value.decimalSize ?? '0'))).toString();
      if (ppp.contains('-')) {
        ppp = '0';
      }

      tecQuantity.text = ppp;

      tPrice.value = (double.parse(price.value.toString()) * (count.value)).toInt();
    }

    updateTotalPrice();
  }

  void updateTotalPrice() {
    double f = tPrice.value.toDouble();

    totalPrice.value = f.toInt();
    teTotalPrice.text = getPrice(totalPrice.value.toString());

    update();
  }

  void setLoading(final bool _isLoading) {
    isLoading.value = _isLoading;
    update();
  }

  void setLoadingAssets(final bool _isLoading) {
    isLoadingAsset.value = _isLoading;
    update();
  }

  void setIsLimitPage(final bool _isLimitPage) {
    isLimitPage.value = _isLimitPage;
    update();
  }

  Future updateNetworkIndex(int index) async {
    getTotalPrice();
    updateTotalPrice();
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

  void setChangetPrice(String param) {
    if (focusTotal.hasFocus) {
      totalPrice.value = double.parse(param.replaceAll(",", "")).toInt();
      count.value = (totalPrice.value) / price.value;
      String pp = num.parse(gDouble(count.value, decimal: Core.numberCountDecimal)).toString();
      if (pp.contains('-')) {
        pp = '0';
      }

      tecQuantity.text = pp;
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

  void changeSeller(final bool isSeller) {
    isSell.value = isSeller;

    selectCurrency(selectCurrencies.value);
  }

  void buyOrder(final BuildContext context) async {
    if (isLoading.value == false) {
      setLoading(true);
      DataCurrency ss = selectCurrencies.value;
      orderSource.setStore(
        currencyId: ss.id ?? 0,
        qty: double.parse(tecQuantity.text),
        type: "buy",
        onResponse: (response) async {
          getUser();
          user.value = await Core.user;
          refreshHome();
          await Get.find<TradeDrawerController>().resetSearch2();
          // await Get.find<PortfolioController>().refreshHome();
          // await getAssetsIrt();
          toast(response.message);
          setLoading(false);
          update();
          Get.toNamed(Routes.ORDER);
        },
        onError: (errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setLoading(false);
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in buying currency'.tr);
          setLoading(false);
        },
      );

    }
  }

  void sellOrder(final BuildContext context) async {
    if (isLoading.value == false) {
      setLoading(true);
      DataCurrency ss = selectCurrencies.value;

      orderSource.setStore(
        currencyId: ss.id ?? 0,
        qty: double.parse(tecQuantity.text),
        type: "sell",
        onResponse: (response) async {
          getUser();
          user.value = await Core.user;
          refreshHome();
          await Get.find<TradeDrawerController>().resetSearch2();
          // await Get.find<PortfolioController>().refreshHome();
          // await getAssetsIrt();
          toast(response.message);
          setLoading(false);
          update();
          Get.toNamed(Routes.ORDER);
        },
        onError: (errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setLoading(false);
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in selling currency'.tr);
          setLoading(false);
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
}
