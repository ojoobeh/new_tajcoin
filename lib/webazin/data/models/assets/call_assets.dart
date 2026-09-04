import 'package:webazin/webazin/utility/global.dart';
class CallAssets {

  CallAssets({
    this.code,
    this.data,
    this.meta,
    this.message,
  });

  CallAssets.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    meta = json['meta'] != null ? Meta.fromJson(json['meta']) : null;

    data=json['data'] != null ? List<DataAssets>.from(json['data']).map((DataAssets e) => DataAssets.fromJson(e.toJson())).toList() : null;

    message = json['message'];
  }
  int? code;
  List<DataAssets>? data;
  Meta? meta;
  String? message;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.map((DataAssets v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Meta {

  Meta({this.irt, this.usd});

  Meta.fromJson(Map<String, dynamic> json) {
    irt = json['irt'].toString();
    usd = json['usd'].toString();
  }
  String? irt;
  String? usd;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['irt'] = this.irt;
    data['usd'] = this.usd;
    return data;
  }
}

class DataAssets {

  DataAssets({this.balance, this.currency,this.balanceFree});

  DataAssets.fromJson(Map<String, dynamic> json) {
    balance = json['balance'].toString();
    balanceFree = json['balance_free'].toString();
    currency = json['currency'] != null ? CurrencyAssets.fromJson(json['currency']) : null;
  }
  String? balance;
  String? balanceFree;
  CurrencyAssets? currency;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['balance'] = this.balance;
    data['balance_free'] = this.balanceFree;
    if (this.currency != null) {
      data['currency'] = this.currency!.toJson();
    }
    return data;
  }
}

class CurrencyAssets {

  CurrencyAssets(
      {this.symbol,
      this.icon,
      this.decimal,
      this.name,
      this.price,
      this.iconUrl,
      this.imageqr,
      this.receivePrice,
      this.sendPrice,
      this.irtPrice,
      this.sumBuy,
      this.sumSell,
      this.percentImage,
      this.chartImage,
      this.id,
      this.enname,
      this.percent,
      this.count,
      this.position,
      this.maxBuy,
      this.timeSend,
      this.active,
      this.descriptionBuy,
      this.descriptionSell,
      this.createdAt,
      this.networks,
      this.updatedAt});

  CurrencyAssets.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    icon = json['icon'];
    decimal = json['decimal'].toString();
    name = json['name'];
    price = json['price'].toString();
    imageqr = json['imageqr'] != null ? ImageQrAssets.fromJson(json['imageqr']) : null;
    iconUrl = json['iconUrl'] != null ? json['iconUrl'] : "";
    sendPrice = doubleFromJson(json, 'send_price');
    receivePrice = doubleFromJson(json, 'receive_price');
    irtPrice = doubleFromJson(json, 'irt_price');
    sumBuy = json['sum_buy'].toString();
    sumSell = json['sum_sell'].toString();
    percentImage = json['percent_image'];
    chartImage = json['chart_image'];
    id = json['id'] ?? 0;
    enname = json['enname'];
    percent = json['percent'];
    String _count = json['count'].toString();
    count = double.parse(_count == "null" ? "0" : _count.toString());
    position = json['position'];
    maxBuy = json['max_buy'];
    timeSend = json['time_send'];
    active = json['active'];
    descriptionBuy = json['description_buy'];
    descriptionSell = json['description_sell'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    networks=json['networks'] != null ? List<NetworksAssets>.from(json['networks']).map((NetworksAssets e) => NetworksAssets.fromJson(e.toJson())).toList() : null;

  }
  String? symbol;
  String? icon;
  String? decimal;
  String? name;
  String? price;
  String? iconUrl;
  ImageQrAssets? imageqr;
  double? irtPrice;
  double? sendPrice;
  double? receivePrice;
  String? sumBuy;
  String? sumSell;
  String? percentImage;
  String? chartImage;
  int? id;
  String? enname;
  String? percent;
  double? count;
  int? position;
  int? maxBuy;
  String? timeSend;
  int? active;
  String? descriptionBuy;
  String? descriptionSell;
  String? createdAt;
  String? updatedAt;
  List<NetworksAssets>? networks;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['icon'] = this.icon;
    data['decimal'] = this.decimal;
    data['name'] = this.name;
    data['price'] = this.price;
    data['iconUrl'] = this.iconUrl;
    if (this.imageqr != null) {
      data['imageqr'] = this.imageqr!.toJson();
    }
    data['receive_price'] = this.receivePrice;
    data['send_price'] = this.sendPrice;
    data['irt_price'] = this.irtPrice;
    data['sum_buy'] = this.sumBuy;
    data['sum_sell'] = this.sumSell;
    data['percent_image'] = this.percentImage;
    data['chart_image'] = this.chartImage;
    data['id'] = this.id;
    data['enname'] = this.enname;
    data['percent'] = this.percent;
    data['count'] = this.count!.toDouble();
    data['position'] = this.position;
    data['max_buy'] = this.maxBuy;
    data['time_send'] = this.timeSend;
    data['active'] = this.active;
    data['description_buy'] = this.descriptionBuy;
    data['description_sell'] = this.descriptionSell;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.networks != null) {
      data['networks'] = this.networks!.map((NetworksAssets v) => v.toJson()).toList();
    }
    return data;
  }
}

class NetworksAssets {

  NetworksAssets(
      {this.id,
      this.coin,
      this.network,
      this.name,
      this.address,
      this.tag='',
      this.qrAddress,
      this.qrTag,
      this.addressRegex,
      this.memoRegex,
      this.withdrawFee,
      this.withdrawMin,
      this.withdrawMax,
      this.minConfirm,
      this.unLockConfirm,
      this.isDefault,
      this.createdAt,
      this.updatedAt});

  NetworksAssets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    coin = json['coin']??'';
    network = json['network']??'';
    name = json['name']??'';
    address = json['address']??'';
    tag = json['tag']??'';
    qrAddress = json['qr_address'] ?? '';
    qrTag = json['qr_tag'] ?? '';
    addressRegex = json['addressRegex'];
    memoRegex = json['memoRegex'];
    withdrawFee = json['withdrawFee'];
    withdrawMin = json['withdrawMin'];
    withdrawMax = json['withdrawMax'];
    minConfirm = json['minConfirm'];
    unLockConfirm = json['unLockConfirm'];
    isDefault = json['isDefault'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? coin;
  String? network;
  String? name;
  String? address;
 late String tag;
  String? qrAddress;
  String? qrTag;
  String? addressRegex;
  String? memoRegex;
  String? withdrawFee;
  String? withdrawMin;
  String? withdrawMax;
  String? minConfirm;
  String? unLockConfirm;
  int? isDefault;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['coin'] = this.coin;
    data['network'] = this.network;
    data['name'] = this.name;
    data['address'] = this.address;
    data['tag'] = this.tag;
    data['qr_address'] = this.qrAddress;
    data['qr_tag'] = this.qrTag;
    data['addressRegex'] = this.addressRegex;
    data['memoRegex'] = this.memoRegex;
    data['withdrawFee'] = this.withdrawFee;
    data['withdrawMin'] = this.withdrawMin;
    data['withdrawMax'] = this.withdrawMax;
    data['minConfirm'] = this.minConfirm;
    data['unLockConfirm'] = this.unLockConfirm;
    data['isDefault'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ImageQrAssets {

  ImageQrAssets({this.wallet, this.tag,});

  ImageQrAssets.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
    tag = json['tag'];
  }
  String? wallet;
  String? tag;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['wallet'] = this.wallet;
    data['tag'] = this.tag;
    return data;
  }
}
