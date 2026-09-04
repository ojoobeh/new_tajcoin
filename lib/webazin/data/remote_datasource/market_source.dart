import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class MarketSource {
  late final String baseUrl;

  MarketSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    String search = '',
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/list?page=$page&per_page=$perPage&search=$search";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataMarket>.fromJson(response.data, fromMap: DataMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }



  Future<void> readById({
    required int marketId,
    required final Function(GenericResponse<DataMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/$marketId?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataMarket>.fromJson(response.data, fromMap: DataMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readOrder({
    required String status,
    required int marketId,
    required final Function(GenericResponse<DataOrderMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/order/${status}/${marketId}?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrderMarket>.fromJson(response.data, fromMap: DataOrderMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readAllOrder({
    required int marketId,
    required String market,
    required String status,
    required String marketStatus,
    required String type,
    required final Function(GenericResponse<DataOrderMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/order/${status}/${marketId}?page=$page&per_page=$perPage&type=$type&status=$marketStatus&market=$market";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrderMarket>.fromJson(response.data, fromMap: DataOrderMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }


  Future<void> storeMarket({
    required StoreMarket storeMarket,
    required final Function(GenericResponse<DataOrderMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/store";

    return httpPost(
      url: url,
      body: storeMarket,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrderMarket>.fromJson(response.data, fromMap: DataOrderMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

   Future<void> canselOrderMarket({
    required int orderId,
    required final Function(GenericResponse<DataOrderMarket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page = Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}market/order/cancel/${orderId}";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataOrderMarket>.fromJson(response.data, fromMap: DataOrderMarket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }


}
