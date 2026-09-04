class CallPopup {
  int? code;
  List<DataPopup>? data;
  String? message;

  CallPopup({
    this.code,
    this.data,
    this.message,
  });

  CallPopup.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data = json['data'] != null ? List.from(json['data']).map((e) => DataPopup.fromJson(e)).toList() : [];

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

class DataPopup {
  int? id;
  String? image;
  String? link;
  String? title;
  String? message;

  DataPopup({
    this.id,
    this.image,
    this.link,
    this.title,
    this.message,
  });

  DataPopup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
    title = json['title'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['link'] = this.link;
    data['title'] = this.title;
    data['message'] = this.message;
    return data;
  }
}
