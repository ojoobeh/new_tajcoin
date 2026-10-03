import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:webazin/utils/core.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/models/popup/call_popup.dart' hide DataPopup;
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class OtherSource {
  OtherSource();

  Future<void>  getPopup({
    required final Function(DataPopup response) onResponse,
    required final Function(dynamic) onError,
    required final Function(String error) failure,
  }) async {
    Dio dio = Dio();

    final Map<String, String> header = <String, String>{'Accept': "application/json", 'Content-Type': 'application/json'};

    String url = '${Core.uri2}application/popup';
    if (url.contains("?")) {
      url = "$url&api_token=${getToken()}";
    } else {
      url = "$url?api_token=${getToken()}";
    }

    try {
      Response response = await dio.get(url, options: Options(headers: header));
      var res = response.data['data'];
      DataPopup dataPopup = DataPopup.fromMap(res[0]);
      onResponse(dataPopup) ;
    } catch (e) {
      onError(e);
    }
  }
}
