import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:webazin/routes/app_routes.dart';
import 'package:webazin/utils/assets.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/utils/ui.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class Splash2View extends StatefulWidget {
  @override
  _Splash2ViewState createState() => _Splash2ViewState();
}

class _Splash2ViewState extends State<Splash2View> with WidgetsBindingObserver {
  UserSource userSource = UserSource(baseUrl: Core.uri);

  late VideoPlayerController videoController;

  LocalAuthentication auth = LocalAuthentication();
  RxBool canCheckBiometric = false.obs;
  RxList<BiometricType> availableBiometric = <BiometricType>[].obs;
  RxString autherized = "Not autherized".obs;

  int progress = 0;

  bool isError = false;

  bool isInternetDisconnect = false;
  String errorText = 'Check your internet'.tr;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    playVideo();

    getAppInfo(action: () {
      if (isLogin()) {
        getUser(
            action: () => getBankNameList(
                action: () => getCurrencies(
                      action: () => getBankNameList(
                        action: () {
                          checkBiometric(
                            action: (canCheckBiometric) {
                              Core.canCheckBiometric = canCheckBiometric;
                              if (canCheckBiometric) {
                                if (getBool (Core.fingerPrintEnable)) {
                                  Get.offAndToNamed(Routes.FINGERPRINT);
                                } else {
                                  Get.offAndToNamed(Routes.ROOT);
                                }
                              } else {
                                Get.offAndToNamed(Routes.ROOT);
                              }
                            },
                          );
                        },
                      ),
                    )));
      } else {
        Get.offAndToNamed(Routes.LOGIN);
      }
    });

    super.initState();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.dispose();
  }

  void playVideo() {
    videoController = VideoPlayerController.asset(Assets.splashVid)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {
          videoController.seekTo(Duration(seconds: 0));
          videoController.play();
        });
      });
  }

  void initBiometric() {
    checkBiometric(
      action: (canCheckBiometric) {
        if (canCheckBiometric) {
          this.canCheckBiometric.value = canCheckBiometric;
          getAvailableBiometrics(
            action: (listBiometricType) {
              this.availableBiometric.value = listBiometricType;
            },
          );
        } else {}
      },
    );
  }

  void checkMyInternet() {}

  Future<void> checkBiometric({required Function(bool canCheckBiometric) action}) async {
    bool _canCheckBiometric = false;
    try {
      _canCheckBiometric = await auth.canCheckBiometrics;
      action(_canCheckBiometric);
    } on PlatformException catch (_) {}
  }

  Future<void> getAvailableBiometrics({required Function(List<BiometricType> listBiometricType) action}) async {
    List<BiometricType> _availableBiometric = <BiometricType>[];
    try {
      _availableBiometric = await auth.getAvailableBiometrics();
      action(_availableBiometric);
    } on PlatformException catch (_) {
      // error = e.toString();
    }
  }

  // void getUser({required final VoidCallback action}) {
  //   userSource.readUser(
  //     onResponse: (response) {
  //       Core.user = response.data!;
  //       action();
  //     },
  //     onError: (response) {
  //       toast(response.message);
  //       setState(() {
  //         isInternetDisconnect = true;
  //       });
  //     },
  //     failure: (error) {
  //       setState(() {
  //         isInternetDisconnect = true;
  //       });
  //     },
  //   );
  // }

  void getAppInfo({required VoidCallback action}) {
    getApplicationInfo(
      action: () {
        DataApplicationInfo? data = Core.applicationInfo;
        if (data != null) {
          int version = int.parse(data.version!);
          if (version > Core.VERSIONCODE) {
            Future.delayed(Duration.zero, () {
              showDialog(
                  context: context,
                  builder: (final BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return AlertDialog(
                          backgroundColor: Colors.transparent,
                          contentPadding: EdgeInsets.zero,
                          titlePadding: EdgeInsets.zero,
                          content: Center(
                            child: Container(
                              width: 300,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: <BoxShadow>[BoxShadow(color: Get.theme.dividerColor.withOpacity(0.3), blurRadius: 40, offset: Offset(0, 15)), BoxShadow(color: Get.theme.dividerColor.withOpacity(0.2), blurRadius: 13, offset: Offset(0, 3))],
                                color: Get.theme.scaffoldBackgroundColor,
                              ),
                              child: WillPopScope(
                                onWillPop: () async => false,
                                child: Container(
                                  decoration: BoxDecoration(color: Get.theme.scaffoldBackgroundColor, borderRadius: BorderRadius.circular(16)),
                                  height: 400,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        width: double.infinity,
                                        height: 130,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                Assets.updateImg,
                                              ),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          data.title!,
                                          style: TextStyle(color: Get.theme.dividerColor, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: FontFamily.vazirBold),
                                        ),
                                      ).marginOnly(top: 8),
                                      Flexible(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                            top: 16,
                                            left: 16,
                                            right: 16,
                                          ),
                                          height: double.infinity,
                                          child: Column(
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  padding: EdgeInsets.all(8),
                                                  height: double.infinity,
                                                  child: SingleChildScrollView(
                                                    child: Ui.removeHtml(data.description!,
                                                        style: TextStyle(
                                                          fontFamily: FontFamily.vazirBold,
                                                          fontSize: 14,
                                                          color: Get.theme.dividerColor.withOpacity(0.8),
                                                        )),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: <Widget>[
                                                  Text('${progress.toString()} %').marginSymmetric(horizontal: 8),
                                                  Expanded(
                                                    child: LinearPercentIndicator(
                                                      percent: double.parse(progress.toString()) / 100,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                height: 1,
                                                color: Get.theme.dividerColor.withOpacity(0.9),
                                              ),
                                              Container(
                                                height: 50,
                                                margin: const EdgeInsets.only(bottom: 8, top: 8),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () async {
                                                          await launch(data.link!);
                                                        },
                                                        child: Container(
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                              "Download".tr,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: FontFamily.vazirBold,
                                                                color: AppColors.orangeColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      height: 50,
                                                      width: 0.3,
                                                      color: Get.theme.dividerColor.withOpacity(0.3),
                                                    ),
                                                    Expanded(
                                                      child: InkWell(
                                                        onTap: () {
                                                          data.force! == "1" ? SystemChannels.platform.invokeMethod('SystemNavigator.pop') : action();
                                                        },
                                                        child: Container(
                                                          width: (MediaQuery.of(context).size.width / 3),
                                                          height: 50,
                                                          child: Center(
                                                            child: Text(
                                                              data.force! == "1" ? "Exit".tr : "later".tr,
                                                              style: TextStyle(
                                                                fontSize: 12,
                                                                fontFamily: FontFamily.vazirBold,
                                                                color: Get.theme.dividerColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  });
            });
          } else {
            action();
          }
        }
      },
    );
  }

  @override
  Widget build(final BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.splashColor,
        body: Directionality(
          textDirection: TextDirection.rtl,
          child: Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: Get.width - 50,
                  height: 650,
                  child: InkWell(
                    // onTap: () => playVideo(),
                    child: VideoPlayer(
                      videoController,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 20,
                left: 0,
                right: 0,
                child: isInternetDisconnect
                    ? Container(
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Text(
                              errorText,
                              style: TextStyle(
                                color: Get.theme.canvasColor,
                                fontFamily: FontFamily.vazirBold,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isInternetDisconnect = false;
                                  initState();
                                });
                              },
                              child: Container(
                                margin: const EdgeInsets.only(
                                  top: 16,
                                ),
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Get.theme.canvasColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'try again'.tr,
                                    style: TextStyle(
                                      color: context.theme.canvasColor//todo_selectedRowColor

                                      ,fontFamily: FontFamily.vazirBold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 100,
                        decoration: BoxDecoration(),
                        child: Column(
                          children: <Widget>[
                            Text(
                              'Please wait'.tr,
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: FontFamily.vazirBold,
                              ),
                            ),
                            SpinKitWave(color: Colors.red, size: 24, type: SpinKitWaveType.start).marginOnly(top: 16),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
