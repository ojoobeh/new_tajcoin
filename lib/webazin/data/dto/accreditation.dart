import 'dart:convert';

class DataAccreditation {
  DataAccreditation({
    this.id,
    this.link,
    this.category,
    this.title,
    this.slug,
    this.image,
    this.shortBody,
    this.body,
    this.createdAt,
  });

  final int? id;
  final String? link;
  final String? category;
  final String? title;
  final String? slug;
  final String? image;
  final String? shortBody;
  final String? body;
  final String? createdAt;

  factory DataAccreditation.fromJson(String str) => DataAccreditation.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAccreditation.fromMap(Map<String, dynamic> json) => DataAccreditation(
        id: json["id"] == null ? null : json["id"],
        link: json["link"] == null ? null : json["link"],
        category: json["category"] == null ? null : json["category"],
        title: json["title"] == null ? null : json["title"],
        slug: json["slug"] == null ? null : json["slug"],
        image: json["image"] == null ? null : json["image"],
        shortBody: json["short_body"] == null ? null : json["short_body"],
        body: json["body"] == null ? null : json["body"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "link": link == null ? null : link,
        "category": category == null ? null : category,
        "title": title == null ? null : title,
        "slug": slug == null ? null : slug,
        "image": image == null ? null : image,
        "short_body": shortBody == null ? null : shortBody,
        "body": body == null ? null : body,
        "created_at": createdAt == null ? null : createdAt,
      };
}
