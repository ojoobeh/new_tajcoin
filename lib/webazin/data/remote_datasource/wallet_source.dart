import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/dto/wallet.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class WalletSource {
  WalletSource({required this.baseUrl});

  late final String baseUrl;

  Future<void> read({
    String search = '',
    bool isFilter = false,
    required final Function(GenericResponse<DataWallet> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) async {
    String url = "${baseUrl}wallet/assets?search=$search&page=$page&per_page=$perPage";

    if (isFilter) {
      url = url + '&filter=count';
    }



    return httpGet(
      url: url,
      action: (final Response<dynamic> response) => onResponse(GenericResponse<DataWallet>.fromJson(response.data, fromMap: DataWallet.fromMap)),
      error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readHistory({
    String search = '',
    required final Function(GenericResponse<DataHistory> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) async {
    String url = "${baseUrl}wallet/history?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (final Response<dynamic> response) => onResponse(GenericResponse<DataHistory>.fromJson(response.data, fromMap: DataHistory.fromMap)),
      error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readDepositBySymbol({
    required String symbol,
    required final Function(GenericResponse<DataWallet> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpGet(
        url: "${baseUrl}wallet/deposit/$symbol",
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataWallet>.fromJson(response.data, fromMap: DataWallet.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> depositCurrency({
    required String symbol,
    required String txid,
    required final Function(GenericResponse<DataWallet> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}wallet/deposit/$symbol",
        body: {"txid": txid},
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataWallet>.fromJson(response.data, fromMap: DataWallet.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> depositIrt({
    required String price,
    required final Function(GenericResponse<String> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}wallet/deposit/IRT",
        body: {"price": price},
        encodeBody: false,
        action: (Response response) => onResponse(GenericResponse<String>.fromJson(response.data)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> withdrawalCurrency({
    required String symbol,
    required String qty,
    required String wallet,
    required int internal,
    required String network,
    required String tag,
    required final Function(GenericResponse<DataHistory> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}wallet/withdrawal/$symbol",
        body: {"qty": qty, "wallet": wallet, "network": network, "tag": tag, "internal": internal},
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataHistory>.fromJson(response.data, fromMap: DataHistory.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> withdrawalIrt({
    required String price,
    required String cardId,
    required final Function(GenericResponse<DataHistory> response) onResponse,
    required final Function(GenericResponse<dynamic> errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}wallet/withdrawal/IRT",
        body: {"price": price, "card_id": cardId},
        encodeBody: false,
        action: (final Response<dynamic> response) => onResponse(GenericResponse<DataHistory>.fromJson(response.data, fromMap: DataHistory.fromMap)),
        error: (final Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
