import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class OrderSource {
  late final String baseUrl;

  OrderSource({required this.baseUrl});

  Future<void> readHistory({
    required final Function(GenericResponse<DataOrder> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    String currency = '',
    String? status,
    String? type,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}order/index?page=$page&per_page=$perPage&currency=$currency&status=$status&type=$type";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrder>.fromJson(response.data, fromMap: DataOrder.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readById({
    required int orderId,
    required final Function(GenericResponse<DataOrder> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) =>
      httpGet(
        url: "${baseUrl}order/$orderId",
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrder>.fromJson(response.data, fromMap: DataOrder.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> setStore({
    required int currencyId,
    required double qty,
    required String type,
    required final Function(GenericResponse<DataOrder> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) =>
      httpPost(
        url: "${baseUrl}order/store",
        body: {'currency_id': currencyId, 'type': type, 'qty': qty},
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrder>.fromJson(response.data, fromMap: DataOrder.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
