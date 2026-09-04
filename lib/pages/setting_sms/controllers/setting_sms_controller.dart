import 'package:flutter/material.dart';

import '../../../utils/core.dart';
import '../../../webazin/utilities.dart';

class SettingSmsController extends GetxController {
  UserSource userSource = UserSource(baseUrl: Core.uri);
  final user = DataUser().obs;

  final googleCode = ''.obs;
  final selectedThemeMode = ThemeMode.light.obs;

  final isLoading = false.obs;

  SettingSmsController() {}

  void setIsLoading(final bool _isLoading) {
    isLoading.value = _isLoading;
    update();
  }

  final isSMSVerify = false.obs;
  final isEmailVerify = false.obs;
  final isGoogleVerify = false.obs;
  final isNoneVerify = false.obs;

  @override
  void onInit() async {
     getUser(
      action: () => update(),
    );
    super.onInit();
  }

  void getUser({required final VoidCallback action})  {
    userSource.readUser(
      onResponse: (response) {
        Core.user = response.data!;
        user.value = response.data!;
        String twoFactorType = user.value.setting!.twoFactorType!;
        twoFactorType == "sms"
            ? isSMSVerify.value = true
            : twoFactorType == "email"
                ? isEmailVerify.value = true
                : twoFactorType == "google"
                    ? isGoogleVerify.value = true
                    : isNoneVerify.value = true;

        update();
        action();
      },
        onError: (response) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: response.message);
        },
        failure: (error) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: 'Error in receiving user information'.tr);
        },
    );
    update();
  }

  //changeSmsVerifyStatusGooglefff
  void changeVerifyStatus(String status) {
    if (status == 'sms') {
      isEmailVerify.value = false;
      isGoogleVerify.value = false;
      isSMSVerify.value = !isSMSVerify.value;
      smsLoginStatus();
    } else if (status == 'email') {
      isSMSVerify.value = false;
      isGoogleVerify.value = false;
      isEmailVerify.value = !isEmailVerify.value;
      emailLoginStatus();
    } else if (status == 'google') {
      isSMSVerify.value = false;
      isEmailVerify.value = false;
      isGoogleVerify.value = !isGoogleVerify.value;
    }
    update();
  }

  void setVerifyStatus(String status) {
    if (status == 'sms') {
      isEmailVerify.value = false;
      isGoogleVerify.value = false;
      isSMSVerify.value = true;
    } else if (status == 'email') {
      isSMSVerify.value = false;
      isGoogleVerify.value = false;
      isEmailVerify.value = true;
    } else if (status == 'google') {
      isSMSVerify.value = false;
      isEmailVerify.value = false;
      isGoogleVerify.value = true;
    } else {
      isSMSVerify.value = false;
      isEmailVerify.value = false;
      isGoogleVerify.value = false;
    }
    update();
  }

  void setIsSwitchedGoogle(final bool _isGoogleVerify) {
    isGoogleVerify.value = _isGoogleVerify;
    update();
  }

  void sendCode(final BuildContext context) {
    update();
  }

  Future<void> smsLoginStatus() async {
    try {
      showLoading();
      userSource.smsLoginStatus(
        status: isSMSVerify.value ? 1 : 0,
        onResponse: (response) {
          Core.user = response.data!;
          user.value = response.data!;
          setVerifyStatus(response.data?.setting?.twoFactorType ?? '');
          snackbarGreen(title: 'Success'.tr, subtitle: response.message);
          dismissLoading();
        },
        onError: (onError) {
          setVerifyStatus(user.value.setting?.twoFactorType ?? '');
          snackbarRed(title: 'Error'.tr, subtitle: onError.message);
          dismissLoading();
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + " User".tr);
          dismissLoading();
        },
      );
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      dismissLoading();
    }
  }

  Future<void> emailLoginStatus() async {
    try {
      showLoading();

      userSource.emailLoginStatus(
        status: isEmailVerify.value ? 1 : 0,
        onResponse: (response) {
          user.value = response.data!;
          Core.user = user.value;
          setVerifyStatus(response.data?.setting?.twoFactorType ?? '');
          snackbarGreen(title: 'Success'.tr, subtitle: response.message);
          dismissLoading();
        },
        onError: (onError) {
          setVerifyStatus(user.value.setting?.twoFactorType ?? '');
          snackbarRed(title: 'Error'.tr, subtitle: onError.message);
          dismissLoading();
        },
        failure: (error) {
          snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + " User".tr);
          dismissLoading();
        },
      );
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
      debugPrint(e.toString());
      dismissLoading();
    }
  }

  Future<void> g2fLoginStatus() async {
    showLoading();

    userSource.gtfLoginStatus(
      status: isGoogleVerify.value ? 1 : 0,
      code: googleCode.value,
      onResponse: (response) {
        user.value = response.data!;
        Core.user = user.value;
        setVerifyStatus(response.data?.setting?.twoFactorType ?? '');
        snackbarGreen(title: 'Success'.tr, subtitle: response.message);
        dismissLoading();
      },
      onError: (onError) {
        // setVerifyStatus(user.value.setting?.twoFactorType ?? '');
        snackbarRed(title: 'Error'.tr, subtitle: onError.message);
        dismissLoading();
      },
      failure: (error) {
        snackbarRed(title: 'Error'.tr, subtitle:'Error in receiving information '.tr + " User".tr);
        dismissLoading();
      },
    );
  }

  getQrCode(String qrAddress) {
    DataUser dataUser = Core.user;
    String qrCode = 'otpauth://totp/${dataUser.email}?secret=${qrAddress}&issuer=${Core.appName}';

    return qrCode;
  }
}
