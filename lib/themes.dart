import 'package:flutter/material.dart';
import 'package:webazin/services/them_service.dart';
import 'package:webazin/utils/utils.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class Themes {
  static String bold = (getData('language') ?? 'fa') == 'fa' ? FontFamily.vazirBold : FontFamily.vazirBold;
  static String medium = (getData('language') ?? 'fa') == 'fa' ? FontFamily.vazirMedium : FontFamily.vazirMedium;
  static String small = (getData('language') ?? 'fa') == 'fa' ? FontFamily.vazirLight : FontFamily.vazirLight;

  static bool isDarkThem = ThemeService().theme == ThemeMode.dark;
  static final light = ThemeData.light().copyWith(
    scaffoldBackgroundColor: (AppColors.backgroundColor),
    primaryColor: (AppColors.primaryColor),
    primaryColorDark: (AppColors.primaryColorDark),
    canvasColor: (AppColors.canvasColor),
    cardColor: (AppColors.cardColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0, foregroundColor: Colors.white),
    brightness: Brightness.light,
    secondaryHeaderColor: AppColors.secondColor,
    dividerColor: (AppColors.dividerColor),
    focusColor: (AppColors.focusColor),
    hintColor: (AppColors.hintColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: (AppColors.accentColor)),
    textTheme: TextTheme(
      // titleLarge: TextStyle(color: AppColors.textsColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: bold),
      // titleMedium: TextStyle(color: AppColors.textsColor, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: medium),
      // titleSmall: TextStyle(color: AppColors.textsColor, fontSize: 16, fontWeight: FontWeight.w300, fontFamily: small),
      headlineLarge: TextStyle(color: AppColors.textsColor, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: bold),
      headlineMedium: TextStyle(color: AppColors.textsColor, fontSize: 18, fontWeight: FontWeight.w300, fontFamily: small),
      headlineSmall: TextStyle(color: AppColors.textsColor, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: bold),
      bodyLarge: TextStyle(color: AppColors.textsColor, fontSize: 16, fontWeight: FontWeight.w300, fontFamily: small),
      bodyMedium: TextStyle(color: AppColors.textsColor, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: bold),
      bodySmall: TextStyle(color: AppColors.textsColor, fontSize: 14, fontWeight: FontWeight.w300, fontFamily: small),
      titleLarge: TextStyle(color: AppColors.textsColor, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: bold),
      titleMedium: TextStyle(color: AppColors.textsColor, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: small),
      titleSmall: TextStyle(color: AppColors.textsColor, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: bold),
      labelLarge: TextStyle(color: AppColors.textsColor, fontSize: 10, fontWeight: FontWeight.w300, fontFamily: small),
      labelMedium: TextStyle(color: AppColors.textsColor, fontSize: 8, fontWeight: FontWeight.bold, fontFamily: bold),
      labelSmall: TextStyle(color: AppColors.textsColor, fontSize: 8, fontWeight: FontWeight.w300, fontFamily: small),
      displayMedium: TextStyle(color: AppColors.textsColor, fontSize: 6, fontWeight: FontWeight.w500, fontFamily: medium),
    ),
  );
  static final dark = ThemeData.dark().copyWith(
    primaryColor: (AppColors.primaryDarkColor),
    primaryColorDark: (AppColors.primaryDarkColorDark),
    canvasColor: (AppColors.canvasDarkColor),
    cardColor: (AppColors.cardDarkColor),
    floatingActionButtonTheme: FloatingActionButtonThemeData(elevation: 0),
    scaffoldBackgroundColor: (AppColors.backgroundDarkColor),
    brightness: Brightness.dark,
    secondaryHeaderColor: AppColors.secondDarkColor,
    dividerColor: (AppColors.dividerDarkColor),
    focusColor: (AppColors.focusDarkColor),
    hintColor: (AppColors.hintDarkColor),
    colorScheme: ColorScheme.fromSwatch().copyWith(secondary: (AppColors.accentDarkColor)),
    textTheme: TextTheme(
      // titleLarge: TextStyle(color: AppColors.textsColorDark, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: bold),
      // titleMedium: TextStyle(color: AppColors.textsColorDark, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: medium),
      // titleSmall: TextStyle(color: AppColors.textsColorDark, fontSize: 16, fontWeight: FontWeight.w300, fontFamily: small),
      headlineLarge: TextStyle(color: AppColors.textsColorDark, fontSize: 18, fontWeight: FontWeight.bold, fontFamily: bold),
      headlineMedium: TextStyle(color: AppColors.textsColorDark, fontSize: 18, fontWeight: FontWeight.w300, fontFamily: small),
      headlineSmall: TextStyle(color: AppColors.textsColorDark, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: bold),
      bodyLarge: TextStyle(color: AppColors.textsColorDark, fontSize: 16, fontWeight: FontWeight.w300, fontFamily: small),
      bodyMedium: TextStyle(color: AppColors.textsColorDark, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: bold),
      bodySmall: TextStyle(color: AppColors.textsColorDark, fontSize: 14, fontWeight: FontWeight.w300, fontFamily: small),
      titleLarge: TextStyle(color: AppColors.textsColorDark, fontSize: 12, fontWeight: FontWeight.bold, fontFamily: bold),
      titleMedium: TextStyle(color: AppColors.textsColorDark, fontSize: 12, fontWeight: FontWeight.w300, fontFamily: small),
      titleSmall: TextStyle(color: AppColors.textsColorDark, fontSize: 10, fontWeight: FontWeight.bold, fontFamily: bold),
      labelLarge: TextStyle(color: AppColors.textsColorDark, fontSize: 10, fontWeight: FontWeight.w300, fontFamily: small),
      labelSmall: TextStyle(color: AppColors.textsColorDark, fontSize: 8, fontWeight: FontWeight.w300, fontFamily: small),
      displayMedium: TextStyle(color: AppColors.textsColorDark, fontSize: 6, fontWeight: FontWeight.w500, fontFamily: medium),
      displaySmall: TextStyle(color: AppColors.textsColorDark, fontSize: 8, fontWeight: FontWeight.bold, fontFamily: bold),
    ),
  );
}
