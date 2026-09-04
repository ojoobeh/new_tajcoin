import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/dto/more_page.dart';
import 'package:webazin/webazin/data/dto/vip_packs.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class VipSource {
  late final String baseUrl;

  VipSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataMorePage> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "$baseUrl/vip?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataMorePage>.fromJson(response.data, fromMap: DataMorePage.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readVipPacks({
    required final Function(GenericResponse<DataVipPack> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "$baseUrl/vip/packs?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataVipPack>.fromJson(response.data, fromMap: DataVipPack.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> buyVipPacks({
    required int packId,
    required final Function(GenericResponse<DataVipPack> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int? page,
    int? perPage = 20,
  }) {
    String url = "$baseUrl/vip/packs";
    if (page != null) {
      url = url + '?page=$page&per_page=$perPage';
    }

    return httpPost(
      url: url,
      body: {
        'pack_id': packId,
      },
      encodeBody: false,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataVipPack>.fromJson(response.data, fromMap: DataVipPack.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
