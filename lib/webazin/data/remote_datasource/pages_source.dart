
import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';

class PagesSource {
  PagesSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> read({
    required String page,
    required final Function(GenericResponse<String> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}page/info?page=$page",
        action: (final Response<dynamic> response) => onResponse(GenericResponse<String>.fromJson(response.data)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
