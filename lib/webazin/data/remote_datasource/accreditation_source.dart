import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class AccreditationSource {
  late final String baseUrl;

  AccreditationSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataAccreditation> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}accreditation?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response response) => onResponse(GenericResponse<DataAccreditation>.fromJson(response.data, fromMap: DataAccreditation.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }
}
