class CallHomeMessage {
  CallHomeMessage({
    required this.code,
    required this.data,
    required this.meta,
    required this.message,
    this.type,
  });
  late final int code;
  late final List<DataHomeMessage> data;
  late final List<dynamic> meta;
  late final String message;
  late final Null type;

  CallHomeMessage.fromJson(Map<String, dynamic> json){
    code = json['code'];
    data = List.from(json['data']).map((e)=>DataHomeMessage.fromJson(e)).toList();
    meta = List.castFrom<dynamic, dynamic>(json['meta']);
    message = json['message'];
    type = null;
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['code'] = code;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['meta'] = meta;
    _data['message'] = message;
    _data['type'] = type;
    return _data;
  }
}

class DataHomeMessage {
  DataHomeMessage({
    required this.message,
  });
  late final String message;

  DataHomeMessage.fromJson(Map<String, dynamic> json){
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    return _data;
  }
}