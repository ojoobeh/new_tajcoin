import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/dto/more_page.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class MorePageSource {
  late final String baseUrl;

  MorePageSource({required this.baseUrl});

  Future<void> read({
    required String pageUrl,
    required final Function(GenericResponse<DataMorePage> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "$baseUrl$pageUrl?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataMorePage>.fromJson(response.data, fromMap: DataMorePage.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
