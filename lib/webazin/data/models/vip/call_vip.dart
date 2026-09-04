class CallVip {
  int? code;
  List<DataVip>? data;
  String? message;

  CallVip({
    this.code,
    this.data,
    this.message,
  });

  CallVip.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data=json['data'] != null ? List.from(json['data']).map((e) => DataVip.fromJson(e)).toList() : [];

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

class DataVip {
  int? id;
  String? category;
  String? title;
  String? slug;
  String? image;
  String? shortBody;
  String? body;
  String? createdAt;

  DataVip({this.id, this.category, this.title, this.slug, this.image, this.shortBody, this.body, this.createdAt});

  DataVip.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    title = json['title'];
    slug = json['slug'];
    image = json['image'];
    shortBody = json['short_body'];
    body = json['body'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['image'] = this.image;
    data['short_body'] = this.shortBody;
    data['body'] = this.body;
    data['created_at'] = this.createdAt;
    return data;
  }
}
