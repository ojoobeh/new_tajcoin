import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class MediaSource {
  MediaSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> create({
    required final File file,
    required final VoidCallback action,
    required final Function(GenericResponse response) onError,
    required final Function(String error) failure,
    required final String nationalCode,
    required final String name,
    required final String mobile,
    required final String birthday,
    final ProgressCallback? onSendProgress,
    Duration? timeout,
  }) async {
    try {
      Dio dio = Dio();
      String url = '${baseUrl}authentication/profile?api_token=${getString(Global.token)}';
      final Response<dynamic> response = await dio.post(
        url,
        // onSendProgress: onSendProgress,
        data: FormData.fromMap({
          'doc': await MultipartFile.fromFile(file.path, filename: 'file'),
          // 'Files': <MultipartFile>[await MultipartFile(file.path, filename: file.path)],
          'national_code': nationalCode,
          'name': name,
          'mobile': mobile,
          'birthday': birthday,
        }),

      );
      print('ok');
      if (response.data['code'] == 1) {
        action();
      } else {
        onError(GenericResponse.fromJson(response.data));
      }
    } on Exception catch (e) {
      failure(e.toString());
    }
  }
}
