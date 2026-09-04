import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webazin/chart/pieChart/pie_chart_sample2.dart';
import 'package:webazin/pages/market/controllers/market_controller.dart';
import 'package:webazin/pages/portfolio/controllers/portfolioController.dart';
import 'package:webazin/pages/qr_view_reader.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class AssetsController extends GetxController {
  AssetsController();

  WalletSource walletSource = WalletSource(baseUrl: Core.uri);
  ScrollController scrollController = ScrollController();

  final RxBool isDone = false.obs;
  final RxInt page = 0.obs;

  final isLoading = true.obs;
  final isLoadingList = false.obs;
  final isSearching = false.obs;

  final Rx<TextEditingController> tecParamSearch = TextEditingController().obs;

  late Timer timer;
  late Timer timer2;

  final RxList<DataWallet> assets = <DataWallet>[].obs;
  final RxList<String> typeList = <String>[].obs;
  final Rx<DataWallet> assetsIRT = DataWallet().obs;
  final RxString myIrt = ''.obs;
  final RxString myUsd = ''.obs;

  // final assets2 = <DataWallet>[].obs;
  // final callAssets = CallAssets().obs;
  // final callAssetsIrt = CallAssets().obs;
  // final callWithdrawalIRT = CallWithdrawalIRT().obs;
  final RxList<String> spinnerItems = <String>[].obs;
  final RxInt currentSlide = 0.obs;
  final RxBool isAllAssets = true.obs;

  final FocusNode focusPrice = FocusNode();
  final RxInt price = 0.obs;

  final RxString currentStatus = '1'.obs;
  final RxString selectLimit = ''.obs;
  final RxDouble quantity = 10.00.obs;
  final RxDouble total = 251.122.obs;
  final Rx<TextEditingController> tTag = TextEditingController().obs;
  final Rx<TextEditingController> tWallet = TextEditingController().obs;
  final Rx<TextEditingController> tTXID = TextEditingController().obs;
  final TextEditingController c1 = TextEditingController();
  final TextEditingController tecQuantity = TextEditingController();
  final TextEditingController tecTotal = TextEditingController();

  final FocusNode focusWallet = FocusNode();
  final FocusNode focusCount = FocusNode();

  final RxInt selectTypeIndex = 0.obs;
  final RxInt selectNetworksIndex = 0.obs;
  final RxString cartBankValue = 'One'.obs;
  final RxBool isAcceptWarning = false.obs;

  final RxList<DataCards> cardList = <DataCards>[].obs;
  final RxBool cardListDone = false.obs;
  final Rx<DataCards> selectCard = DataCards().obs;

  final RxBool isDismissible = false.obs;
  final RxBool isVisibleCash = false.obs;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = <TargetFocus>[];
  GlobalKey keyButton1 = GlobalKey();

  RxList<PieChartModel> listChartModel = <PieChartModel>[].obs;

  @override
  Future<void> onInit() async {
    update();
    typeList.assignAll(['Direct transfer'.tr, 'Internal transfer'.tr]);
    update();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent && !isDone.value) {
        if (assets.length > 5) {
          getAssets();
        }
      }
    });
    await refreshHome();
    super.onInit();
  }


  void warningDialog({required VoidCallback action, required String description, String? title}) => showDialog(
    context: Get.context!,
    builder: (final BuildContext context) => AlertDialog(
      content: SizedBox(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(
                  Icons.warning_rounded,
                  size: 64,
                  color: Colors.red,
                ),
                Text(
                  title ?? 'Error'.tr,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              description,
              style: TextStyle(fontWeight: FontWeight.w400),
            ),
            Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Obx(() {
                    return Checkbox(
                      value: isAcceptWarning.value,
                      onChanged: (newValue) {
                        isAcceptWarning(!isAcceptWarning.value);
                      },
                    );
                  }),
                  Text(
                    'I read and understood'.tr,
                    style: TextStyle(fontSize: 12, fontFamily: FontFamily.vazirBold),
                  )
                ],
              ),
            ),
            InkWell(
              onTap: () {
                if (isAcceptWarning.value) {
                  Get.back();
                  action();
                }
              },
              child: Text(
                "Confirm".tr,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            )
          ],
        ),
      ),
    ),
  );


  void showTutorial(final BuildContext context) {
    initTargets(context);
    tutorialCoachMark = TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.blueGrey,
      textSkip: "I know".tr,
      textStyleSkip: TextStyle(
        fontSize: 20,
        color: AppColors.orangeColor,
        fontFamily: FontFamily.vazirBold,
      ),
      paddingFocus: 1,
      onFinish: () {
        setData(Core.helperAsset, true);
      },
      onClickTarget: (final TargetFocus target) {
        debugPrint('onClickTarget: $target');
      },
      onClickTargetWithTapPosition: (final TargetFocus target, final TapDownDetails tapDetails) {
        debugPrint("target: $target");
        debugPrint("clicked at position local: ${tapDetails.localPosition} - global: ${tapDetails.globalPosition}");
      },
      onClickOverlay: (final TargetFocus target) {
        debugPrint('onClickOverlay: $target');
      },
      onSkip: () {
        setData(Core.helperAsset, true);
        return false;
      },
    )..show(context: context);
  }

  void initTargets(final BuildContext context) {
    targets.clear();

    targets.add(
      TargetFocus(
        identify: "Wallet".tr, //
        shape: ShapeLightFocus.RRect,
        keyTarget: keyButton1,
        contents: <TargetContent>[
          TargetContent(
            align: ContentAlign.top,
            builder: (final BuildContext context, final TutorialCoachMarkController controller) => Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Wallet".tr,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: FontFamily.vazirBold,
                    color: Colors.red,
                    fontSize: 20,
                  ),
                ).marginOnly(top: 32),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(
                    "This option will show the number of available and withdrawable currencies".tr,
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: FontFamily.vazirBold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Center(
                    child: Image.asset(
                  Assets.arrow4,
                  width: 50,
                  height: 50,
                  color: Colors.yellow,
                ))
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> refreshHome({final bool showMessage = false, final String? statusId}) async {
    if (!isSearching.value) {
      page.value = 0;
      assets.clear();
      isLoading(true);
      getParam();
      await getAssets();
    } else {
      // Future<bool>.delayed(const Duration(seconds: 10),()=> state.loaded,);
    }

    if (showMessage) {
      // Get.showSnackbar(Ui.SuccessSnackBar(message: "Home page refreshed successfully".tr));
    }
  }

  visibleCash() {
    isVisibleCash.value = !isVisibleCash.value;
    update();
  }

  void selectIndexCard(final DataCards dataCards) {
    selectCard.value = dataCards;
    update();
  }

  // ignore: avoid_positional_boolean_parameters
  void setIsSwitched(final bool isSwitched) {
    Get.find<MarketController>().sellOrder2(context);
    isAllAssets.value = isSwitched;
    page.value = 0;
    assets.clear();

    isLoading(true);
    getAssets();
    update();
  }

  void selectCartBank(final String value) {
    cartBankValue.value = value;
    update();
  }

  // ignore: avoid_positional_boolean_parameters
  void setCount(final bool isPlus) {
    double r = double.parse(tecQuantity.text);

    if (isPlus) {
      r++;
    } else {
      r--;
    }

    tecQuantity.text = r.toString();
    update();
  }

  void setChangetPrice(final String param) {
    price.value = int.parse(param.replaceAll(",", ""));
    debugPrint(price.value.toString());
    update();
  }

  void updateNetworkIndex(final int index) {
    selectNetworksIndex.value = index;

    update();
  }

  void updateTypeIndex(final int index) {
    selectTypeIndex.value = index;
    print(index);

    update();
  }

  Future<void> scanWalletQrCode(final BuildContext context) async {
    final PermissionStatus camPermission = await Permission.camera.status;
    if (camPermission.isGranted) {
      final String? cameraScanResult = await Get.to(const QRViewReader());
      tWallet.value.text = cameraScanResult ?? '';
      update();
    } else {
      final PermissionStatus isCameraGreate = await Permission.camera.request();
      if (isCameraGreate.isPermanentlyDenied) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Please give access to the camera through the application settings'.tr);
      }
    }
  }

  Future<void> scanTagQrCode(final BuildContext context) async {
    final PermissionStatus camPermission = await Permission.camera.status;
    if (camPermission.isGranted) {
      final cameraScanResult = await Navigator.push(
        context,
        MaterialPageRoute(builder: (final BuildContext context) => const QRViewReader()),
      );
      tTag.value.text = cameraScanResult;
      update();
    } else {
      final PermissionStatus isCameraGreate = await Permission.camera.request();
      if (isCameraGreate.isPermanentlyDenied) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Please give access to the camera through the application settings'.tr);
      }
    }
  }

  Future<void> scanTxidQrCode(final BuildContext context) async {
    final PermissionStatus camPermission = await Permission.camera.status;
    if (camPermission.isGranted) {
      final cameraScanResult = await Navigator.push(
        context,
        MaterialPageRoute(builder: (final BuildContext context) => const QRViewReader()),
      );
      tTXID.value.text = cameraScanResult;
      update();
    } else {
      final PermissionStatus isCameraGreate = await Permission.camera.request();
      if (isCameraGreate.isPermanentlyDenied) {
        snackbarRed(title: 'Error'.tr, subtitle: 'Please give access to the camera through the application settings'.tr);
      }
    }
  }

  Future getAssets() async {
    if (!isSearching.value) {
      if (isAllAssets.value) {
        await getAssetsAll();
      } else {
        await getAssetsFilter();
      }
    } else {
      delay(8000, () {
        isSearching(false);
      });
    }
  }

  Future getAssetsAll() async {
    try {
      isDone(false);
      page.value++;
      isSearching(true);
      await walletSource.read(
        page: page.value,
        perPage: Core.perPage,
        search: tecParamSearch.value.text,
        onResponse: (final GenericResponse<DataWallet> response) {
          myIrt(response.meta?.irt ?? '0');
          myUsd(response.meta?.usd ?? '0');
          if (response.dataList!.isNotEmpty) {
            assets.addAll(response.dataList ?? []);
            listChartModel.clear();
            double tTotalPrice = 0;
            for (int i = 0; i < assets.length; i++) {
              DataWallet model = assets[i];
              if (model.balanceFree! > 0 && (model.currency?.symbol ?? '') != 'IRT') {
                double p1 = (model.balanceFree ?? 0.0);
                double p2 = (model.currency?.price ?? 0);
                double totalPrice = p1 * p2;
                tTotalPrice = tTotalPrice + totalPrice;
              }
            }

            List<PieChartModel> vals = [];

            for (int i = 0; i < assets.length; i++) {
              // for (int i = 0; i < 5; i++) {
              DataWallet model = assets[i];
              if (model.balanceFree! > 0 && (model.currency?.symbol ?? '') != 'IRT') {
                double totalPrice = (model.balanceFree ?? 0.0) * (model.currency?.price ?? 0);
                double p = (100 / (double.parse(myUsd.value) / totalPrice));
                vals.add(PieChartModel(
                  values: p,
                  color: model.currency?.color ?? '',
                  title: model.currency!.symbol ?? '',
                ));
              }
            }

            vals.sort((a, b) {
              var adate = a.values; //before -> var adate = a.expiry;
              var bdate = b.values; //before -> var bdate = b.expiry;
              return bdate.compareTo(adate); //to get the order other way just switch `adate & bdate`
            });

            print('ok');
            double tVals = 0;
            for (int i = 0; i < vals.length; i++) {
              tVals = tVals + vals[i].values;
            }

            for (int i = 0; i < vals.length; i++) {
              PieChartModel data = vals[i];

              if (i < Core.pieChartHomeLimit) {
                tVals = tVals - vals[i].values;
                double values = double.parse(vals[i].values.toStringAsFixed(Core.pieChartHomeDecimalLimit));
                PieChartModel pieChartModel = PieChartModel(
                  values: values,
                  color: data.color,
                  title: data.title,
                );
                listChartModel.add(pieChartModel);
              } else {
                if (i == vals.length - 1) {
                  PieChartModel pieChartModel = PieChartModel(
                    values: double.parse(tVals.toStringAsFixed(Core.pieChartHomeDecimalLimit)),
                    color: data.color,
                    title: 'Other',
                  );
                  listChartModel.add(pieChartModel);
                }
              }
            }

            update();
          } else {
            isDone.value = true;
          }

          isSearching(false);
          isLoading(false);
          update();
        },
        onError: (final GenericResponse errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          isSearching(false);
          isLoading(false);
          isDone(true);
          update();
        },
        failure: (final String error) {
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving information '.tr + 'Wallet'.tr);
          isSearching(false);
          isLoading(false);
          isDone(true);
          update();
        },
      );
    } catch (e) {
      isDone(true);
    } finally {
      // state.loaded();
      // action();
    }
  }

  Future getAssetsFilter() async {
    try {
      isDone(false);
      page.value++;
      isSearching(true);
      await walletSource.read(
        page: page.value,
        perPage: Core.perPage,
        search: tecParamSearch.value.text,
        isFilter: true,
        onResponse: (final GenericResponse<DataWallet> response) {
          if (response.dataList!.isNotEmpty) {
            isSearching(false);
            assets.addAll(response.dataList!);
            // for (int i = 0; i < response.dataList!.length; i++) {
            // for (int i = 0; i < 5; i++) {
            //   DataWallet model = response.dataList![i];
            //   PieChartModel pieChartModel = PieChartModel(
            //     values: 3.0,
            //     color: model.currency?.color ?? '',
            //     title: model.currency!.symbol ?? '',
            //   );
            //   listChartModel.add(pieChartModel);
            // }
          } else {
            isDone.value = true;
          }
          isSearching(false);
          isLoading(false);
          update();
        },
        onError: (final GenericResponse errorResponse) {
          snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
          isSearching(false);
          isLoading(false);
          isDone(true);
          update();
        },
        failure: (final String error) {
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving information '.tr + 'Wallet'.tr);
          isSearching(false);
          isLoading(false);
          isDone(true);
          update();
        },
      );
    } catch (e) {
      isDone(true);
    } finally {
      // state.loaded();
      // action();
    }
  }

  var isChange = true.obs;

  Future changeBalance(final String symbol, final double balanceOne, final double irtPrice, double? value) async {
    update();
    for (int i = 0; i < assets.length; i++) {
      final DataWallet dataAssets = assets[i];
      if (dataAssets.currency!.symbol == symbol) {
        isChange(false);
        update();
        assets[i].currency!.irtPrice = irtPrice;
        assets[i].balance = balanceOne;
        isChange(true);
        update();
      }
    }

    if (value != null) {
      for (int i = 0; i < listChartModel.length; i++) {
        final PieChartModel pieChartModel = listChartModel[i];
        if (pieChartModel.title == symbol) {
          isChange(false);
          update();
          listChartModel[i].values = value;
          isChange(true);
          update();
        }
      }
    }
  }

  void resetSearch() {
    tecParamSearch.value.text = "";
    update();
    refreshHome();
  }

  Future depositCurrency(final DataWallet dataAssets) async {
    try {
      if (tecQuantity.text.length > 0) {
        if (tTXID.value.text.length > 3) {
          if (!EasyLoading.isShow) {
            showLoading();
            walletSource.depositCurrency(
              symbol: dataAssets.currency!.symbol ?? '',
              txid: tTXID.value.text,
              onResponse: (response) async {
                dismissLoading();
                refreshHome(showMessage: false);

                await Get.find<PortfolioController>().refreshHome();
                update();
                Get.back();
                snackbarGreen(title: 'Success'.tr, subtitle: response.message);
              },
              onError: (errorResponse) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
              },
              failure: (error) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: 'Error in currency deposit'.tr);
              },
            );
          }
        } else {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: "TXID is not true".tr);
        }
      } else {
        dismissLoading();
        snackbarRed(title: 'Error'.tr, subtitle: "Quantity is not true".tr);
      }
    } catch (e) {
      dismissLoading();
    }
  }

  Future withdrawalCurrency(DataWallet dataWallet) async {
    try {
      if (tecQuantity.text.length > 0) {
        if (tWallet.value.text.length > 0) {
          if (!EasyLoading.isShow) {
            showLoading();
            walletSource.withdrawalCurrency(
              symbol: dataWallet.currency?.symbol ?? '',
              qty: tecQuantity.text,
              wallet: tWallet.value.text,
              internal: selectTypeIndex.value,
              network: dataWallet.currency?.networks?[selectNetworksIndex.value].network ?? '',
              tag: tTag.value.text,
              onResponse: (response) async {
                await Get.find<PortfolioController>().refreshHome();
                dismissLoading();
                refreshHome(showMessage: false);
                update();
                Get.back();
                snackbarGreen(title: 'Success'.tr, subtitle: response.message);
              },
              onError: (errorResponse) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
              },
              failure: (error) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: 'Error in currency deposit'.tr);
              },
            );
          }
        } else {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: 'Wallet is not true'.tr);
        }
      } else {
        dismissLoading();
        snackbarRed(title: 'Error'.tr, subtitle: 'Quantity is not true'.tr);
      }
    } catch (e) {
      dismissLoading();
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    }
  }

  Future depositIRT() async {
    if (!EasyLoading.isShow) {
      try {
        if (c1.text.length > 3) {
          showLoading();

          walletSource.depositIrt(
            price: c1.text.replaceAll(",", ""),
            onResponse: (response) async {
              await launch(response.dataList?.first ?? '');
              snackbarGreen(title: 'Error'.tr, subtitle: response.message);
              dismissLoading();
              Get.back();
              snackbarGreen(title: 'Success'.tr, subtitle: response.message);
            },
            onError: (errorResponse) {
              snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
              dismissLoading();
            },
            failure: (error) {
              snackbarRed(title: 'Error'.tr, subtitle: 'Error in payment'.tr);
              dismissLoading();
            },
          );
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: "Amount is not true".tr);
          dismissLoading();
        }

        update();
      } catch (e) {
        dismissLoading();
        // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      }
    }
  }

  // void setLoading (final bool _isLoading) {
  //   Future.delayed(Duration(seconds: 15), () {
  //     isLoading.value = false;
  //     update();
  //   });
  //   isLoading.value = _isLoading;
  //   isDismissible.value = _isLoading;
  //   update();
  // }

  Future<void> withdrawalIRT() async {
    if (!EasyLoading.isShow) {
      if (c1.text.length > 0) {
        if (selectCard.value != null && selectCard.value.id != null) {
          showLoading();
          walletSource.withdrawalIrt(
            price: c1.text.replaceAll(",", ""),
            cardId: (selectCard.value.id ?? 0).toString(),
            onResponse: (response) async {
              await Get.find<PortfolioController>().refreshHome();
              snackbarGreen(title: 'Success'.tr, subtitle: response.message);
              dismissLoading();
              Get.back();
              snackbarGreen(title: 'Success'.tr, subtitle: response.message);
            },
            onError: (errorResponse) {
              dismissLoading();
              snackbarRed(title: 'Error'.tr, subtitle: errorResponse.message);
            },
            failure: (error) {
              dismissLoading();
              snackbarRed(title: 'Error'.tr, subtitle: 'Error in withdrawal'.tr);
            },
          );

          // Get.back();
        } else {
          snackbarOrange(title: 'Error'.tr, subtitle: 'Please select your bank card'.tr);
        }
      }
    }
  }

  void getParam() {
    cardList.addAll(Core.user.cards ?? []);
    if (cardList.isNotEmpty) {
      selectCard.value = cardList.first;
    }
    c1.text = price.toString();
    tecQuantity.text = quantity.toString();
    tecTotal.text = total.toString();
    update();
  }

  void setQuantity(final bool isPlus) {
    if (isPlus) {
      quantity.value++;
    } else {
      quantity.value--;
    }
    tecQuantity.text = quantity.toString();
    update();
  }

  void setTotal(final bool isPlus) {
    if (isPlus) {
      total.value++;
    } else {
      total.value--;
    }
    tecTotal.text = total.toString();
    update();
  }
}
