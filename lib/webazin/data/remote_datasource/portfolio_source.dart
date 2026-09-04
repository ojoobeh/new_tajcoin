import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class PortfolioSource {
  late final String baseUrl;

  PortfolioSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataPortfolio> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}portfolio?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataPortfolio>.fromJson(response.data, fromMap: DataPortfolio.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
