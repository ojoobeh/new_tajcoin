import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';

class AuthenticationSource {
  AuthenticationSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> updatePassword({
    required String oldPassword,
    required String newPassword,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/password",
        body: {
          'old_password': oldPassword,
          'password': newPassword,
          'password_confirmation': newPassword,
        },
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> sendCode({
    required String mobile,
    required final Function(GenericResponse<DataAffiliate> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/sendCode",
        body: {'mobile', mobile},
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataAffiliate>.fromJson(response.data, fromMap: DataAffiliate.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
  Future<void> validateCode({
    required String code,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/validateCode",
        body: {'code': code},
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
