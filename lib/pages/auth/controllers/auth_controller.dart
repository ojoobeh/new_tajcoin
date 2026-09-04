import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/remote_datasource/user_source.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../routes/app_routes.dart';
import '../../../services/firebase_messaging_service.dart';

class AuthController extends GetxController {
  UserSource userSource = UserSource(baseUrl: Core.uri);

  late TextEditingController rgNameController;
  late TextEditingController rgUserNameController;
  late TextEditingController rgEmailController;
  late TextEditingController rgNationalCodeController;
  late TextEditingController rgParentIdController;
  late TextEditingController rgPasswordController;
  late TextEditingController rgRePasswordController;
  late TextEditingController rgCodeController;

  // late var currentUser = DataUser().obs;

  late GlobalKey<FormState> loginFormKey;
  late GlobalKey<FormState> registerFormKey;
  late Timer _timer;

  final hidePassword = true.obs;
  final hideConfirmationPassword = true.obs;
  final smsSent = ''.obs;

  final isLoading = false.obs;
  final apiToken = ''.obs;
  final verifyCode = ''.obs;
  final verifyGoogleCode = ''.obs;

  var time = 0.obs;
  var maxTime = 60;

  String twoFactorType = "";
  String code = "";
  final email = ''.obs;
  final password = ''.obs;
  final rePassword = ''.obs;
  final parentId = ''.obs;

  String message = '';

  AuthController() {
    rgNameController = TextEditingController();
    rgUserNameController = TextEditingController();
    rgEmailController = TextEditingController();
    rgNationalCodeController = TextEditingController();
    rgParentIdController = TextEditingController();
    rgPasswordController = TextEditingController();
    rgRePasswordController = TextEditingController();
    rgCodeController = TextEditingController();
    debugPrint('AutheController');
  }

  @override
  void onInit() {
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> setLoading(final bool _isLoading) async {
    isLoading.value = _isLoading;
    update();
  }

  void login() async {
    try {
      // await Get.find<FireBaseMessagingService>().setDeviceToken();
      if (time.value < 1) {
        if (email.value.length > 3) {
          if (password.value.length > 4) {
            showLoading();
            userSource.login(
              dataUser: DataUser(
                email: email.value,
                password: password.value,
              ),
              onResponse: (response) async {
                DataUser? user = response.data ?? null;
                if (user != null) {
                  apiToken.value = user.apiToken ?? '';
                  twoFactorType = user.setting?.twoFactorType ?? '';
                  setToken(apiToken.value);
                  if (user.setting!.twoFactorType == 'sms') {
                    message = "The verification code was sent to the user ".tr.replaceAll('user', '${user.mobile}');
                    setLoading(false);
                    time.value = maxTime;
                    update();
                    startTimer();
                    dismissLoading();
                    await Get.toNamed(Routes.PHONE_VERIFICATION);
                  } else if (user.setting!.twoFactorType == 'email') {
                    message =  "The verification code was sent to the user ".tr.replaceAll('user', '${user.email}');
                    setLoading(false);
                    time.value = maxTime;
                    update();
                    startTimer();
                    dismissLoading();
                    await Get.toNamed(Routes.PHONE_VERIFICATION);
                  } else if (user.setting!.twoFactorType == 'google') {
                    setLoading(false);
                    time.value = maxTime;
                    update();
                    startTimer();
                    dismissLoading();
                    await Get.toNamed(Routes.GOOGLE_VERIFICATION);
                  } else {
                    try {
                      await Get.find<FireBaseMessagingService>().setDeviceToken();
                    } catch (e) {}
                    setLoading(false);
                    setLogin(true);
                    Core.user = response.data!;
                    nextPage(
                      action: () {
                        dismissLoading();
                        Get.toNamed(Routes.ROOT, arguments: 0);
                      },
                    );
                  }
                }
              },
              onError: (response) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: response.message);
              },
              failure: (error) {
                dismissLoading();
                snackbarRed(title: 'Error'.tr, subtitle: 'Communication error'.tr);
              },
            );
          } else {
            snackbarRed(title: 'Error'.tr, subtitle: 'Password is not valid'.tr);
          }
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: 'Mobile or email is not valid'.tr);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: "Please wait a time seconds".tr.replaceAll('time', time.value.toString()),);
      }
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      setLoading(false);
    }
  }

  void reSend() async {
    try {
      // await Get.find<FireBaseMessagingService>().setDeviceToken();
      if (time.value < 1) {
        if (email.value.length > 3) {
          if (password.value.length > 4) {
            showLoading();
            userSource.login(
              dataUser: DataUser(
                email: email.value,
                password: password.value,
              ),
              onResponse: (response) {
                DataUser? user = response.data ?? null;
                if (user != null) {
                  apiToken.value = user.apiToken ?? '';
                  setToken(apiToken.value);
                  setLoading(false);
                  time.value = maxTime;
                  update();
                  startTimer();
                  dismissLoading();
                }
              },
              onError: (errorResponse) {},
              failure: (error) {},
            );
          } else {
            snackbarRed(title: 'Error'.tr, subtitle: "Password is not valid".tr);
          }
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: "Mobile or email is not valid".tr);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: "Please wait a time seconds".tr.replaceAll('time', time.value.toString()),);
      }
    } catch (e) {
      // Get.showSnackbar(Ui.ErrorSnackBar(message: e.toString()));
    } finally {
      setLoading(false);
    }
  }

  void register() async {
    if (email.value.length > 3) {
      if (password.value.length > 5) {
        if (password.value == rePassword.value) {
          if (isLoading.value == false) {
            setLoading(true);
            try {
              userSource.register(
                dataUser: DataUser(
                  email: email.value,
                  password: password.value,
                  passwordConfirmation: password.value,
                  parentId: parentId.value != null && parentId.value.length > 0 ? int.parse(parentId.value) : null,
                ),
                onResponse: (response) async {
                  message = "The verification code was sent to the user ".tr.replaceAll('user', '${email.value}');
                  apiToken.value = response.data?.apiToken ?? '';
                  setToken(apiToken.value);
                  setLoading(false);
                  await Get.toNamed(Routes.PHONE_VERIFICATION);
                },
                onError: (onError) {
                  snackbarRed(title: 'Error'.tr, subtitle: onError.message);
                  setLoading(false);
                },
                failure: (error) {
                  dismissLoading();
                  snackbarRed(title: 'Error'.tr, subtitle: 'Communication error'.tr);
                  setLoading(false);
                },
              );
            } catch (e) {
              setLoading(false);
            } finally {
              // setLoading(false);
            }
          }
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: "Password is not the same as repeating it".tr);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: "Password must be more than 5 characters".tr);
      }
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: "Email is invalid".tr);
    }
  }

  Future getVerify() async {
    int number = 3;
    if (twoFactorType == "google") {
      number = 5;
    }
    if (code != null && code.length > number) {
      setLoading(true);
      showLoading();
      userSource.validate(
        code: code,
        onResponse: (onResponse) async {
          try {
            try {
              await Get.find<FireBaseMessagingService>().setDeviceToken();
            } catch (e) {}
            Core.user = onResponse.data!;
            setLoading(false);
            setLogin(true);
            nextPage(
              action: () {
                dismissLoading();
                Get.toNamed(Routes.ROOT, arguments: 0);
              },
            );
          } catch (e) {
            dismissLoading();
            setLoading(false);
            debugPrint(e.toString());
          }
        },
        onError: (response) {
          dismissLoading();
          snackbarRed(title: 'Error'.tr, subtitle: response.message);
          setLoading(false);
        },
        failure: (String error) {},
      );
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: "The verification code is incorrect".tr);
    }
  }

  Future forgetPasswordStep1() async {
    if (email.value.length > 4 && email.value.contains("@")) {
      setLoading(true);

      userSource.forgetPassword(
        dataUser: DataUser(email: email.value),
        onResponse: (response) async {
          setLoading(false);
          await Get.toNamed(Routes.FORGOT_PASSWORDSTEP2);
          snackbarRed(title: 'Error'.tr, subtitle: response.message);
        },
        onError: (onError) {
          snackbarRed(title: 'Error'.tr, subtitle: onError.message);
        },
        failure: (error) {},
      );
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: "Email is invalid".tr);
    }
    setLoading(false);
  }

  Future forgetPasswordStep2() async {
    if (code.length == 4) {
      if (password.value.length >= 5) {
        if (password.value == rePassword.value) {
          setLoading(true);
          userSource.validateForgetPassword(
            dataUser: DataUser(
              email: email.value,
              code: code,
              password: password.value,
            ),
            onResponse: (response) {
              Get.back();
              Get.back();
              setLoading(false);
            },
            onError: (onError) {
              setLoading(false);
              snackbarRed(title: 'Error'.tr, subtitle: onError.message);
            },
            failure: (error) {},
          );
        } else {
          snackbarRed(title: 'Error'.tr, subtitle: 'Password is not the same as repeating it'.tr);
        }
      } else {
        snackbarRed(title: 'Error'.tr, subtitle: "Password must be more than 5 characters".tr);
      }
    } else {
      snackbarRed(title: 'Error'.tr, subtitle: "The verification code is incorrect".tr);
    }
  }

  void nextPage({required VoidCallback action}) {
    getApplicationInfo(
      action: () => getCurrencies(
          action: () => getBankNameList(
                action: action,
              )),
    );

    // loadCurrenciesOfStatus(
    //   action: action,
    // );

    // getUser(
    //   action: () => loadCurrenciesOfStatus(
    //     action: action,
    //   ),
    // );
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time.value == 0) {
          timer.cancel();
          update();
        } else {
          time.value--;
          update();
        }
      },
    );
  }

  CurrencySource currencySource = CurrencySource(baseUrl: Core.uri);

  void loadCurrenciesOfStatus({required VoidCallback action}) {
    currencySource.read(
      onResponse: (response) {
        if (response.dataList?.isNotEmpty ?? false) {
          Core.currencies.addAll(response.dataList!);
          action();
        }
      },
      onError: (onError) {
        action();
      },
      failure: (error) {
        action();
      },
    );
  }

  void getUser({required final VoidCallback action}) {
    userSource.readUser(
      onResponse: (response) {
        Core.user = response.data!;
        action();
      },
      onError: (response) {
        snackbarRed(title: 'Error'.tr, subtitle: response.message);
        action();
      },
      failure: (error) {
        debugPrint(error);
      },
    );
  }
}
