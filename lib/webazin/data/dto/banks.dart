import 'dart:convert';

class DataBank {
  DataBank({
    this.prefix,
    this.icon,
    this.name,
  });

  final String? prefix;
  final String? icon;
  final String? name;

  factory DataBank.fromJson(String str) => DataBank.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataBank.fromMap(Map<String, dynamic> json) => DataBank(
        prefix: json["prefix"] == null ? null : json["prefix"],
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
      );

  Map<String, dynamic> toMap() => {
        "prefix": prefix == null ? null : prefix,
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
      };
}
