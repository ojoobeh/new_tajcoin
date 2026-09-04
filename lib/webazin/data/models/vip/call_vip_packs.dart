class CallVipPacks {
  int? code;
  List<DataVipPacks>? data;
  String? message;

  CallVipPacks({this.code, this.data,  this.message,});

  CallVipPacks.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data=json['data'] != null ? List.from(json['data']).map((e) => DataVipPacks.fromJson(e)).toList() : [];

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

class DataVipPacks {
  int? id;
  String? title;
  String? image;
  int? days;
  String? price;
  String? description;
  String? createdAt;
  String? updatedAt;

  DataVipPacks(
      {this.id,
        this.title,
        this.image,
        this.days,
        this.price,
        this.description,
        this.createdAt,
        this.updatedAt});

  DataVipPacks.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    days = json['days'];
    price = json['price'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['days'] = this.days;
    data['price'] = this.price;
    data['description'] = this.description;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
