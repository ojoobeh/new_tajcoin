import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/models/socket/socket_list_up_down.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';
import '../../../utils/getMultipart.dart';
import '../../assets/controllers/assets_controller.dart';
import '../../trader/controllers/trade_controller.dart';
import '../../trader/controllers/trade_drawer_controller.dart';
import 'market_drawer_controller.dart';

class MarketController extends GetxController {
  MarketSource marketSource = MarketSource(baseUrl: Core.uri);

  final count = 1.0.obs;
  final count2 = 1.0.obs;
  final price = 0.0.obs;
  final isSell = false.obs;
  final totalPrice = 0.0.obs;

  final teTotalPrice = TextEditingController();
  final tePerPrice = TextEditingController();
  final tecQuantity = TextEditingController();
  final tPrice = 0.0.obs;
  final isLimit = true.obs;

  final focusPrice = FocusNode();
  final focusCount = FocusNode();
  final focusTotal = FocusNode();

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final marketOrderList = <DataOrderMarket>[].obs;
  final selectMarketList = DataMarket().obs;
  final isSelectMarket = false.obs;

  final pageOrder = 0.obs;
  final isLoadingOrder = false.obs;
  final isDoneOrder = false.obs;
  final getOrder = false.obs;

  final listUp = <SocketListUpDown>[].obs;
  final listDown = <SocketListUpDown>[].obs;
  final close = "".obs;

  final persentageValue = 0.0.obs;

  var user = DataUser().obs;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  MarketController() {
    // _marketRepository = MarketRepository();
  }

  @override
  Future<void> onInit() async {
    user.value = await Core.user;
    getOrder.value = false;
    update();
    await loadMarket();
    connectToServer();
    getData();
    super.onInit();
  }

  void showTutorial(final BuildContext context) {
    initTargets(context);
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.blueGrey,
      textSkip: "",
      textStyleSkip: TextStyle(
        fontSize: 20,
        color: AppColors.orangeColor,
        fontFamily: FontFamily.vazirBold,
      ),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        setData('${Core.helperMarket}', true);
      },
      onClickTarget: (target) {
        debugPrint('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        debugPrint("target: $target");
        debugPrint("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (target) {
        debugPrint('onClickOverlay: $target');
      },
      onSkip: () {
        // Get.find<AuthService>().addShowHelper(AuthService.helperMarket);
        return true;
      },
    )..show(context:context);
  }

  void initTargets(final BuildContext context) {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "Test".tr,
        keyTarget: keyButton1,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 32,
                    ),
                    Center(
                        child: Image.asset(
                          Assets.arrow2,
                          width: 100,
                          height: 100,
                          color: Colors.yellow,
                        )),
                    Text(
                      "Market".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.vazirBold,
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                    ).marginOnly(top: 16),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "Buying and selling is fast and your currency is traded at the best market price and the fastest time.".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    targets.add(
      TargetFocus(
        identify: "limit".tr,
        keyTarget: keyButton2,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 16, top: 32),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            Assets.arrow2,
                            width: 100,
                            height: 100,
                            color: Colors.yellow,
                          )),
                    ),
                    Text(
                      "limit".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.vazirBold,
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                    ).marginOnly(top: 32),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "In this section, you can enter your desired price".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void getData() {
    //perform http request here
    //show cool alert
  }

  Future refreshHome({bool showMessage = false, String statusId = ""}) async {
    try {
      pageOrder.value = 0;
      selectCurrency(
        selectMarketList.value,
      );

      update();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void setIsLimit(final bool _isLimit) {
    if (!_isLimit) {
      teTotalPrice.text = '';
      totalPrice.value = 0;

      update();
    }
    isLimit.value = _isLimit;
    update();
  }

  void setPercentageCurrency(double percentage) {
    persentageValue.value = percentage;
    double cash = isSell.value ? double.parse(selectMarketList.value.balanceOne.toString()) : double.parse(selectMarketList.value.balanceTwo.toString());
    if (isSell.value) {
      count.value = (percentage / 100) * cash;
      count2.value = count.value;
      tecQuantity.text = sDouble(count.value.toString(), decimal: int.parse(selectMarketList.value.decimal));
      double per = double.parse(tePerPrice.text.replaceAll(",", ""));
      totalPrice.value = (count.value * per);
      teTotalPrice.text = gDouble(totalPrice.value, decimal: Core.numberCountDecimal2);
    } else {
      double tPrice = (percentage / 100) * cash;
      teTotalPrice.text = sDouble(tPrice.toString(), decimal: Core.numberCountDecimal2);
      double cCount = (tPrice) / double.parse(tePerPrice.text);
      tecQuantity.text = gDouble(cCount, decimal: int.parse(selectMarketList.value.decimal));
    }

    update();
  }

  void setPercentageProCurrency(double percentage) {
    persentageValue.value = percentage;
    double cash = isSell.value ? double.parse(selectMarketList.value.balanceOne.toString()) : double.parse(selectMarketList.value.balanceTwo.toString());
    if (isSell.value) {
      count.value = (percentage / 100) * cash;
      count2.value = count.value;
      tecQuantity.text = sDouble(count.value.toString(), decimal: int.parse(selectMarketList.value.decimal));
      double per = double.parse(tePerPrice.text.replaceAll(",", ""));
      totalPrice.value = (count.value * per);
      teTotalPrice.text = gDouble(totalPrice.value, decimal: Core.numberCountDecimal2);
    } else {
      double tPrice = (percentage / 100) * cash;
      teTotalPrice.text = sDouble(tPrice.toString(), decimal: Core.numberCountDecimal2);
      double cCount = (tPrice) / double.parse(tePerPrice.text);
      tecQuantity.text = gDouble(cCount, decimal: int.parse(selectMarketList.value.decimal));
    }

    update();
  }

  Future changeCurrency(
      DataMarket dataMarket,
      ) async {
    await updateOrder(dataMarket);
    selectCurrency(dataMarket);
    // connectToServer();
  }

  void setIsLoadingOrder(final bool _isLoadingOrder) {
    isLoadingOrder.value = _isLoadingOrder;
    update();
  }

  Future selectCurrency(
      DataMarket dataMarket,
      ) async {
    listDown.clear();
    listUp.clear();
    close.value = "0";
    update();

    selectMarketList.value = dataMarket;
    isSelectMarket(true);
    isLoadingOrder(false);
    update();
    if (!isLoadingOrder.value) {
      setIsLoadingOrder(true);
      marketSource.readById(
        marketId: dataMarket.id!,
        onResponse: (response) {
          selectMarketList.value = response.dataList![0];
          dataMarket = response.dataList![0];
          update();
        },
        onError: (errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' currency '.tr);
        },
      );

      setIsLoadingOrder(false);
      getOrder.value = false;
      // await loadMarket();
      isSelectMarket.value = true;
      update();
      count.value = 0;
      count2.value = count.value;
      tePerPrice.text = sDouble(dataMarket.price.toString(), decimal: int.parse(dataMarket.decimal));

      close.value = selectMarketList.value.price.toStringAsFixed(int.parse(selectMarketList.value.decimal));

      price.value = double.parse(selectMarketList.value.price.toString());

      tPrice.value = (count.value * price.value);

      String ppp = num.parse(gDouble(count.value, decimal: 6)).toString();
      if (ppp.contains('-')) {
        ppp = '0';
      }

      tecQuantity.text = ppp;
      update();

      update();

      // c1.text = price.value.toString();
      getTotalPrice();
      // getCurrencies(0, search: '');

    }
  }

  Future selectCurrency2(
      DataMarket dataMarket,
      ) async {
    selectMarketList.value = dataMarket;
    count.value = 1.0;
    count2.value = count.value;
    tePerPrice.text = sDouble(dataMarket.price.toString(), decimal: int.parse(dataMarket.decimal));

    close.value = selectMarketList.value.price.toString();

    price.value = double.parse(selectMarketList.value.price.toString());

    tPrice.value = (count.value * price.value);

    String ppp = num.parse(gDouble(count.value, decimal: 6)).toString();
    if (ppp.contains('-')) {
      ppp = '0';
    }

    tecQuantity.text = "";
    teTotalPrice.text = "";

    update();

    // c1.text = price.value.toString();
    getTotalPrice();
    // getCurrencies(0, search: '');
  }

  Future getTotalPrice() async {
    tPrice.value = (count.value * price.value);
    teTotalPrice.text = sDouble(tPrice.value.toString(), decimal: Core.numberCountDecimal2);

    update();
  }

  void setTPrice(final bool isPlus) {
    double cc = double.parse(tePerPrice.text);
    if (isPlus) {
      cc++;
    } else {
      if (cc > 0) {
        cc--;
      }
    }
    //
    tePerPrice.text = cc.toString();
    totalPrice.value = (count.value * double.parse(tePerPrice.text));

    update();
    updateTotalPrice();
  }

  void changeTPrice(String price) {
    totalPrice.value = (count.value * double.parse(tePerPrice.text));

    update();
    updateTotalPrice();
  }

  //
  //
  //
  //

  void changeTPrice2(String price) {
    if (tePerPrice.text.length == 0) {
      tePerPrice.text = "0";
    }
    if (!isLimit.value) {
      tePerPrice.text = '0';
    } else {
      tePerPrice.text = sDouble(price, decimal: int.parse(selectMarketList.value.decimal));
      totalPrice.value = (count.value * double.parse(tePerPrice.text));

      update();
      updateTotalPrice();
    }
  }

  void setCount(final bool isPlus) {
    count.value = double.parse(tecQuantity.text);
    count2.value = count.value;
    if (isPlus) {
      count.value++;
    } else {
      count.value--;
    }
    totalPrice.value = (count.value * double.parse(tePerPrice.text));

    tecQuantity.text = count.value.toString();
    updateTotalPrice();
  }

  void changeCount(String _count) {
    if (focusCount.hasFocus) {
      count.value = double.parse(_count);
      count2.value = count.value;

      totalPrice.value = (count.value * double.parse(tePerPrice.text));

      updateTotalPrice();
    }
  }

  void changeTotalPrice(String _totalPrice) {
    if (focusTotal.hasFocus) {
      double tPrice = double.parse(_totalPrice);
      double _count = tPrice / double.parse(tePerPrice.text);

      tecQuantity.text = sDouble(_count.toString(), decimal: int.parse(selectMarketList.value.decimal));

      count.value = double.parse(tecQuantity.text);
      count2.value = count.value;

      update();
    }
  }

  void setTotalPrice(final bool isPlus) {
    double cc = double.parse(teTotalPrice.text);
    if (isPlus) {
      cc++;
    } else {
      if (cc > 0) {
        cc--;
      }
    }
    teTotalPrice.text = gDouble(cc, decimal: Core.numberCountDecimal2);
    tecQuantity.text = (totalPrice.value / double.parse(tePerPrice.value.text)).toString();
    count.value = double.parse(tecQuantity.text);
    count2.value = count.value;
    update();
    // updateTotalPrice();
  }

  void updateTotalPrice() {
    teTotalPrice.text = sDouble(totalPrice.value.toString(), decimal: Core.numberCountDecimal2);

    update();
  }

  Future<void> changeSeller(final bool isSeller) async {
    isSell.value = isSeller;

    selectCurrency2(
      selectMarketList.value,
    );
  }

  void buyOrder(final BuildContext context) async {
    if (isLoadingOrder.value == false) {
      DataMarket ss = selectMarketList.value;
      showLoading();
      setIsLoadingOrder(true);
      marketSource.storeMarket(
        storeMarket: StoreMarket(
          marketId: ss.id,
          price: tePerPrice.text.replaceAll(",", ""),
          count: tecQuantity.text,
          type: "buy",
          orderType: "limit",
        ),
        onResponse: (response) {
          getUser(action: () {
            user.value = Core.user;
            snackbarGreen(title: 'Success'.tr, subtitle: response.message);
            dismissLoading();
            setIsLoadingOrder(false);
            update();
          });
        },
        onError: (errorResponse) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setIsLoadingOrder(false);
          update();
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in buying currency'.tr);
          setIsLoadingOrder(false);
          debugPrint(error);
          update();
        },
      );
    }
  }

  void buyOrderPro(final BuildContext context) async {
    if (isLoadingOrder.value == false) {
      if (teTotalPrice.text.length > 0) {
        DataMarket ss = selectMarketList.value;
        showLoading();
        setIsLoadingOrder(true);
        marketSource.storeMarket(
          storeMarket: StoreMarket(
            marketId: ss.id,
            sum: teTotalPrice.text,
            type: "buy",
            orderType: "market",
          ),
          onResponse: (response) {
            getUser(action: () {
              user.value = Core.user;
              snackbarGreen(title: 'Success'.tr, subtitle: response.message);
              dismissLoading();
              setIsLoadingOrder(false);
              update();
            });
          },
          onError: (errorResponse) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            setIsLoadingOrder(false);
            update();
          },
          failure: (error) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: 'Error in buying currency'.tr);
            debugPrint(error);
            setIsLoadingOrder(false);
            update();
          },
        );
      } else {
        toast("Enter the budget".tr);
      }
    }
  }

  void sellOrder2(final BuildContext context) async {
    Get.find<AssetsController>().changeBalance("BTC", double.parse("150"), double.parse("20"), 0.0);
  }

  void sellOrder(final BuildContext context) async {
    // Get.find<AssetsController>().changeBalance("BTC", double.parse("150"), double.parse("20"));

    if (isLoadingOrder.value == false) {
      DataMarket ss = selectMarketList.value;

      setIsLoadingOrder(true);
      marketSource.storeMarket(
        storeMarket: StoreMarket(
          marketId: ss.id,
          price: tePerPrice.text.replaceAll(",", ""),
          count: count.value.toString(),
          type: "sell",
          orderType: "limit",
        ),
        onResponse: (response) {
          getUser(action: () {
            user.value = Core.user;
            snackbarGreen(title: 'Success'.tr, subtitle: response.message);
            dismissLoading();
            setIsLoadingOrder(false);
            update();
          });
        },
        onError: (errorResponse) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setIsLoadingOrder(false);
          update();
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in selling currency'.tr);
          debugPrint(error);
          setIsLoadingOrder(false);
          update();
        },
      );
    }
  }

  void sellOrderPro(final BuildContext context) async {
    if (isLoadingOrder.value == false) {
      if (tecQuantity.text.length > 0) {
        DataMarket ss = selectMarketList.value;

        setIsLoadingOrder(true);
        marketSource.storeMarket(
          storeMarket: StoreMarket(
            marketId: ss.id,
            count: tecQuantity.text,
            type: "sell",
            orderType: "market",
          ),
          onResponse: (response) {
            getUser(action: () {
              user.value = Core.user;
              snackbarGreen(title: 'Success'.tr, subtitle: response.message);
              dismissLoading();
              setIsLoadingOrder(false);
              update();
            });
          },
          onError: (errorResponse) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            setIsLoadingOrder(false);
            update();
          },
          failure: (error) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: 'Error in selling currency');
            debugPrint(error);
            setIsLoadingOrder(false);
            update();
          },
        );
      } else {
        toast('Enter the amount'.tr);
      }
    }
  }

  void cancelOrder(BuildContext context, DataOrderMarket dataOrderMarket) async {
    if (isLoadingOrder.value == false) {
      setIsLoadingOrder(true);
      marketSource.readOrder(
        status: 'cancel',
        marketId: dataOrderMarket.id ?? 0,
        onResponse: (response) {
          getUser(action: () {
            user.value = Core.user;
            snackbarGreen(title: 'Success'.tr, subtitle: response.message);
            dismissLoading();
            setIsLoadingOrder(false);
            update();
          });
          update();
        },
        onError: (errorResponse) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          setIsLoadingOrder(false);
          update();
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in operation'.tr);
          debugPrint(error);
          setIsLoadingOrder(false);
          update();
        },
      );
    }
  }

  Future loadMarket() async {
    if (!getOrder.value) {
      try {
        getOrder.value = true;
        close.value = "0";
        update();
        isLoadingOrder.value = true;
        isDoneOrder.value = false;
        marketOrderList.clear();
        marketOrderList.value = [];

        marketSource.readOrder(
          status: 'open',
          marketId: selectMarketList.value.id ?? 0,
          onResponse: (response) {
            marketOrderList.assignAll(response.dataList ?? []);
            isDoneOrder(true);
            update();
          },
          onError: (errorResponse) {
            isDoneOrder(true);
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            update();
          },
          failure: (error) {
            dismissLoading();
            snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + ' Orders'.tr);
            isDoneOrder(true);
            debugPrint(error);
            update();
          },
        );
      } catch (e) {
        isDoneOrder(true);
      } finally {
        // isLoadingOrder.value = false;
      }
      getOrder.value = false;
      update();
    }
  }

  Future updateOrder(DataMarket dataMarketList) async {
    if (selectMarketList.value.symbol == dataMarketList.symbol) {
      Future.delayed(Duration(seconds: 3), () async => await loadMarket());
    }
  }

  Future<void> updateAfterTrade(DataMarket dataMarketList) async {
    getUser(action: () {
      user.value = Core.user;
    });
    // await Get.find<AssetsController>().getAssets();
    Get.find<MarketDrawerController>().updateSelectMarket(dataMarketList);
    isDoneOrder(true);
    isLoadingOrder.value = false;
    update();
  }

  Future updateBalance(dynamic e) async {
    selectMarketList.value.balanceTwo = 90.666;
    isSell.value = isSell.value;
    selectCurrency2(
      selectMarketList.value,
    );
  }
  IO.Socket? socket;

  bool _isSocketConnecting = false;
  // void connectToServer() {
  //   try {
  //     if (_isSocketConnecting) {
  //       print('⚠️ Socket is already connecting...');
  //       return;
  //     }
  //
  //     _isSocketConnecting = true;
  //
  //     final String socketUrl =
  //         '${Core.laravelBaseUrl2}:${Core.port}';
  //
  //     print('======================================');
  //     print('🔌 CONNECTING SOCKET');
  //     print('URL: $socketUrl');
  //     print('USER ID: ${user.value.id}');
  //     print('======================================');
  //
  //     // اگر قبلاً socket وجود دارد
  //     if (socket != null) {
  //       print('🧹 Disconnect old socket');
  //
  //       socket!.clearListeners();
  //       socket!.disconnect();
  //       socket!.dispose();
  //
  //       socket = null;
  //     }
  //
  //     socket = IO.io(
  //       socketUrl,
  //       IO.OptionBuilder()
  //           .setTransports(['websocket'])
  //           .disableAutoConnect()
  //           .enableReconnection()
  //           .setReconnectionAttempts(999999)
  //           .setReconnectionDelay(1000)
  //           .setReconnectionDelayMax(5000)
  //           .setTimeout(10000)
  //           .setExtraHeaders({
  //         'Authorization': 'Bearer ${user.value.apiToken}',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //       })
  //           .setAuth({
  //         'token': user.value.apiToken,
  //       })
  //           .build(),
  //     );
  //
  //     _registerSocketConnectionEvents();
  //
  //     socket!.connect();
  //
  //   } catch (e, stackTrace) {
  //     _isSocketConnecting = false;
  //
  //     print('❌ SOCKET CONNECTION ERROR');
  //     print(e);
  //     print(stackTrace);
  //   }
  // }
  void connectToServer() {
    try {
      final String url =
          // '${Core.laravelBaseUrl2}:${Core.port}';
          'https://tajcoin.org:6003';

      print('');
      print('==========================================');
      print('🔌 SOCKET DEBUG');
      print('==========================================');
      print('URL: $url');
      print('Base URL: ${Core.laravelBaseUrl2}');
      print('Port: ${Core.port}');
      print('Transport: websocket');
      print('==========================================');

// Socket قبلی را کامل ببند
      if (socket != null) {
        print('🧹 Disposing previous socket...');

        socket!.clearListeners();
        socket!.disconnect();
        socket!.dispose();

        socket = null;
      }

      socket = IO.io(
        url,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .enableForceNew()
            .enableReconnection()
            .setReconnectionAttempts(10)
            .setReconnectionDelay(2000)
            .setReconnectionDelayMax(5000)
            .setTimeout(20000)
            .setExtraHeaders({
          'Authorization': 'Bearer ${user.value.apiToken}',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        })
            .build(),
      );

      _registerSocketConnectionEvents();

      socket!.onConnect((_) {
        print('');
        print('🟢🟢🟢 SOCKET CONNECTED 🟢🟢🟢');
        print('Socket ID: ${socket!.id}');
        print('Connected: ${socket!.connected}');
      });

      socket!.onConnectError((error) {
        print('');
        print('❌❌❌ SOCKET CONNECT ERROR ❌❌❌');
        print(error.runtimeType);
        print(error);
      });

      socket!.onError((error) {
        print('');
        print('❌❌❌ SOCKET ERROR ❌❌❌');
        print(error.runtimeType);
        print(error);
      });

      socket!.onDisconnect((reason) {
        print('');
        print('🔴🔴🔴 SOCKET DISCONNECTED 🔴🔴🔴');
        print('Reason: $reason');
      });

      socket!.onReconnectAttempt((attempt) {
        print('🔄 Reconnect attempt: $attempt');
      });

      socket!.onReconnect((attempt) {
        print('🟡 Reconnected after attempt: $attempt');
      });

      socket!.connect();

    } catch (e, stackTrace) {
      print('');
      print('💥💥💥 SOCKET EXCEPTION 💥💥💥');
      print(e);
      print(stackTrace);
    }
  }
  void _registerSocketConnectionEvents() {
    if (socket == null) return;

    socket!.onConnect((_) {
      _isSocketConnecting = false;

      print('🟢 SOCKET CONNECTED');
      print('Socket ID: ${socket!.id}');

      _subscribeToChannels();
    });

    socket!.onDisconnect((reason) {
      print('🔴 SOCKET DISCONNECTED');
      print('Reason: $reason');
    });

    socket!.onConnectError((error) {
      _isSocketConnecting = false;

      print('❌ SOCKET CONNECT ERROR');
      print(error);
    });

    socket!.onError((error) {
      print('❌ SOCKET ERROR');
      print(error);
    });

    socket!.onReconnect((attempt) {
      print('🟡 SOCKET RECONNECTED');
      print('Attempt: $attempt');

      _subscribeToChannels();
    });

    socket!.onReconnectAttempt((attempt) {
      print('🔄 SOCKET RECONNECT ATTEMPT: $attempt');
    });

    socket!.onReconnectError((error) {
      print('❌ SOCKET RECONNECT ERROR');
      print(error);
    });

    socket!.onReconnectFailed((_) {
      print('❌ SOCKET RECONNECT FAILED');
    });
  }

  void _subscribeToChannels() {
    if (socket == null || !socket!.connected) {
      print('❌ Socket is not connected');
      return;
    }

    final String balanceChannel =
        '${Core.channel}_database_balance-Update-${user.value.id}';

    final String askBidChannel =
        '${Core.channel}_database_ask-bid-channel-${selectMarketList.value.symbol}';

    final String tickerChannel =
        '${Core.channel}_database_ticker-update-channels';

    print('======================================');
    print('📡 SUBSCRIBING CHANNELS');
    print('Balance: $balanceChannel');
    print('AskBid: $askBidChannel');
    print('Ticker: $tickerChannel');
    print('======================================');

    // --------------------------------------------------
    // Laravel Echo Server Channel Subscription
    // --------------------------------------------------

    socket!.emit('subscribe', {
      'channel': balanceChannel,
    });

    socket!.emit('subscribe', {
      'channel': askBidChannel,
    });

    socket!.emit('subscribe', {
      'channel': tickerChannel,
    });

    _registerBalanceListener(balanceChannel);

    _registerAskBidListener(askBidChannel);

    _registerTickerListener(tickerChannel);
  }

  void _registerBalanceListener(String channelName) {
    if (socket == null) return;

    socket!.off('BalanceUpdate');

    socket!.on('BalanceUpdate', (dynamic e) {
      try {
        print('💰 BalanceUpdate');
        print(e);

        Map<String, dynamic> dataEvent =
        Map<String, dynamic>.from(e);

        _handleBalanceUpdate(dataEvent);

      } catch (error, stackTrace) {
        print('❌ BalanceUpdate Error');
        print(error);
        print(stackTrace);
      }
    });

    // بعضی Laravel Echo Server ها event را با نام کامل می‌فرستند
    socket!.off('.BalanceUpdate');

    socket!.on('.BalanceUpdate', (dynamic e) {
      try {
        Map<String, dynamic> dataEvent =
        Map<String, dynamic>.from(e);

        _handleBalanceUpdate(dataEvent);

      } catch (error) {
        print('❌ .BalanceUpdate Error: $error');
      }
    });
  }

  void _handleBalanceUpdate(
      Map<String, dynamic> e,
      ) {
    if (e['isWallet'] == false) {
      if (e['id'] == selectMarketList.value.id) {
        Map<String, dynamic> data = {
          "id": e['id'],
          "marketId": selectMarketList.value.id,
          "icon": selectMarketList.value.icon,
          "symbol": selectMarketList.value.symbol,
          "price": selectMarketList.value.price,
          "decimal": selectMarketList.value.decimal,
          "percent": selectMarketList.value.percent,
          "BalanceOne": e['BalanceOne'],
          "BalanceTwo": e['BalanceTwo'],
        };

        DataMarket dataMarketList =
        DataMarket.fromMap(data);

        selectCurrency(dataMarketList);

        getOrder.value = false;

        update();

        updateAfterTrade(dataMarketList);

        updateOrder(dataMarketList);

      } else {
        Map<String, dynamic> data = {
          "id": selectMarketList.value.id,
          "marketId": selectMarketList.value.id,
          "icon": selectMarketList.value.icon,
          "symbol": selectMarketList.value.symbol,
          "price": selectMarketList.value.price,
          "decimal": selectMarketList.value.decimal,
          "percent": selectMarketList.value.percent,
          "BalanceOne": selectMarketList.value.balanceOne,
          "BalanceTwo": e['BalanceTwo'],
        };

        DataMarket dataMarketList =
        DataMarket.fromMap(data);

        selectCurrency2(dataMarketList);

        getOrder.value = false;

        update();

        updateAfterTrade(dataMarketList);
      }

    } else {
      String currency = e['currency'].toString();

      String balanceOne =
      e['BalanceOne'].toString();

      String irtPrice =
      e['irtPrice'].toString();

      Get.find<AssetsController>().changeBalance(
        currency,
        double.parse(balanceOne),
        double.parse(irtPrice),
        0.0,
      );

      Get.find<TradeController>().changeBalance(
        currency,
        double.parse(balanceOne),
        double.parse(irtPrice),
      );

      Get.find<TradeDrawerController>().changeBalance(
        currency,
        double.parse(balanceOne),
        double.parse(irtPrice),
      );

      prt(
        '$balanceOne ::::: $irtPrice',
      );
    }
  }

  void _registerAskBidListener(String channelName) {
    if (socket == null) return;

    socket!.off('AskBid');
    socket!.off('.AskBid');

    void handle(dynamic e) {
      try {
        print('📊 AskBid Event');
        print(e);

        Map<String, dynamic> data;

        if (e is Map) {
          data = Map<String, dynamic>.from(e);
        } else {
          data = jsonDecode(e.toString());
        }

        _handleAskBid(data);

      } catch (error, stackTrace) {
        print('❌ AskBid Error');
        print(error);
        print(stackTrace);
      }
    }

    socket!.on('AskBid', handle);

    socket!.on('.AskBid', handle);
  }

  void _handleAskBid(
      Map<String, dynamic> data,
      ) {
    var asks = data['asks'];

    var bids = data['bids'];

    Map<String, dynamic> yy =
    bids != null
        ? Map<String, dynamic>.from(bids)
        : {};

    Map<String, dynamic> xx =
    asks != null
        ? Map<String, dynamic>.from(asks)
        : {};

    // ============================
    // BID
    // ============================

    if (yy.isNotEmpty) {
      List<SocketListUpDown> dd = [];

      yy.forEach((key, value) {
        double d = double.parse(
          key.toString(),
        );

        String f = d.toString();

        Map<String, dynamic> item = {
          "price": f,
          "percentage": value[0].toString(),
          "volume":
          value.length > 1
              ? value[1].toString()
              : "40",
        };

        dd.add(
          SocketListUpDown.fromJson(item),
        );
      });

      List<SocketListUpDown> listReverse =
      dd.reversed.toList();

      listDown.assignAll(
        listReverse,
      );
    }

    // ============================
    // ASK
    // ============================

    if (xx.isNotEmpty) {
      List<SocketListUpDown> dd = [];

      xx.forEach((key, value) {
        double d = double.parse(
          key.toString(),
        );

        String f = d.toString();

        Map<String, dynamic> item = {
          "price": f,
          "percentage": value[0].toString(),
          "volume":
          value.length > 1
              ? value[1].toString()
              : "0",
        };

        dd.add(
          SocketListUpDown.fromJson(item),
        );
      });

      listUp.assignAll(dd);
    }

    update();
  }

  void _registerTickerListener(String channelName) {
    if (socket == null) return;

    const eventName = 'App\\Events\\Binance\\GetTicker';

    socket!.off(eventName);

    socket!.on(eventName, (dynamic e) {
      try {
        print('📈 Ticker Event');
        print('TYPE: ${e.runtimeType}');
        print('DATA: $e');

        dynamic tickerData;


        // Socket.IO event به صورت List آمده:
        //
        // [
        //   "tajcoin_database_ticker-update-channels",
        //   {
        //     "symbol": "ETH-USDT",
        //     "high": 2523.63,
        //     "low": 2461.49,
        //     "close": 2489.93,
        //     "volume": 78980747.29709482,
        //     "percentChange": "0.44"
        //   }
        // ]

        if (e is List && e.length > 1) {//
          tickerData = e[1];

        } else if (e is Map) {
          tickerData = e;
        } else if (e is String) {
          final decoded = jsonDecode(e);

          if (decoded is List && decoded.length > 1) {
            tickerData = decoded[1];
          } else {
            tickerData = decoded;
          }
        }

        if (tickerData == null) {
          print('❌ Ticker data is null');
          print('❌ Ticker data is null');
          return;
        }

        if (tickerData is! Map) {
          print('❌ Invalid ticker data type: ${tickerData.runtimeType}');
          print('❌ Invalid ticker data type: ${tickerData.runtimeType}');

          var yyy = jsonDecode(tickerData);
          CallMarketClose callMarketClose = CallMarketClose.fromJson(yyy);
          String ss = selectMarketList.value.symbol;
          if (callMarketClose.symbol == ss) {
            close.value = double.parse(callMarketClose.close ?? '0').toStringAsFixed(int.parse(selectMarketList.value.decimal));
            persentageValue.value = double.parse(callMarketClose.percentChange!);
            update();
          }
          print('❌ Invalid ticker data type: ${tickerData.runtimeType}');




        _handleTicker(yyy);
      }
      } catch (error, stackTrace) {
        print('❌ Ticker Error');
        print(error);
        print(stackTrace);
      }
    });
  }


  // void _registerTickerListener(
  //     String channelName,
  //     ) {
  //   if (socket == null) return;
  //
  //   const eventName =
  //       'App\\Events\\Binance\\GetTicker';
  //
  //   socket!.off(eventName);
  //
  //   socket!.on(eventName, (dynamic e) {
  //     try {
  //       print('📈 Ticker Event');
  //       print(e);
  //
  //       if (!e['isWallet']) {
  //         // selectMarketList.value.balanceOne=e['BalanceOne'];
  //         // selectMarketList.value.balanceTwo=e['BalanceTwo'].toString();
  //
  //         // selectMarketList.value.balanceOne="10.521";
  //         // updateBalance(e);
  //         if (e['id'] == selectMarketList.value.id) {
  //           Map<String, dynamic> data = {
  //             "id": e['id'],
  //             "marketId": selectMarketList.value.id,
  //             "icon": selectMarketList.value.icon,
  //             "symbol": selectMarketList.value.symbol,
  //             "price": selectMarketList.value.price,
  //             "decimal": selectMarketList.value.decimal,
  //             "percent": selectMarketList.value.percent,
  //             "BalanceOne": e['BalanceOne'],
  //             "BalanceTwo": e['BalanceTwo'],
  //           };
  //           DataMarket dataMarketList = DataMarket.fromMap(data);
  //           selectCurrency(dataMarketList);
  //           getOrder.value = false;
  //           update();
  //           updateAfterTrade(dataMarketList);
  //           updateOrder(dataMarketList);
  //         } else {
  //           print('Currencyyyyy9 :${e['id'].toString()}');
  //           Map<String, dynamic> data = {
  //             "id": selectMarketList.value.id,
  //             "marketId": selectMarketList.value.id,
  //             "icon": selectMarketList.value.icon,
  //             "symbol": selectMarketList.value.symbol,
  //             "price": selectMarketList.value.price,
  //             "decimal": selectMarketList.value.decimal,
  //             "percent": selectMarketList.value.percent,
  //             "BalanceOne": selectMarketList.value.balanceOne,
  //             "BalanceTwo": e['BalanceTwo'],
  //             // "BalanceTwo": "10.255",
  //           };
  //           print('Currencyyyyy8 >>>>>> ${data.toString()}');
  //           DataMarket dataMarketList = DataMarket.fromMap(data);
  //           selectCurrency2(dataMarketList);
  //           getOrder.value = false;
  //           update();
  //           updateAfterTrade(dataMarketList);
  //         }
  //       } else {
  //         // String currency = e['currency'];
  //         // String balanceOne = e['BalanceOne'].toString();
  //         // String irtPrice = e['BalanceTwo'].toString();
  //         //
  //         // // double balanceOne=10;
  //         // // double irtPrice=2300;
  //         //
  //         // // double irtPrice=2.0;
  //         // Get.find<AssetsController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice));
  //         // Get.find<TradeController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice));
  //         // Get.find<TradeDrawerController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice));
  //         // prt(balanceOne.toString() + ":::::" + irtPrice.toString());
  //         String currency = e['currency'];
  //         String balanceOne = e['BalanceOne'].toString();
  //         String irtPrice = e['irtPrice'].toString();
  //         String xcxc = e['irtPrice'].toString();
  //
  //         // double balanceOne=10;
  //         // double irtPrice=2300;
  //
  //         // double irtPrice=2.0;
  //         // Get.find<AssetsController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice), 0.0);
  //         // Get.find<TradeController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice));
  //         // Get.find<TradeDrawerController>().changeBalance(currency, double.parse(balanceOne), double.parse(irtPrice));
  //         // prt(balanceOne.toString() + ":::::" + irtPrice.toString());
  //       }
  //
  //
  //
  //
  //       // _handleTicker(e);
  //
  //     } catch (error, stackTrace) {
  //       print('❌ Ticker Error');
  //       print(error);
  //       print(stackTrace);
  //     }
  //   });
  // }

  void _handleTicker(dynamic e) {
    try {
      dynamic decoded;

      if (e is String) {
        decoded = jsonDecode(e);
      } else {
        decoded = e;
      }

      Map<String, dynamic> data =
      Map<String, dynamic>.from(decoded);

      CallMarketClose callMarketClose =
      CallMarketClose.fromJson(data);

      String currentSymbol =
          selectMarketList.value.symbol;

      if (callMarketClose.symbol ==
          currentSymbol) {
        close.value =
            double.parse(
              callMarketClose.close ?? '0',
            ).toStringAsFixed(
              int.parse(
                selectMarketList.value.decimal,
              ),
            );

        persentageValue.value =
            double.parse(
              callMarketClose.percentChange ??
                  '0',
            );



        update();
      }

    } catch (e, stackTrace) {
      print('❌ Handle Ticker Error');
      print(e);
      print(stackTrace);
    }
  }



  UserSource userSource = UserSource(baseUrl: Core.uri);
}
