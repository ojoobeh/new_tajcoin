import 'dart:convert';


class DataVipPack {
  DataVipPack({
    this.id,
    this.title,
    this.image,
    this.days,
    this.price,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? title;
  final String? image;
  final int? days;
  final String? price;
  final String? description;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DataVipPack.fromJson(String str) => DataVipPack.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataVipPack.fromMap(Map<String, dynamic> json) => DataVipPack(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    image: json["image"] == null ? null : json["image"],
    days: json["days"] == null ? null : json["days"],
    price: json["price"] == null ? null : json["price"],
    description: json["description"] == null ? null : json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "image": image == null ? null : image,
    "days": days == null ? null : days,
    "price": price == null ? null : price,
    "description": description == null ? null : description,
    "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
  };
}
