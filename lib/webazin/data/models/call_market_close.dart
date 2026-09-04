class CallMarketClose {
  String? symbol;
  String? high;
  String? low;
  String? close;
  String? volume;
  String? percentChange;

  CallMarketClose({
    this.symbol,
    this.high,
    this.low,
    this.close,
    this.volume,
    this.percentChange,
  });

  CallMarketClose.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'].toString();
    high = json['high'].toString();
    low = json['low'].toString();
    close = json['close'].toString();
    volume = json['volume'].toString();
    percentChange = json['percentChange'].toString();

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['high'] = this.high;
    data['low'] = this.low;
    data['close'] = this.close;
    data['volume'] = this.volume;
    data['volumevolume'] = this.percentChange;

    return data;
  }
}

