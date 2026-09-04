import 'package:dio/dio.dart';
import 'package:webazin/webazin/data/dto/dto.dart';
import 'package:webazin/webazin/data/dto/generic_response.dart';
import 'package:webazin/webazin/data/remote_datasource/dio_interceptor.dart';
import 'package:webazin/webazin/utility/global.dart';

class TicketSource {
  late final String baseUrl;

  TicketSource({required this.baseUrl});

  Future<void> read({
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/index?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readById({
    required int ticketId,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/$ticketId?page=$page&per_page=$perPage";


    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> readTicketCategory({
    required final Function(GenericResponse<DataTicketCategory> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
    int page =  Global.firstPage,
    int perPage = Global.perPage,
  }) {
    String url = "${baseUrl}ticket/category?page=$page&per_page=$perPage";

    return httpGet(
      url: url,
      action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicketCategory>.fromJson(response.data, fromMap: DataTicketCategory.fromMap)),
      error: (Response response) => onError(GenericResponse.fromJson(response.data)),
      failure: failure,
    );
  }

  Future<void> createTicket({
    required int categoryId,
    required String subject,
    required String message,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) =>
      httpPost(
        url: "${baseUrl}ticket/store",
        body: {
          'category_id': categoryId,
          'subject': subject,
          'message': message,
        },
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );

  Future<void> createAnswer({
    required int ticketId,
    required String message,
    required final Function(GenericResponse<DataTicket> response) onResponse,
    required final Function(GenericResponse errorResponse) onError,
    required final Function(String error) failure,
  }) =>
      httpPost(
        url: "${baseUrl}ticket/answer",
        body: {
          'ticket_id': ticketId,
          'message': message,
        },
        encodeBody: false,
        action: (Response<dynamic> response) => onResponse(GenericResponse<DataTicket>.fromJson(response.data, fromMap: DataTicket.fromMap)),
        error: (Response response) => onError(GenericResponse.fromJson(response.data)),
        failure: failure,
      );
}
