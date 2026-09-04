import 'dart:developer';

import 'package:dio/dio.dart';

// import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/material.dart';
import 'package:webazin/webazin/utility/enums.dart';
import 'package:webazin/webazin/utility/get.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

Future<void> request(
  final String baseUrl,
  final EHttpMethod httpMethod,
  final Function(Response<dynamic> response) action,
  final Function(Response<dynamic> response) error,
  final Function(String error) failure, {
  final dynamic body,
  final bool encodeBody = true,
  final Map<String, String>? headers,
}) async {
  final Map<String, String> header = <String, String>{
    'Accept': "application/json",
    'Content-Type': 'application/json',
  };

  String url = '';
  if (baseUrl.contains("?")) {
    url = "${baseUrl}&api_token=${getToken()}";
  } else {
    url = "${baseUrl}?api_token=${getToken()}";
  }

  log(url);
  if (headers != null) {
    header.addAll(headers);
  }
  final Dio dio = Dio();

// Add the interceptor
//   dio.interceptors.add(RetryInterceptor(
//     dio: dio,
//     logPrint: (message) => print('RetryPolicy >> $message'),
//     retries: 2, // retry count (optional)
//     retryDelays: const [
//       // set delays between retries (optional)
//       Duration(seconds: 1),
//       Duration(seconds: 2),
//     ],
//   ));

  // dio.interceptors.add(DioCacheManager(CacheConfig(baseUrl: '')).interceptor);

  try {
    dynamic params;
    if (body != null) {
      if (encodeBody)
        params = body.toJson();
      else
        params = body;
    }
    if (httpMethod == EHttpMethod.get) {
      Response response = await dio.get(url, options: Options(headers: header));
      act(response: response, action: action, error: error);
    } else if (httpMethod == EHttpMethod.post) {
      Response response = await dio.post(url, data: params, options: Options(headers: header));
      act(response: response, action: action, error: error);
    } else if (httpMethod == EHttpMethod.put) {
      Response response = await dio.put(url, data: params, options: Options(headers: header));
      act(response: response, action: action, error: error);
    } else if (httpMethod == EHttpMethod.delete) {
      Response response = await dio.delete(url, options: Options(headers: header));
      act(response: response, action: action, error: error);
    } else {
      Response response = await dio.patch(url, data: params, options: Options(headers: header));
      act(response: response, action: action, error: error);
    }
  } catch (e) {
    failure(e.toString());
  }
}

void act({
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required Response response,
}) {
  if (response.data['code'] == 1) {
    action(response);
  } else {
    error(response);
  }
  if (isDebugMode) {
    response.log();
  }
}

Future<void> httpGet({
  required final String url,
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required final Function(String error) failure,
  final Map<String, String>? headers,
}) async =>
    request(url, EHttpMethod.get, action, error, failure, headers: headers);

Future<void> httpPost({
  required final String url,
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required final Function(String error) failure,
  final Map<String, String>? headers,
  final dynamic body,
  final bool encodeBody = true,
}) async =>
    request(url, EHttpMethod.post, action, error, failure, body: body, encodeBody: encodeBody, headers: headers);

Future<void> httpPut({
  required final String url,
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required final Function(String error) failure,
  final Map<String, String>? headers,
  final dynamic body,
  final bool encodeBody = true,
}) async =>
    request(url, EHttpMethod.put, action, error, failure, body: body, encodeBody: encodeBody, headers: headers);

Future<void> patch({
  required final String url,
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required final Function(String error) failure,
  final Map<String, String>? headers,
  final dynamic body,
  final bool encodeBody = true,
}) async =>
    request(url, EHttpMethod.patch, action, error, failure, body: body, encodeBody: encodeBody, headers: headers);

Future<void> httpDelete({
  required final String url,
  required final Function(Response<dynamic> response) action,
  required final Function(Response<dynamic> response) error,
  required final Function(String error) failure,
  final Map<String, String>? headers,
}) async =>
    request(url, EHttpMethod.delete, action, error, failure, headers: headers);

extension HTTP on Response<dynamic> {
  bool isSuccessful() => (statusCode ?? 0) >= 200 && (statusCode ?? 0) <= 299 ? true : false;

  bool isServerError() => (statusCode ?? 0) >= 500 && (statusCode ?? 0) <= 599 ? true : false;

  void log({final String params = ""}) {
    debugPrint(
      "${this.requestOptions.method} - ${this.requestOptions.path} - $statusCode \nPARAMS: $params \nRESPONSE: ${this.data}",
    );
  }
}
