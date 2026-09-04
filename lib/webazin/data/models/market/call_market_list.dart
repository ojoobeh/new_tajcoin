class CallMarketList {
  late int code;
  List<DataMarketList>? data;
  late String message;

  CallMarketList({
    required this.code,
    this.data,
    required this.message,
  });

  CallMarketList.fromJson(Map<String, dynamic> json) {
    code = json['code'];

    data = json['data'] != null ? List.from(json['data']).map((e) => DataMarketList.fromJson(e)).toList() : [];

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

class DataMarketList {
  int? id;
  int? marketId;
  String? icon;
  late String symbol;
  late String price;
  late String decimal;
  late String percent;
  late String currencyOne;
  late String currencyTwo;
  late String balanceOne;
  late String balanceTwo;

  DataMarketList({
    this.id,
    this.icon,
    this.symbol = "",
    this.price = "0",
    this.decimal = "0",
    this.percent = "0",
    this.balanceOne = "0",
    this.balanceTwo = "0",
  });

  DataMarketList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    marketId = json['marketId'];
    icon = json['icon'] ?? '';
    symbol = json['symbol'] ?? '';
    price = json['price'] ?? "0";
    decimal = json['decimal'] ?? "0";
    percent = json['percent'] ?? "0";
    currencyOne = json['currencyOne'].toString();
    currencyTwo = json['currencyTwo'].toString();
    balanceOne = json['BalanceOne'].toString();
    balanceTwo = json['BalanceTwo'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = this.id;
    data['marketId'] = this.marketId;
    data['icon'] = this.icon;
    data['symbol'] = this.symbol;
    data['price'] = this.price;
    data['decimal'] = this.decimal;
    data['percent'] = this.percent;
    data['currencyOne'] = this.currencyOne;
    data['currencyTwo'] = this.currencyTwo;
    data['BalanceOne'] = this.balanceOne;
    data['BalanceTwo'] = this.balanceTwo;
    return data;
  }
}
