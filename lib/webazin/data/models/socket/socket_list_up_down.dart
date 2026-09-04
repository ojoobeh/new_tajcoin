class SocketListUpDown {
  String? price;
  String? percentage;
  String? volume;

  SocketListUpDown({
    this.price,
    this.percentage,
    this.volume,
  });

  SocketListUpDown.fromJson(Map<String, dynamic> json) {
    price = json['price'] ?? "0";
    percentage = json['percentage'] ?? "0";
    volume = json['volume'] ?? "0";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['price'] = this.price;
    data['percentage'] = this.percentage;
    data['volume'] = this.volume;

    return data;
  }
}
