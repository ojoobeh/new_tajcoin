import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/currency.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class CurrencySource {
  late final String baseUrl;

  CurrencySource({required this.baseUrl});

  Future<void> read({
    String search = '',
    required final Function(GenericResponse<DataCurrency> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}home/currencies?page=$page&per_page=$perPage&search=$search";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataCurrency>.fromJson(response.data, fromMap: DataCurrency.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> redById({
    required final DataCurrency dataCurrency,
    required final Function(GenericResponse<DataCurrency> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}home/currency/${dataCurrency.id}",
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataCurrency>.fromJson(response.data, fromMap: DataCurrency.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> readOscillation({
    String type = '',
    String search = '',
    required final Function(GenericResponse<DataCurrency> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) async {
    String url = '${baseUrl}home/oscillation?page=$page&per_page=$perPage&search=$search&type=$type';

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataCurrency>.fromJson(response.data, fromMap: DataCurrency.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
