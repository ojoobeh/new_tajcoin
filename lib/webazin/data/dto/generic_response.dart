import 'package:webazin/webazin/utilities.dart';

class GenericResponse<T> {
  GenericResponse({
    this.data,
    this.dataList,
    this.meta,
    this.code = 1,
    this.message = "",
  });

  factory GenericResponse.fromJson(final Map<String, dynamic> json, {final Function? fromMap}) {
    // if (fromMap == null && !(T is String)) return GenericResponse<T>(code: json["code"], message: json["message"]);
    if (json["data"] is List) {
      return GenericResponse<T>(
        code: (json["code"] ?? "0").toInt(),
        dataList: json['data'] != null
            ? fromMap == null
                ? List<T>.from(json['data'])
                : List<T>.from(json['data'].cast<Map<String, dynamic>>().map(fromMap))
            : null,
        meta: json["meta"] != null && json["meta"].toString().contains('irt') && json["meta"].toString().contains('usd') ? Meta.fromMap(json["meta"]) : null,
        message: json["message"] ?? '',
      );
    } else if (json["data"] is String) {
      return GenericResponse<T>(
        code: (json["code"] ?? "0").toInt(),
        data: json["data"],
        meta: json["meta"] != null && json["meta"].toString().contains('irt') && json["meta"].toString().contains('usd') ? Meta.fromMap(json["meta"]) : null,
        message: json["message"] ?? '',
      );
    } else {
      return GenericResponse<T>(
        code: (json["code"] ?? "0").toInt(),
        data: json["data"] != null && fromMap != null ? fromMap(json["data"]) : null,
        meta: json["meta"] != null && json["meta"].toString().contains('irt') && json["meta"].toString().contains('usd') ? Meta.fromMap(json["meta"]) : null,
        message: json["message"] ?? '',
      );
    }
  }

  final int code;
  final String message;
  final T? data;
  final Meta? meta;
  final List<T>? dataList;
}

class Meta {
  Meta({
    this.irt,
    this.usd,
  });

  final String? irt;
  final String? usd;

  factory Meta.fromJson(String str) => Meta.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
        irt: json["irt"] == null ? null : json["irt"],
        usd: json["usd"] == null ? null : json["usd"],
      );

  Map<String, dynamic> toMap() => {
        "irt": irt == null ? null : irt,
        "usd": usd == null ? null : usd,
      };
}
