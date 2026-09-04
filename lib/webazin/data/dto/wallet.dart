import 'dart:convert';

import 'package:webazin/webazin/data/dto/currency.dart';
import 'package:webazin/webazin/utility/global.dart';

class DataWallet {
  DataWallet({
    this.balance,
    this.balanceFree,
    this.currency,
    this.markets,
  });

  double? balance;
  final double? balanceFree;
  final DataCurrency? currency;
  final List<MarketElement>? markets;

  factory DataWallet.fromJson(String str) => DataWallet.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataWallet.fromMap(Map<String, dynamic> json) {
    return DataWallet(
      balance: doubleFromJson(json, 'balance'),
      balanceFree: doubleFromJson(json, 'balance_free'),
      currency: json["currency"] == null ? null : DataCurrency.fromMap(json["currency"]),
      markets: json["markets"] == null ? null : List<MarketElement>.from(json["markets"].map((x) => MarketElement.fromMap(x))),
    );
  }

  Map<String, dynamic> toMap() => {
        "balance": balance,
        "balance_free": balanceFree,
        "currency": currency == null ? null : currency!.toMap(),
        "markets": markets == null ? null : List<dynamic>.from(markets!.map((x) => x.toMap())),
      };
}




class DataHistory {
  DataHistory({
    this.id,
    this.userId,
    this.cardId,
    this.networkId,
    this.currency,
    this.price,
    this.wallet,
    this.tag,
    this.serviceId,
    this.txid,
    this.description,
    this.type,
    this.status,
    this.createdAt='-*-',
    this.updatedAt='-*-',
    this.typeFa,
    this.statusFa,
    this.createdAtFa='-*-',
    this.transactionLink,
    this.typeFaText,
    this.statusFaText,
    this.statusColor,
    this.currencyRelation,
    this.wage,
  });

  final int? id;
  final int? userId;
  final int? cardId;
  final int? networkId;
  final String? currency;
  final String? price;
  final String? wallet;
  final String? tag;
  final String? serviceId;
  final String? txid;
  final String? description;
  final String? type;
  final String? status;
  final String createdAt;
  final String updatedAt;
  final String? typeFa;
  final String? statusFa;
  final String createdAtFa;
  final String? transactionLink;
  final String? typeFaText;
  final String? statusFaText;
  final String? statusColor;
  final DataCurrency? currencyRelation;
  final String? wage;

  factory DataHistory.fromJson(String str) => DataHistory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataHistory.fromMap(Map<String, dynamic> json) => DataHistory(
    id: json["id"],
    userId: json["user_id"],
    cardId: json["card_id"],
    networkId: json["network_id"],
    currency: json["currency"],
    price: json["price"],
    wallet: json["wallet"],
    tag: json["tag"],
    serviceId: json["service_id"],
    txid: json["txid"],
    description: json["description"],
    type: json["type"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    typeFa: json["type_fa"],
    statusFa: json["status_fa"],
    createdAtFa: json["created_at_fa"],
    transactionLink: json["transaction_link"],
    typeFaText: json["type_fa_text"],
    statusFaText: json["status_fa_text"],
    statusColor: json["status_color"],
    currencyRelation:json["currency_relation"] == null ? null : DataCurrency.fromMap(json["currency_relation"]),
    wage: json["wage"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "user_id": userId,
    "card_id": cardId,
    "network_id": networkId,
    "currency": currency,
    "price": price,
    "wallet": wallet,
    "tag": tag,
    "service_id": serviceId,
    "txid": txid,
    "description": description,
    "type": type,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "type_fa": typeFa,
    "status_fa": statusFa,
    "created_at_fa": createdAtFa,
    "transaction_link": transactionLink,
    "type_fa_text": typeFaText,
    "status_fa_text": statusFaText,
    "status_color": statusColor,
    "currency_relation": currencyRelation == null ? null : currencyRelation!.toMap(),
    "wage": wage,
  };
}



