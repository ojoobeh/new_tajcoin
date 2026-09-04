import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/models/parents/statistic.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../utils/assets.dart';

import 'package:webazin/utils/utils.dart';

class HomeController extends GetxController with WidgetsBindingObserver {
  late BuildContext context;
  bool isShowDialog = false;
  late NetworkImage imageNetwork;

  final statistics = <Statistic>[].obs;
  final currencies = <DataCurrency>[].obs;
  final currentSlide = 0.obs;

  final isLoading = true.obs;
  final isLoading2 = false.obs;
  final isHomeLoaded = true.obs;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButton1 = GlobalKey();

  HomeController() {}

  Future<void> getPopup() async {
    imageNetwork = await NetworkImage(Core.applicationInfo.popup?.image ?? '');
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      // update();
      // debugPrint('Resume Called');
    }
  }

  setChangeThem (final bool isChange) {
    isHomeLoaded.value = true;
    update();
  }

  void showTutorial(final BuildContext context) {
    initTargets(context);
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.blueGrey,
      textSkip: "I understand".tr,
      textStyleSkip: TextStyle(
        fontSize: 20,
        color: AppColors.orangeColor,
        fontFamily: FontFamily.vazirBold,
      ),
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        setData('${Core.helperHome}', true);
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
        setData('${Core.helperHome}', true);
        return false;
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
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "More...",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: FontFamily.vazirBold,
                        color: Colors.red,
                        fontSize: 20.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Text(
                        "By clicking on this option, you will have access to all the features of the application".tr,
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: FontFamily.vazirBold,
                          fontSize: 16,
                        ),
                      ),
                    ).marginOnly(bottom: 32),
                    Center(
                        child: Image.asset(
                      Assets.arrow1,
                      width: 100,
                      height: 100,
                      color: Colors.yellow,
                    ))
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Future<void> onInit() async {
    // connectToServer();

    WidgetsBinding.instance.addObserver(this);

    await refreshHome();
    super.onInit();
  }

  Future refreshHome({bool showMessage = false, String? statusId}) async {
    if (!isLoading2.value) {
      currencies.assignAll(Core.currencies);
      update();
    } else {
      snackbarGreen(title: ''.tr, subtitle: 'Please wait'.tr);
    }
  }

  void setLoading (final bool _isLoading) {
    isLoading2.value = _isLoading;
    update();
  }

  // connectToServer() {
  //   try {
  //     // Create echo instance
  //     Echo echo = Echo({'broadcaster': 'socket.io', 'client': IO.io, 'host': Core.laravelBaseUrl2+':6003'});
  //
  //       echo.channel('exvmarket_database_ticker-update-channels')
  //           .listen('.App\\Events\\Binance\\GetTicker', (e) {
  //
  //       debugPrint("Update 10 "+">>>>>> Null");
  //       Map<String, dynamic> yy = e != null ? Map<String, dynamic>.from(e) : {};
  //       Map<String, dynamic> ll = yy['ticker'] != null ? Map<String, dynamic>.from(yy['ticker']) : {};
  //       String symbol = yy['symbol'];
  //       String symbol2 = ll['symbol'];
  //       String high = ll['high'];
  //       String low = ll['low'];
  //       String close = ll['close'];
  //       String volume = ll['volume'];
  //       String percentChange = ll['percentChange'];
  //       debugPrint("Update 11 "+">>>>>> "+symbol);
  //       updateCurrencies(symbol2, close, percentChange);
  //       update();
  //
  //       // e = {_InternalLinkedHashMap} size = 3
  //       // 0 = {map entry} "symbol" -> "BUSDUSDT"
  //       // 1 = {map entry} "ticker" -> [_InternalLinkedHashMap]
  //       // key = "ticker"
  //       // value = {_InternalLinkedHashMap} size = 6
  //       // 0 = {map entry} "symbol" -> "BUSDUSDT"
  //       // 1 = {map entry} "high" -> "0.99960000"
  //       // 2 = {map entry} "low" -> "0.99940000"
  //       // 3 = {map entry} "close" -> "0.99950000"
  //       // 4 = {map entry} "volume" -> "436612806.00000000"
  //       // 5 = {map entry} "percentChange" -> "0.000"
  //       // 2 = {map entry} "socket" -> null
  //       String param=e.toString();
  //       debugPrint(symbol+">>>>>>");
  //     });
  //
  //     // echo.channel('exvmarket_database_get-last-order-ETH-USDT').listen('.App\\Events\\Binance\\GetLastOrdersEvent', (e) {
  //     //
  //     //   // e = {_InternalLinkedHashMap} size = 3
  //     //   // 0 = {map entry} "symbol" -> "ETH-USDT"
  //     //   // 1 = {map entry} "trades" -> [_InternalLinkedHashMap]
  //     //   // key = "trades"
  //     //   // value = {_InternalLinkedHashMap} size = 5
  //     //   // 0 = {map entry} "symbol" -> "ETH-USDT"
  //     //   // 1 = {map entry} "T" -> "1645633302"
  //     //   // 2 = {map entry} "m" -> true
  //     //   // 3 = {map entry} "p" -> "2683.96"
  //     //   // 4 = {map entry} "q" -> "0.01"
  //     //   // 2 = {map entry} "socket" -> null
  //     //
  //     //   String param=e.toString();
  //     //   debugPrint(param);
  //     // });
  //     //
  //     echo.private('exvmarket_database_balance-Update-ETH-USDT-10').listen('.BalanceUpdate', (e) {
  //       String param=e.toString();
  //       debugPrint(param);
  //     });
  //
  //     echo.socket.on('connect', (_) => debugPrint('connected'));
  //     echo.socket.on('disconnect', (_) => debugPrint('disconnected'));
  //     update();
  //   } catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  void updateCurrencies(
    String symbol2,
    String close,
    String percentChange,
  ) {
    for (int i = 0; i < currencies.length; i++) {
      List<MarketElement> list = currencies[i].markets!;
      for (int i2 = 0; i2 < list.length; i2++) {
        MarketElement markets = list[i2];
        if (markets.symbol == symbol2) {
          currencies[i].markets![i2].setPrice(double.parse(close));
          debugPrint("UPDATE CURRENCY >> ${symbol2} >>> ${close}");
        }
      }
    }
    update();
  }
}
