import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';

class UserSource {
  late final String baseUrl;

  UserSource({required this.baseUrl});

  Future<void> readUser({
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}user/info",
        action: (Response response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> login({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/login",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> validate({
    required final String code,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/login/validate",
        body: {'code':code},
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> register({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/register",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> validateRegister({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/register/validate",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> forgetPassword({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/password/forget?level=1",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> validateForgetPassword({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}auth/password/forget?level=2",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> sendVerifyCode({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/sendCode",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> checkVerifyCode({
    required final DataUser dataUser,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/validateCode",
        body: dataUser,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> smsLoginStatus({
    required final int status,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/sms_login_status",
        body: {'status': status},
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
    Future<void> emailLoginStatus({
    required final int status,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/email_login_status",
        body: {'status': status},
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );


  Future<void> gtfLoginStatus({
    required final int status,
    required final String code,
    required final Function(GenericResponse<DataUser> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}authentication/g2f_login_status",
        body: {'status': status,'code':code},
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataUser>.fromJson(response.data, fromMap: DataUser.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> saveDeviceToken({
    required final String url,
    required final String device,
    required final String fcmToken,
    required final Function(GenericResponse response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: url,
        body: {"fcm_token": fcmToken, "device": device},
        action: (Response<dynamic> response) => onResponse(GenericResponse.fromJson(response.data)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
