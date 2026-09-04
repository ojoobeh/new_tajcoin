class CallCards {
  int? code;
  List<DataCards>? data;
  String? message;

  CallCards({this.code, this.data, });

  CallCards.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data=json['data'] != null ? List.from(json['data']).map((e) => DataCards.fromJson(e)).toList() : [];

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

class DataCards {
  int? id;
  String? icon;
  String? bankName;
  String? cardNumber;
  String? accountNumber;
 late String sheba;
  String? status;
  String? statusColor;

  DataCards(
      {this.id,
        this.icon,
        this.bankName,
        this.cardNumber,
        this.accountNumber,
        this.sheba='',
        this.status,
        this.statusColor});

  DataCards.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    icon = json['icon'];
    bankName = json['bank_name'];
    cardNumber = json['card_number'];
    accountNumber = json['account_number'];
    sheba = json['sheba'];
    status = json['status'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['icon'] = this.icon;
    data['bank_name'] = this.bankName;
    data['card_number'] = this.cardNumber;
    data['account_number'] = this.accountNumber;
    data['sheba'] = this.sheba;
    data['status'] = this.status;
    data['status_color'] = this.statusColor;
    return data;
  }
}
