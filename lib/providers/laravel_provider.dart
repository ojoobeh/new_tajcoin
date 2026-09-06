import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:webazin/webazin/data/models/currencies/currencies.dart';
import 'package:webazin/webazin/data/models/market/call_market_list.dart';
import 'package:webazin/webazin/data/models/market/call_market_order_list.dart';
import 'package:webazin/webazin/data/models/null/call_null.dart';
import 'package:webazin/webazin/data/models/null/model_null_3.dart';
import 'package:webazin/webazin/data/models/page/call_page.dart';
import 'package:webazin/webazin/data/models/vip/call_vip_packs.dart';

import '../utils/core.dart';
class LaravelApiClient extends GetxService  {
  late String baseUrl;


  String getBaseUrl(String path) {
    if (!path.endsWith('/')) {
      path += '/';
    }
    if (path.startsWith('/')) {
      path = path.substring(1);
    }
    if (!baseUrl.endsWith('/')) {
      return baseUrl + '/' + path;
    }
    return baseUrl + path;
  }

  String getApiBaseUrl(String path) {
    String _apiPath = Core.apiPath;
    if (path.startsWith('/')) {
      return getBaseUrl(_apiPath) + path.substring(1);
    }
    return getBaseUrl(_apiPath) + path;
  }

  String getPathUrl(String path) {
    String _apiPath = Core.laravelBaseUrl;
    if (path.startsWith('/')) {
      return getBaseUrl(_apiPath) + path.substring(1);
    }
    return getBaseUrl(_apiPath) + path;
  }

  Uri getApiBaseUri(String path) {
    String url = Core.uri+path;
    Uri uri = Uri.parse(url);
    return uri;
  }

  Uri getBaseUri(String path) {
    return Uri.parse(getBaseUrl(path));
  }

  void printUri(StackTrace stackTrace, Uri uri) {
    // Get.log(CustomTrace(stackTrace, message: uri.toString()).toString());
  }
  late Dio _httpClient;
  late Options _optionsNetwork;

  String api_token = 'HdH4JUoOol73pkffzTd8Za5m00mbIaSa2HGmCZZLb8TJU7qCuAJSrjN27wii';

  LaravelApiClient() {
    this.baseUrl = Core.laravelBaseUrl;
    _httpClient = Dio();
    // _httpClient.interceptors.add(DioCacheManager(CacheConfig(baseUrl: getApiBaseUrl(""))).interceptor);
  }

  Future<LaravelApiClient> init() async {
    _optionsNetwork = Options(headers: {
      'Accept': "application/json",
      'Content-Type': 'application/json',
    });

    // _httpClient.interceptors.add(DioCacheManager(CacheConfig(baseUrl: getApiBaseUrl(""))).interceptor);

    return this;
  }


  //************************* API *************************************//

  Future<CallCurrencies?> getCurrencies(int page, {String search= '', int perPage= 20}) async {
    var user = Core.user;
    try {
      var _queryParameters = {
        // 'api_token': authService.apiToken,
        'api_token': user.apiToken,
        'page': page.toString(),
        'search': search,
        'per_page': perPage.toString(),
      };

      Uri _uri = getApiBaseUri("home/currencies").replace(queryParameters: _queryParameters);

      debugPrint(_uri.toString());
      var response = await _httpClient.getUri(_uri);

      CallCurrencies callCurrencies = CallCurrencies.fromJson(response.data);
      return callCurrencies;
    } catch (e, stacktrace) {
      getError(105, error: e.toString(), showError: false, position: "getCurrencies", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallPage?> getCallPage(String page) async {
    // var user = Core.user;
    try {
      // var _queryParameters = {
      //   // 'api_token': authService.apiToken,
      //   'api_token': user.apiToken,
      // };
      Uri _uri = getApiBaseUri("page/info?page=${page}");
      Get.log(_uri.toString());
      var response = await _httpClient.getUri(_uri);

      CallPage callPage = CallPage.fromJson(response.data);
      if (callPage.code == 1) {
        return callPage;
      } else {
        throw Exception(response.data['message']);
      }
    } catch (e, stacktrace) {
      getError(115, error: e.toString(), showError: false, position: "getCallPage", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallNull3?> cancelOrder(String orderId) async {
    //  ticket/answer

    var user = Core.user;
    try {
      Uri _uri = getApiBaseUri("market/order/cancel/${orderId}?api_token=${user.apiToken}");

      var response = await _httpClient.getUri(
        _uri,
      );

      CallNull3 callNull3 = CallNull3.fromJson(response.data);

      return callNull3;
    } catch (e, stacktrace) {
      getError(121, error: e.toString(), showError: false, position: "cancelOrder", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallNull?> saveDeviceToken(String device, String fcm_token) async {
    //  ticket/answer

    var user = Core.user;
    try {
      String? deviceToken = await FirebaseMessaging.instance.getToken();
      Uri _uri = Uri.parse (Core.laravelBaseUrl + "fcm/save-device-token?api_token=${user.apiToken}");
      var response = await _httpClient.postUri(
        _uri,
        data: {
          "fcm_token": deviceToken,
          "device": device,
        },
      );
      CallNull callOrder = CallNull.fromJson(response.data);

      return callOrder;
    } catch (e) {
      getError(122, error: e.toString(), showError: false, showAllError: false, position: "saveDeviceToken");
      return null;
    }
  }

  Future<CallVipPacks?> getVipPacks() async {
    var user = Core.user;
    try {
      var _queryParameters = {
        // 'api_token': authService.apiToken,
        'api_token': user.apiToken,
      };
      Uri _uri = getApiBaseUri("vip/packs").replace(queryParameters: _queryParameters);
      var response = await _httpClient.getUri(_uri);
      CallVipPacks callVipPacks = CallVipPacks.fromJson(response.data);
      return callVipPacks;
    } catch (e, stacktrace) {
      getError(130, error: e.toString(), showError: false, position: "getVipPacks", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallMarketList?> getMarketList(int page, {String search=""}) async {
    var user = Core.user;
    _httpClient = dio.Dio();
    try {
      var _queryParameters = {
        // 'api_token': authService.apiToken,
        'api_token': user.apiToken,
        'page': page.toString(),
        'search': search,
        'per_page': "25",
      };
      Uri _uri = getApiBaseUri("market/list").replace(queryParameters: _queryParameters);
      var response = await _httpClient.getUri(_uri,options: _optionsNetwork);
      CallMarketList callMarketList = CallMarketList.fromJson(response.data);
      return callMarketList;
    } catch (e, stacktrace) {
      getError(135, error: e.toString(), showError: false, position: "getMarketList", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallMarketOrderList?> getMarketOrderList(int page, String status, int marketId, {int perpage= 25}) async {
    var user = Core.user;

    var _queryParameters = {
      // 'api_token': authService.apiToken,
      'api_token': user.apiToken,
      'page': page.toString(),
      'per_page': perpage.toString(),
    };
    try {
      Uri _uri = getApiBaseUri("market/order/${status}/${marketId}").replace(queryParameters: _queryParameters);
      Get.log(_uri.toString());
      var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
      CallMarketOrderList callMarketOrderList = CallMarketOrderList.fromJson(response.data);
      return callMarketOrderList;
    } catch (e, stacktrace) {
      getError(136, error: e.toString(), showError: true, showAllError: false, position: "getMarketOrderList", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallMarketOrderList?> getAllMarketOrderList(int page, String market, String status, String type, String marketStatus, int marketId, {int perpage= 25}) async {
    var user = Core.user;

    var _queryParameters = {
      // 'api_token': authService.apiToken,
      'api_token': user.apiToken,
      'page': page.toString(),
      'market': market,
      'status': marketStatus,
      'type': type,
      'per_page': perpage.toString(),
    };
    try {
      Uri _uri = getApiBaseUri("market/order/${status}/${marketId}").replace(queryParameters: _queryParameters);
      Get.log(_uri.toString());
      var response = await _httpClient.getUri(_uri, options: _optionsNetwork);
      CallMarketOrderList callMarketOrderList = CallMarketOrderList.fromJson(response.data);
      return callMarketOrderList;
    } catch (e, stacktrace) {
      getError(136, error: e.toString(), showError: true, showAllError: false, position: "getMarketOrderList", stacktrace: stacktrace);
      return null;
    }
  }

  Future<CallNull?> getBuyVip(int packId) async {
    var user = Core.user;
    try {
      var data = {
        'pack_id': packId.toString(),
      };
      Uri _uri = getApiBaseUri("vip/buy?api_token=${user.apiToken}");
      var response = await _httpClient.postUri(_uri, data: data, options: _optionsNetwork);
      CallNull callNull = CallNull.fromJson(response.data);
      return callNull;
    } catch (e, stacktrace) {
      getError(137, error: e.toString(), showError: false, position: "getBuyVip", stacktrace: stacktrace);
      return null;
    }
  }


  void toast(String param) {
    Fluttertoast.showToast(msg: param, toastLength: Toast.LENGTH_SHORT, gravity: ToastGravity.CENTER, timeInSecForIosWeb: 1, fontSize: 16.0);
  }
}
