import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import 'translation_service.dart';

class SettingsService extends GetxService {
  SettingsService() {}

  Future<SettingsService> init() async {
    await getPopup();
    return this;
  }

  Future<void> getPopup() async {
    Get.log('starting popup ...');
    debugPrint('ok');
  }

  Locale getLocale() {
    String _locale = getData('language') ?? 'fa';
    return Get.find<TranslationService>().fromStringToLocale(_locale);
  }





  ThemeMode getThemeMode() {
    String? _themeMode = GetStorage().read<String>('theme_mode');
    switch (_themeMode) {
      case 'ThemeMode.light':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.light,
        );
        return ThemeMode.light;
      case 'ThemeMode.dark':
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark,
        );
        return ThemeMode.dark;
      case 'ThemeMode.system':
        return ThemeMode.system;
      default:
        SystemChrome.setSystemUIOverlayStyle(
          SystemUiOverlayStyle.dark,
        );
        return ThemeMode.dark;
    }
  }
}
