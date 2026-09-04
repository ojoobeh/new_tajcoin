import 'package:flutter/material.dart';
import 'package:webazin/webazin/utility/global.dart';

class CallCurrencies {
  String? code;
  List<DataCurrencies>? data;
  String? message;
  MetaCurrencies? meta;

  CallCurrencies({
    this.code,
    this.data,
    this.message,
    this.meta,
  });

  CallCurrencies.fromJson(Map<String, dynamic> json) {
    try{
      code = json['code'].toString();
      if (json['data'] != null) {
        data = List.from(json['data']).map((e) => DataCurrencies.fromJson(e)).toList();

      }
      message = json['message'];
      meta = MetaCurrencies.fromJson(json['meta']);

    } catch (e) {
      debugPrint("ERROR IN CallCurrencies >> ${e.toString()}");
    }

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((DataCurrencies v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    data['meta'] = this.meta;
    return data;
  }
}

class DataCurrencies {
  int? id;
  String? icon;
  String? name;
  String? symbol;
  String? price;
  String? count;
  String? decimal;
  late String percent;
  int? position;
  String? type;
  String? market;
  int? active;
  String? createdAt;
  String? updatedAt;
  String? iconUrl;
  String? chartImage;
  double? irtPrice;
  double? sendPrice;
  double? receivePrice;
  List<NetworksCurrencies>? networks;
  CountUserCurrencies? countUser;

  List<MarketsCurrencies>? markets;

  DataCurrencies({
    this.id,
    this.icon,
    this.name,
    this.symbol,
    this.price,
    this.count,
    this.decimal,
    this.percent='-',
    this.position,
    this.type,
    this.market,
    this.active,
    this.irtPrice,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
    this.chartImage,
    this.sendPrice,
    this.receivePrice,
    this.networks,
    this.countUser,
    this.markets,
  });

  DataCurrencies.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      icon = json['icon'];
      name = json['name'];
      symbol = json['symbol'];
      price = json['price'];
      count = json['count'];
      decimal = json['decimal'];
      irtPrice = doubleFromJson(json, 'irt_price');
      percent = json['percent']??'-';
      position = json['position'];
      type = json['type'];
      market = json['market'];
      active = json['active'];
      createdAt = json['created_at'];
      updatedAt = json['updated_at'];
      iconUrl = json['iconUrl'] ?? "-*-";
      chartImage = json['chart_image'] != null ? json['chart_image'] : "";
      sendPrice = doubleFromJson(json, 'send_price');
      receivePrice = doubleFromJson(json, 'receive_price');
      networks = json['networks'] != null ? List.from(json['networks']).map((e) => NetworksCurrencies.fromJson(e)).toList() : [];
      countUser = json['count_user'] != null ? CountUserCurrencies.fromJson(json['count_user']) : null;
      markets = json['markets'] != null ? List.from(json['markets']).map((e) => MarketsCurrencies.fromJson(e)).toList() : [];
    } catch (e) {
      debugPrint("ERROR IN DataCurrencies At id ${json['id']} >> ${e.toString()}");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['name'] = this.name;
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    data['irt_price'] = this.irtPrice;
    data['count'] = this.count;
    data['decimal'] = this.decimal;
    data['percent'] = this.percent;
    data['position'] = this.position;
    data['type'] = this.type;
    data['market'] = this.market;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['iconUrl'] = this.iconUrl;
    data['chart_image'] = this.chartImage;
    data['send_price'] = this.sendPrice;
    data['receive_price'] = this.receivePrice;
    if (this.networks != null) {
      data['networks'] = this.networks!.map((NetworksCurrencies v) => v.toJson()).toList();
    }
    if (this.markets != null) {
      data['markets'] = this.markets!.map((MarketsCurrencies v) => v.toJson()).toList();
    }

    if (this.countUser != null) {
      data['count_user'] = this.countUser!.toJson();
    }
    return data;
  }
}

class NetworksCurrencies {
  int? id;
  String? coin;
  String? network;
  String? name;
  String? address;
  String? tag;
  String? qrAddress;
  String? qrTag;
  String? addressRegex;
  String? memoRegex;
  String? withdrawFee;
  String? withdrawMin;
  String? withdrawMax;
  String? minConfirm;
  String? explorer;
  int? isDefault;
  int? active;
  String? createdAt;
  String? updatedAt;

  NetworksCurrencies(
      {this.id,
      this.coin,
      this.network,
      this.name,
      this.address,
      this.tag,
      this.qrAddress,
      this.qrTag,
      this.addressRegex,
      this.memoRegex,
      this.withdrawFee,
      this.withdrawMin,
      this.withdrawMax,
      this.minConfirm,
      this.explorer,
      this.isDefault,
      this.active,
      this.createdAt,
      this.updatedAt});

  NetworksCurrencies.fromJson(Map<String, dynamic> json) {
    if (json['id'] == 59) {
      debugPrint("Networks id >> ${json['id']}");
    }
    id = json['id'];
    coin = json['coin'];
    network = json['network'];
    name = json['name'];
    address = json['address'];
    tag = json['tag'];
    qrAddress = json['qr_address'];
    qrTag = json['qr_tag'];
    addressRegex = json['addressRegex'];
    memoRegex = json['memoRegex'];
    withdrawFee = json['withdrawFee'];
    withdrawMin = json['withdrawMin'];
    withdrawMax = json['withdrawMax'];
    minConfirm = json['minConfirm'];
    explorer = json['explorer'];
    isDefault = json['isDefault'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

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
    data['explorer'] = this.explorer;
    data['isDefault'] = this.isDefault;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class MarketsCurrencies {
  int? id;
  String? symbol;
  String? price;

  MarketsCurrencies({
    this.id,
    this.symbol,
    this.price = "0.0",
  });

  MarketsCurrencies.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    symbol = json['symbol'];
    price = json['price'] ?? "0.0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    return data;
  }

  void setPrice(String _price) {
    price = _price;
  }
}

class CountUserCurrencies {
  String? iRT;
  String? uSD;

  CountUserCurrencies({this.iRT, this.uSD});

  CountUserCurrencies.fromJson(Map<String, dynamic> json) {
    iRT = json['IRT'];
    uSD = json['USD'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['IRT'] = this.iRT;
    data['USD'] = this.uSD;
    return data;
  }
}

class MetaCurrencies {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  MetaCurrencies({this.currentPage, this.from, this.lastPage, this.path, this.perPage, this.to, this.total});

  MetaCurrencies.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

