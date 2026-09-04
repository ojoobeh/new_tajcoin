import 'parents/model.dart';

class HomeStatus extends Model {
  String? id;
  String? status;
  int? order;

  HomeStatus({this.id, this.status, this.order});

  HomeStatus.fromJson(Map<String, dynamic> json) {
    status = transStringFromJson(json, 'status');
    order = intFromJson(json, 'order');
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['order'] = this.order;
    return data;
  }
}
