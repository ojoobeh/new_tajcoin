class CallMarketOrderList {
  String? code;
  List<DataMarketOrderList>? data;
  String? message;

  CallMarketOrderList({
    this.code,
    this.data,
    this.message,
  });

  CallMarketOrderList.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();

    data = json['data'] != null ? List.from(json['data']).map((e) => DataMarketOrderList.fromJson(e)).toList() : [];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataMarketOrderList {
  int? id;
  String? market;
  String? count;
  String? price;
  String? sumPrice;
  String? type;
  String? wage;
  String? status;
  String? createdAt;

  DataMarketOrderList({this.id, this.market, this.count, this.price, this.sumPrice, this.type, this.wage, this.status, this.createdAt});

  DataMarketOrderList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    market = json['market'].toString();
    count = json['count'].toString();
    price = json['price'].toString();
    sumPrice = json['sumPrice'].toString();
    type = json['type'].toString();
    wage = json['wage'].toString();
    status = json['status'].toString();
    createdAt = json['created_at'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['market'] = this.market;
    data['count'] = this.count;
    data['price'] = this.price;
    data['sumPrice'] = this.sumPrice;
    data['type'] = this.type;
    data['wage'] = this.wage;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}


class MetaMarketOrderList {
  MetaMarketOrderList({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.links,
    required this.path,
    required this.perPage,
    required this.to,
    required this.total,
  });
  late final int currentPage;
  late final int from;
  late final int lastPage;
  late final List<Links> links;
  late final String path;
  late final String perPage;
  late final int to;
  late final int total;

  MetaMarketOrderList.fromJson(Map<String, dynamic> json){
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    links = List.from(json['links']).map((e)=>Links.fromJson(e)).toList();
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current_page'] = currentPage;
    _data['from'] = from;
    _data['last_page'] = lastPage;
    _data['links'] = links.map((e)=>e.toJson()).toList();
    _data['path'] = path;
    _data['per_page'] = perPage;
    _data['to'] = to;
    _data['total'] = total;
    return _data;
  }
}

class Links {
  Links({
    this.url,
    required this.label,
    required this.active,
  });
  late final String? url;
  late final String label;
  late final bool active;

  Links.fromJson(Map<String, dynamic> json){
    url = null;
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['url'] = url;
    _data['label'] = label;
    _data['active'] = active;
    return _data;
  }
}
