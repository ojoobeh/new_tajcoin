import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/dto/user.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class CardsSource {
  late final String baseUrl;

  CardsSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataCards> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}card/index?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataCards>.fromJson(response.data, fromMap: DataCards.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> createCard({
    required final DataCards dataCards,
    required final Function(GenericResponse<DataCards> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) async =>
      httpPost(
        url: "${baseUrl}card/store",
        body: dataCards,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataCards>.fromJson(response.data, fromMap: DataCards.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
