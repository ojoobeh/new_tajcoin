import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../utils/helper.dart';

class TranslationService extends GetxService {
  final translations = <String, Map<String, String>>{}.obs;

  final fallbackLocale = const Locale('en', 'US');

  static final languages = [
    'fa',
    'en',
  ];

  Future<TranslationService> init() async {
    for (final lang in languages) {
      final file = await Helper.getJsonFile(
        'assets/locales/$lang.json',
      );

      translations[lang] = Map<String, String>.from(file);
    }

    return this;
  }

  List<Locale> supportedLocales() {
    return languages.map(fromStringToLocale).toList();
  }

  Locale fromStringToLocale(String locale) {
    if (locale.contains('_')) {
      final parts = locale.split('_');

      return Locale(parts[0], parts[1]);
    }

    return Locale(locale);
  }
}