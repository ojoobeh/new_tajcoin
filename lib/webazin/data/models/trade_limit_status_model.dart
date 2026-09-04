import 'parents/model.dart';

class TradeLimitStatus extends Model {
  String? id;
  String? status;
  String? order;

  TradeLimitStatus({this.id, this.status, this.order});

  TradeLimitStatus.fromJson(Map<String, dynamic> json) {
    status = transStringFromJson(json, 'status');
    order = transStringFromJson(json, 'order');
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
