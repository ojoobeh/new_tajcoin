class CallOrder {
  int? code;
  List<DataOrder>? data;
  String? message;

  CallOrder({this.code, this.data, this.message});

  CallOrder.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data=json['data'] != null ? List.from(json['data']).map((e) => DataOrder.fromJson(e)).toList() : [];

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

class DataOrder {
  int? id;
  int? itemId;
  String? qty;
  String? price;
  String? status;
  String? statusText;
  String? statusColor;
  String? type;
  String? typeText;
  String? createdAt;
  String? createdAtFa;
  String? adminBody;
  currencyOrder? currency;

  DataOrder(
      {this.id,
        this.itemId,
        this.qty,
        this.price,
        this.status,
        this.statusText,
        this.statusColor,
        this.type,
        this.typeText,
        this.createdAt,
        this.createdAtFa,
        this.adminBody,
        this.currency});

  DataOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    qty = json['qty'];
    price = json['price'];
    status = json['status'];
    statusText = json['status_text'];
    statusColor = json['status_color'];
    type = json['type'];
    typeText = json['type_text'];
    createdAt = json['created_at'];
    createdAtFa = json['created_at_fa'];
    adminBody = json['admin_body'];
    currency = json['currency'] != null
        ? currencyOrder.fromJson(json['currency'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['item_id'] = this.itemId;
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['status'] = this.status;
    data['status_text'] = this.statusText;
    data['status_color'] = this.statusColor;
    data['type'] = this.type;
    data['type_text'] = this.typeText;
    data['created_at'] = this.createdAt;
    data['created_at_fa'] = this.createdAtFa;
    data['admin_body'] = this.adminBody;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    return data;
  }
}

class currencyOrder {
  int? id;
  String? name;
  String? image;
  String? enName;
  String? symbol;
  String? wallet;
  String? tag;
  String? qr;
  String? price;
  String? usdPrice;
  String? receivePrice;
  String? irtPrice;
  String? sendPrice;
  String? sendCost;
  String? decimal;
  String? percent;
  String? percentImage;
  String? chartImage;

  currencyOrder(
      {this.id,
        this.name,
        this.image,
        this.enName,
        this.symbol,
        this.wallet,
        this.tag,
        this.qr,
        this.price,
        this.usdPrice,
        this.receivePrice,
        this.irtPrice,
        this.sendPrice,
        this.sendCost,
        this.decimal,
        this.percent,
        this.percentImage,
        this.chartImage});

  currencyOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
    enName = json['en_name'];
    symbol = json['symbol'];
    wallet = json['wallet'];
    tag = json['tag'];
    qr = json['qr'];
    price = json['price'];
    usdPrice = json['usd_price'];
    receivePrice = json['receive_price'];
    irtPrice = json['irt_price'];
    sendPrice = json['send_price'];
    sendCost = json['send_cost'];
    decimal = json['decimal'];
    percent = json['percent'];
    percentImage = json['percent_image'];
    chartImage = json['chart_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['image'] = this.image;
    data['en_name'] = this.enName;
    data['symbol'] = this.symbol;
    data['wallet'] = this.wallet;
    data['tag'] = this.tag;
    data['qr'] = this.qr;
    data['price'] = this.price;
    data['usd_price'] = this.usdPrice;
    data['receive_price'] = this.receivePrice;
    data['irt_price'] = this.irtPrice;
    data['send_price'] = this.sendPrice;
    data['send_cost'] = this.sendCost;
    data['decimal'] = this.decimal;
    data['percent'] = this.percent;
    data['percent_image'] = this.percentImage;
    data['chart_image'] = this.chartImage;
    return data;
  }
}
