// To parse this JSON data, do
//
//     final callAccreditation = callAccreditationFromMap(jsonString);

import 'dart:convert';

import 'package:webazin/webazin/utility/global.dart';

import '../../utilities.dart';

class DataOrder {
  DataOrder({
    this.id,
    this.itemId,
    this.qty,
    this.price,
    this.usdPrice,
    this.status,
    this.statusText,
    this.statusColor,
    this.type,
    this.typeText,
    this.createdAt,
    this.createdAtFa,
    this.adminBody,
    this.currency,
  });

  final int? id;
  final int? itemId;
  final double? qty;
  final double? price;
  final double? usdPrice;
  final String? status;
  final String? statusText;
  final String? statusColor;
  final String? type;
  final String? typeText;
  final DateTime? createdAt;
  final DateTime? createdAtFa;
  final String? adminBody;
  final DataCurrency? currency;

  factory DataOrder.fromJson(String str) => DataOrder.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataOrder.fromMap(Map<String, dynamic> json) => DataOrder(
        id: json["id"] == null ? null : json["id"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        qty:  doubleFromJson(json, "qty"),
        price:  doubleFromJson(json, "price"),
        usdPrice: doubleFromJson(json, 'usd_price'),
        status: json["status"] == null ? null : json["status"],
        statusText: json["status_text"] == null ? null : json["status_text"],
        statusColor: json["status_color"] == null ? null : json["status_color"],
        type: json["type"] == null ? null : json["type"],
        typeText: json["type_text"] == null ? null : json["type_text"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        createdAtFa: json["created_at_fa"] == null ? null : DateTime.parse(json["created_at_fa"]),
        adminBody: json["admin_body"],
        currency: json["currency"] == null ? null : DataCurrency.fromMap(json["currency"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "item_id": itemId == null ? null : itemId,
        "qty": qty == null ? null : qty,
        "price": price == null ? null : price,
        "usd_price": usdPrice == null ? null : usdPrice,
        "status": status == null ? null : status,
        "status_text": statusText == null ? null : statusText,
        "status_color": statusColor == null ? null : statusColor,
        "type": type == null ? null : type,
        "type_text": typeText == null ? null : typeText,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "created_at_fa": createdAtFa == null ? null : createdAtFa!.toIso8601String(),
        "admin_body": adminBody,
        "currency": currency == null ? null : currency!.toMap(),
      };
}
