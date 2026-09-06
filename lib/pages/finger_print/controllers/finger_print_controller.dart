import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:webazin/routes/app_routes.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/utilities.dart';

class FingerPrintController extends GetxController {
  late LocalAuthentication auth = LocalAuthentication();
  var canCheckBiometric = false.obs;

  var availableBiometric = <BiometricType>[].obs;
  var autherized = "Not autherized".obs;

  FingerPrintController() {}

  Future<void> checkBiometric() async {
    bool _canCheckBiometric = false;
    try {
      _canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    canCheckBiometric.value = _canCheckBiometric;
    update();
  }

  Future<void> getAvailableBiometrics() async {
    List<BiometricType> _availableBiometric = [];
    try {
      _availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }

    availableBiometric.value = _availableBiometric;
    update();
  }

  Future<void> authenticate() async {
    bool _authenticated = false;
    try {
      _authenticated = await auth.authenticate(
        localizedReason: 'Please enter your fingerprint'.tr,
        authMessages: <AuthMessages>[
          AndroidAuthMessages(
            cancelButton: "Cancel".tr,
            signInTitle: "Fingerprint scan".tr,
            // biometricHint: "",
          )
        ],
      );
    } on PlatformException catch (_) {
      // error = e.toString();
    }
    //if authorized is success
    autherized.value = _authenticated ? "Login successful".tr : "Login failed".tr;
    if (_authenticated) {
      showLoading();
      getApplicationInfo(
        action: () => getCurrencies(
          action: () =>  getBankNameList(
            action: () {
              dismissLoading();
              Get.offAndToNamed(Routes.ROOT);
            },
          ),

        ),
      );
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await checkBiometric();
    await getAvailableBiometrics();
    authenticate();
  }

/*---------------- BIO ---------------------*/
}
