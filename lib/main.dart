import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:webazin/pages/splash/views/splash2_view.dart';
import 'package:webazin/providers/laravel_provider.dart';
import 'package:webazin/routes/theme1_app_pages.dart';
import 'package:webazin/services/firebase_messaging_service.dart';
import 'package:webazin/services/settings_service.dart';
import 'package:webazin/services/them_service.dart';
import 'package:webazin/services/translation_service.dart';
import 'package:webazin/utils/dio_connection.dart';
import 'package:webazin/themes.dart';
import 'package:webazin/webazin/utilities.dart';

Future<void> initServices() async {
  Get.log('starting services ...');

  await GetStorage.init();
  await Get.putAsync(() => TranslationService().init());
  // await Firebase.initializeApp();
  // await Get.putAsync(() => FireBaseMessagingService().init());
  await Get.putAsync(() => LaravelApiClient().init());
  await Get.putAsync(() => SettingsService().init());
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid
    ..loadingStyle = EasyLoadingStyle.dark
    ..boxShadow = <BoxShadow>[]
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.transparent
    ..maskColor = Colors.blue
    ..userInteractions = false
    ..dismissOnTap = false;

  Get.log('All services started...');
}

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(
    GetMaterialApp(
      title: "Taj Coin",
      getPages: Theme1AppPages.routes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: Get.find<TranslationService>().supportedLocales(),
      translationsKeys: Get.find<TranslationService>().translations,
      locale: Get.find<SettingsService>().getLocale(),
      themeMode: ThemeService().theme,
      theme: Themes.light,
      darkTheme: Themes.dark,
      home: Splash2View(),
      builder: EasyLoading.init(),
    ),
  );
}
