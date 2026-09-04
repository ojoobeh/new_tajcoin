import 'parents/model.dart';

class StringModel extends Model {
  int? id;
  String? title;
  String? param;

  StringModel({this.id, this.title, this.param});

  StringModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = transStringFromJson(json, 'title');
    param = transStringFromJson(json, 'param');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['param'] = this.param;
    return data;
  }
}
