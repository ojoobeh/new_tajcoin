import 'dart:convert';

import 'package:webazin/webazin/data/dto/dto.dart';

class DataAffiliate {
  DataAffiliate({
    this.code,
    this.referrals,
    this.referralsCount,
    this.orders,
    this.commissions,
    this.commissionsAverage,
  });

  final int? code;
  final List<DataUser>? referrals;
  final int? referralsCount;
  final List<Order>? orders;
  final String? commissions;
  final String? commissionsAverage;

  factory DataAffiliate.fromJson(String str) => DataAffiliate.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAffiliate.fromMap(Map<String, dynamic> json) => DataAffiliate(
        code: json["code"] == null ? null : json["code"],
        referrals: json["referrals"] == null ? null : List<DataUser>.from(json["referrals"].map((x) => DataUser.fromMap(x))),
        referralsCount: json["referralsCount"] == null ? null : json["referralsCount"],
        orders: json["orders"] == null ? null : List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
        commissions: json["commissions"] == null ? null : json["commissions"],
        commissionsAverage: json["commissionsAverage"] == null ? null : json["commissionsAverage"],
      );

  Map<String, dynamic> toMap() => {
        "code": code == null ? null : code,
        "referrals": referrals == null ? null : List<dynamic>.from(referrals!.map((x) => x.toMap())),
        "referralsCount": referralsCount == null ? null : referralsCount,
        "orders": orders == null ? null : List<dynamic>.from(orders!.map((x) => x.toMap())),
        "commissions": commissions == null ? null : commissions,
        "commissionsAverage": commissionsAverage == null ? null : commissionsAverage,
      };
}

class Order {
  Order({
    this.user,
    this.price,
    this.createdAtFa,
  });

  final DataUser? user;
  final String? price;
  final DateTime? createdAtFa;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        user: json["user"] == null ? null : DataUser.fromMap(json["user"]),
        price: json["price"] == null ? null : json["price"],
        createdAtFa: json["created_at_fa"] == null ? null : DateTime.parse(json["created_at_fa"]),
      );

  Map<String, dynamic> toMap() => {
        "user": user == null ? null : user!.toMap(),
        "price": price == null ? null : price,
        "created_at_fa": createdAtFa == null ? null : createdAtFa!.toIso8601String(),
      };
}

