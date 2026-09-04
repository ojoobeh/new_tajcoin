import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';

class ApplicationInfoSource {
  ApplicationInfoSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> readApplicationInfo({
    required final Function(GenericResponse<DataApplicationInfo> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}application/version",
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataApplicationInfo>.fromJson(response.data, fromMap: DataApplicationInfo.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> readMessage({
    required final Function(GenericResponse<DataApplicationInfo> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}application/message",
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataApplicationInfo>.fromJson(response.data, fromMap: DataApplicationInfo.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
