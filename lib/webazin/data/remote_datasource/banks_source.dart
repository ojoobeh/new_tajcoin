import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/banks.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class BanksSource {
  late final String baseUrl;

  BanksSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataBank> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}card/bank/list?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataBank>.fromJson(response.data, fromMap: DataBank.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
