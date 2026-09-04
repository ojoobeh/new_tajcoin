import 'dart:convert';

import 'package:webazin/webazin/utility/global.dart';

class DataMarket {
  DataMarket({
    this.id,
    this.icon,
    this.symbol = '',
    this.price = 0,
    this.percent = '0',
    this.decimal = '0',
    this.currencyOne = '',
    this.currencyTwo = '',
    this.balanceOne = 0,
    this.balanceTwo = 0,
  });

  final int? id;
  final String? icon;
  final String symbol;
  double price;
  final String percent;
  final String decimal;
  final String currencyOne;
  final String currencyTwo;
  double? balanceOne;
  double? balanceTwo;

  factory DataMarket.fromJson(String str) => DataMarket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataMarket.fromMap(Map<String, dynamic> json) => DataMarket(
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        price: doubleFromJson(json, 'price'),
        percent: json["percent"] == null ? null : json["percent"],
        decimal: json["decimal"] == null ? null : json["decimal"],
        currencyOne: json["currencyOne"] == null ? null : json["currencyOne"],
        currencyTwo: json["currencyTwo"] == null ? null : json["currencyTwo"],
        balanceOne: json["BalanceOne"] == null ? null : doubleFromJson(json, "BalanceOne"),
        balanceTwo: json["BalanceTwo"] == null ? null : doubleFromJson(json, "BalanceTwo"),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "symbol": symbol == null ? null : symbol,
        "price": price == null ? null : price,
        "percent": percent == null ? null : percent,
        "decimal": decimal == null ? null : decimal,
        "currencyOne": currencyOne == null ? null : currencyOne,
        "currencyTwo": currencyTwo == null ? null : currencyTwo,
        "BalanceOne": balanceOne == null ? null : balanceOne,
        "BalanceTwo": balanceTwo == null ? null : balanceTwo,
      };
}

class DataOrderMarket {
  DataOrderMarket({
    this.id,
    this.market,
    this.symbol,
    this.count,
    this.price,
    this.sumPrice,
    this.type,
    this.wage,
    this.status,
    this.createdAt,
  });

  final int? id;
  final String? market;
  final String? symbol;
  final double? count;
  final double? price;
  final double? sumPrice;
  final String? type;
  final String? wage;
  final String? status;
  final String? createdAt;

  factory DataOrderMarket.fromJson(String str) => DataOrderMarket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataOrderMarket.fromMap(Map<String, dynamic> json) => DataOrderMarket(
        id: json["id"] == null ? null : json["id"],
        market: json["market"] == null ? null : json["market"],
    symbol: json["symbol"] == null ? null : json["symbol"],
        count: json["count"] == null ? null : doubleFromJson(json, "count"),
        price: json["price"] == null ? null : doubleFromJson(json, "price"),
        sumPrice: json["sumPrice"] == null ? null : doubleFromJson(json, "sumPrice"),
        type: json["type"] == null ? null : json["type"],
        wage: json["wage"] == null ? null : json["wage"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "market": market == null ? null : market,
        "symbol": symbol == null ? null : symbol,
        "count": count == null ? null : count,
        "price": price == null ? null : price,
        "sumPrice": sumPrice == null ? null : sumPrice,
        "type": type == null ? null : type,
        "wage": wage == null ? null : wage,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt,
      };
}

class StoreMarket {
  StoreMarket({
    this.marketId,
    this.price,
    this.count,
    this.type,
    this.orderType,
    this.sum,
  });

  final int? marketId;
  final String? price;
  final String? count;
  final String? type;
  final String? orderType;
  final String? sum;

  factory StoreMarket.fromJson(String str) => StoreMarket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory StoreMarket.fromMap(Map<String, dynamic> json) => StoreMarket(
        marketId: json["market_id"] == null ? null : json["market_id"],
        price: json["price"] == null ? null : json["price"],
        count: json["count"] == null ? null : json["count"],
        type: json["type"] == null ? null : json["type"],
        orderType: json["order_type"] == null ? null : json["order_type"],
        sum: json["sum"] == null ? null : json["sum"],
      );

  Map<String, dynamic> toMap() => {
        "market_id": marketId == null ? null : marketId,
        "price": price == null ? null : price,
        "count": count == null ? null : count,
        "type": type == null ? null : type,
        "order_type": orderType == null ? null : orderType,
        "sum": sum == null ? null : sum,
      };
}

class CallMarketClose {
  String? symbol;
  String? high;
  String? low;
  String? close;
  String? volume;
  String? percentChange;

  CallMarketClose({
    this.symbol,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.percentChange,
  });

  CallMarketClose.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'].toString();
    high = json['high'].toString();
    low = json['low'].toString();
    close = json['close'].toString();
    volume = json['volume'].toString();
    percentChange = json['percentChange'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['volumevolume'] = this.percentChange;

    return data;
  }
}


