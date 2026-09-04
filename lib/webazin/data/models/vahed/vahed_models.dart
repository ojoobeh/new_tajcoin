class DataVahed {
  int? id;
  String? item;

  DataVahed({this.item, this.id});

  DataVahed.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    item = json['item'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['item'] = this.item;
    data['id'] = this.id;

    return data;
  }
}