

import 'dart:developer' as developer;

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:webazin/pages/splash/views/splash2_view.dart';
import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

import 'assets.dart';

part 'global.dart';

class Core{
  static DataApplicationInfo applicationInfo = DataApplicationInfo();
  static DataUser user = DataUser();
  static List<DataCurrency> currencies =[];
  static List<DataBank> bankList =[];
  static List<DataPortfolio> portfolios =[];
  static bool canCheckBiometric=true;


  // static const String site = "v6.exchange-demo.ir";
  // static const String appName = "TajCoin";
  // static const String channel = "exvmarket";
  // static const String apiPath = "api/v2/";
  // static const String laravelBaseUrl = "https://v6.exchange-demo.ir/";
  // static const String laravelBaseUrl2 = "https://v6.exchange-demo.ir";
  // static const String uri = laravelBaseUrl + apiPath;


  static const String site = "tajcoin.org";
  static const String appName = "TajCoin";
  static const String appNameFa = "تاج کوین";
  static const String channel = "tajcoin";
  static const String apiPath = "api/v2/";
  static const String laravelBaseUrl = "https://tajcoin.org/";
  static const String laravelBaseUrl2 = "https://tajcoin.org";
  static const int port  = 8443;
  // static const String laravelBaseUrl2 = "https://tajcoin.org";
  static const String uri = laravelBaseUrl + apiPath;

  static const String VERSIONNAME = "3.2.0";
  static const int VERSIONCODE = 32;

  static int numberCountDecimal = 5;
  static int numberCountDecimal2 = 2;
  static int perPage = 25;
  static int pieChartHomeLimit = 4;
  static int pieChartHomeDecimalLimit = 2;





  static const String userLogin = "userLogin";
  static const String fingerPrintEnable = "fingerPrintEnable";
  static const String warningAssets = "warningAssets";
  static const String deviceToken = "deviceToken";
  static const String isFataTrue = "isFataTrue";
  static const String isPortFolioTrue = "isPortFolioTrue";
  static String helperMarket='helper_market';
  static String helperHome='helper_home';
  static String helperAsset='helper_assets';




}