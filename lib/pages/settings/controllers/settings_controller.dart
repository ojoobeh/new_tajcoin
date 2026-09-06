import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:local_auth/local_auth.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/utils/getMultipart.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/data/remote_datasource/user_source.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import '../../../services/settings_service.dart';

class SettingsController extends GetxController {
  final user = DataUser().obs;
  late GetStorage _box;
  late LocalAuthentication auth = LocalAuthentication();

  SettingsController() {
    _box = GetStorage();
  }

  final isDarkTheme = true.obs;
  final isFingerPrintAvailable = false.obs;
  var isFingerPrintActive = false.obs;

  @override
  void onInit() async {
    user.value = Core.user;
    checkBiometric();
    initThemeMode();
    initIsFingerPrintAvailable();

    super.onInit();
  }

  UserSource userSource = UserSource(baseUrl: Core.uri);

  Future getUser({required final VoidCallback action}) async {
    userSource.readUser(
      onResponse: (response) {
        Core.user = response.dataList!.first;
        action();
      },
      onError: (response) {
        toast(response.message);
        action();
      },
      failure: (error) {},
    );
    update();
  }

  var isLoading = false.obs;

  Future setIsSwitched(BuildContext context, bool _isDarkTheme) async {
    if (!isLoading.value) {
      isLoading.value = true;
      isDarkTheme.value = _isDarkTheme;

      _isDarkTheme ? await changeThemeMode(context, ThemeMode.dark) : await changeThemeMode(context, ThemeMode.light);
    }
  }

  // Future changeThem(
  //   BuildContext context,
  // ) async {
  //   isDarkTheme.value = ThemeService().theme == ThemeMode.dark;
  //
  //   ThemeService().switchTheme;
  // }

  Future setIsFingerPrintAvailable (final bool _isFingerPrintAvailable) async {
    // await DbHelper.updateBioMetric(boolIsFingerPrint);
    // var dd = await DbHelper.getIsFingerAvailable();

    setData (Core.fingerPrintEnable, _isFingerPrintAvailable);
    isFingerPrintAvailable.value = _isFingerPrintAvailable;
    update();
  }

  Future<void> checkBiometric() async {
    isFingerPrintAvailable.value = getBool (Core.fingerPrintEnable);
    update();
  }

  void initThemeMode() {
    String? _themeMode = _box.read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        isDarkTheme.value = false;
        break;
      case 'ThemeMode.dark':
        isDarkTheme.value = true;
        break;
      default:
    }
    update();
  }

  Future<void> initIsFingerPrintAvailable() async {
    // var dd = await DbHelper.getIsFingerAvailable();
    // isFingerPrintAvailable.value = dd == 1 ? true : false;
    update();
  }

  Future<void> changeThemeMode(BuildContext context, ThemeMode themeMode) async {
    Get.changeThemeMode(themeMode);
    // if (themeMode == ThemeMode.dark) {
    //   //Get.rootController.setTheme(Get.find<SettingsService>().getDarkTheme());
    //   await SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle.dark.copyWith(),
    //   );
    // } else {
    //   //Get.rootController.setTheme(Get.find<SettingsService>().getLightTheme());
    //   await SystemChrome.setSystemUIOverlayStyle(
    //     SystemUiOverlayStyle.light.copyWith(),
    //   );
    // }
    await _box.write('theme_mode', themeMode.toString());
    await Get.find<SettingsService>().getThemeMode();
    update();
    // Get.back();
  }
}
