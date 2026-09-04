import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';

class AffiliateSource {
  AffiliateSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> read({
    required final Function(GenericResponse<DataAffiliate> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}affiliate/index",
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataAffiliate>.fromJson(response.data, fromMap: DataAffiliate.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
