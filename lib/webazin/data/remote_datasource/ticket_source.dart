import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';
import 'package:webazin/webazin/utility/local_storage.dart';

class TicketSource {
  late final String baseUrl;

  TicketSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/index?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readById({
    required int ticketId,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/$ticketId?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readTicketCategory({
    required final Function(GenericResponse<DataTicketCategory> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/category?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicketCategory>.fromJson(response.data, fromMap: DataTicketCategory.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> createTicket({
    required int categoryId,
    required String subject,
    required String message,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) => httpPost(
    url: "${baseUrl}ticket/store",
    body: {'category_id': categoryId, 'subject': subject, 'message': message},
    encodeBody: false,
    action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
    error: (Response response) => onError(GenericResponse.fromJson(response.data)),
    failure: failure,
  );

  Future<void> createTicket2({
    required int categoryId,
    required String subject,
    required String message,
    String? filePath,
    required final VoidCallback onResponse,
    required final Function(String message) onError,
    required final Function(dynamic error) failure,
    final Function(double progress)? onSendProgress,
  }) async {
    final Dio dio = Dio();

    try {
      final Map<String, dynamic> formMap = {};
      debugPrint('ddddd'); //

      if ((filePath ?? '').isNotEmpty) {
        formMap['file'] = await MultipartFile.fromFile(filePath!, filename: filePath.split('/').last);
      }

      formMap.addAll({'category_id': categoryId, 'subject': subject, 'message': message});

      final FormData data = FormData.fromMap(formMap);

      final Map<String, String> header = <String, String>{'Accept': "application/json", 'Content-Type': 'application/json'};

      String url = '${baseUrl}ticket/store';
      if (baseUrl.contains("?")) {
        url = "$url&api_token=${getToken()}";
      } else {
        url = "$url?api_token=${getToken()}";
      }

      final Response<dynamic> response = await dio.post(
        url,
        data: filePath == null ? formMap : data,

        options: Options(headers: header, contentType: 'application/json', receiveTimeout: const Duration(seconds: 60), sendTimeout: const Duration(seconds: 60)),

        onSendProgress: (final int count, final int total) async {
          double progress = 0;
          final double d1 = double.parse(total.toString());
          final double d2 = double.parse(count.toString());
          final double d = d2 / (d1 / 100);
          final String d3 = d.toStringAsFixed(0);
          progress = double.parse(d3);
          onSendProgress?.call(progress);
        },
      );

      if (response.statusCode == 200 && response.data['code'] == 1) {
        onResponse();
      } else {
        onError(response.data['message']);
      }
    } catch (e) {
      failure(e);
      debugPrint("DDDDDD");
    }
  }

  Future<void> createAnswer({
    required int ticketId,
    required String message,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) => httpPost(
    url: "${baseUrl}ticket/answer",
    body: {'ticket_id': ticketId, 'message': message},
    encodeBody: false,
    action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
    error: (Response response) => onError(GenericResponse.fromJson(response.data)),
    failure: failure,
  );
}
