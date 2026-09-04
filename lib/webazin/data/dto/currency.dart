import 'package:webazin/webazin/utilities.dart';
import 'package:webazin/webazin/utility/global.dart';

class DataCurrency {
  DataCurrency({
    this.id,
    this.icon,
    this.name,
    this.chartName,
    this.symbol,
    this.explorer,
    this.price,
    this.count,
    this.decimal,
    this.decimalSize,
    this.percent = '0',
    this.position,
    this.type,
    this.market,
    this.active,
    this.createdAt,
    this.updatedAt,
    this.iconUrl,
    this.irtPrice,
    this.sendPrice,
    this.receivePrice,
    this.percentImage,
    this.chartImage,
    this.sellPercent,
    this.buyPercent,
    this.networks,
    this.countUser,
    this.markets,
    this.sumBuy,
    this.sumSell,
    this.image,
    this.color,
    this.enName,
    this.wallet,
    this.tag,
    this.qr,
    this.sendCost,
    this.chartData,
  });

  final int? id;
  final String? icon;
  final String? name;
  final String? chartName;
  final String? symbol;
  final String? explorer;
  double? price;
  final String? count;
  final String? decimal;
  final String? decimalSize;
  final String percent;
  final int? position;
  final String? type;
  final String? color;
  final String? market;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? iconUrl;
  double? irtPrice;
  final double? sendPrice;
  final double? receivePrice;
  final String? percentImage;
  final String? chartImage;
  final String? sellPercent;
  final String? buyPercent;
  final List<Network>? networks;
  final CountUser? countUser;
  final List<MarketElement>? markets;
  final String? sumBuy;
  final String? sumSell;
  final String? image;
  final String? enName;
  final String? wallet;
  final String? tag;
  final String? qr;
  final String? sendCost;
  final List<double>? chartData;

  factory DataCurrency.fromJson(String str) => DataCurrency.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  void setPrice(double _price) {
    this.price = _price;
  }

  factory DataCurrency.fromMap(Map<String, dynamic> json) => DataCurrency(
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        name: json["name"] == null ? null : json["name"],
        color: json["color"] == null ? null : json["color"],
        chartName: json["chart_name"] == null ? null : json["chart_name"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        explorer: json["explorer"] == null ? null : json["explorer"],
        price: json["price"] == null ? null : doubleFromJson(json, "price"),
        count: json["count"] == null ? null : json["count"],
        decimal: json["decimal"] == null ? null : json["decimal"],
        decimalSize: json["decimal_size"] == null ? null : json["decimal_size"],
        percent: json["percent"] == null ? '0' : json["percent"],
        position: json["position"] == null ? null : json["position"],
        type: json["type"] == null ? null : json["type"],
        market: json["market"] == null ? null : json["market"],
        active: json["active"] == null ? null : json["active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        iconUrl: json["iconUrl"] == null ? null : json["iconUrl"],
        irtPrice: doubleFromJson(json, 'irt_price'),
        sendPrice: doubleFromJson(json, 'send_price'),
        sumBuy: json["sum_buy"] == null ? null : json["sum_buy"],
        sumSell: json["sum_sell"] == null ? null : json["sum_sell"],
        receivePrice: doubleFromJson(json, 'receive_price'),
        percentImage: json["percent_image"] == null ? null : json["percent_image"],
        chartImage: json["chart_image"] == null ? null : json["chart_image"],
        sellPercent: json["sell_percent"] == null ? null : json["sell_percent"],
        buyPercent: json["buy_percent"] == null ? null : json["buy_percent"],
        networks: json["networks"] == null ? null : List<Network>.from(json["networks"].map((x) => Network.fromMap(x))),
        countUser: json["count_user"] == null ? null : CountUser.fromMap(json["count_user"]),
        markets: json["markets"] == null ? null : List<MarketElement>.from(json["markets"].map((x) => MarketElement.fromMap(x))),
        chartData: json["chartData"] == null ? [] : List<double>.from(json["chartData"]!.map((x) => x?.toDouble())),
        image: json["image"] == null ? null : json["image"],
        enName: json["en_name"],
        wallet: json["wallet"],
        tag: json["tag"],
        qr: json["qr"],
        sendCost: json["send_cost"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "name": name == null ? null : name,
        "chart_name": chartName == null ? null : chartName,
        "symbol": symbol == null ? null : symbol,
        "color": color == null ? null : color,
        "explorer": explorer == null ? null : explorer,
        "price": price == null ? null : price,
        "count": count == null ? null : count,
        "decimal": decimal == null ? null : decimal,
        "decimal_size": decimalSize == null ? null : decimalSize,
        "percent": percent == null ? null : percent,
        "position": position == null ? null : position,
        "type": type == null ? null : type,
        "market": market == null ? null : market,
        "active": active == null ? null : active,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "iconUrl": iconUrl == null ? null : iconUrl,
        "irt_price": irtPrice == null ? null : irtPrice,
        "send_price": sendPrice == null ? null : sendPrice,
        "sum_buy": sumBuy == null ? null : sumBuy,
        "sum_sell": sumSell == null ? null : sumSell,
        "receive_price": receivePrice == null ? null : receivePrice,
        "percent_image": percentImage == null ? null : percentImage,
        "chart_image": chartImage == null ? null : chartImage,
        "sell_percent": sellPercent == null ? null : sellPercent,
        "buy_percent": buyPercent == null ? null : buyPercent,
        "networks": networks == null ? null : List<dynamic>.from(networks!.map((x) => x.toMap())),
        "count_user": countUser == null ? null : countUser!.toMap(),
        "markets": markets == null ? null : List<dynamic>.from(markets!.map((x) => x.toMap())),
        "chartData": chartData == null ? [] : List<dynamic>.from(chartData!.map((x) => x)),
        "image": image == null ? null : image,
        "en_name": enName,
        "wallet": wallet,
        "tag": tag,
        "qr": qr,
        "send_cost": sendCost,
      };
}

class CountUser {
  CountUser({
    this.irt,
    this.usd,
  });

  final double? irt;
  double? usd;

  factory CountUser.fromJson(String str) => CountUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CountUser.fromMap(Map<String, dynamic> json) => CountUser(
        irt: json["IRT"] == null ? null : doubleFromJson(json, "IRT"),
        usd: json["USD"] == null ? null : doubleFromJson(json, "USD"),
      );

  Map<String, dynamic> toMap() => {
        "IRT": irt == null ? null : irt,
        "USD": usd == null ? null : usd,
      };
}

class MarketElement {
  MarketElement({
    this.id,
    this.symbol,
    this.currencyBuy,
    this.currencySell,
    this.price,
    this.minPrice,
    this.maxPrice,
    this.lastPrice,
    this.volume,
    this.change24,
    this.average24,
    this.market,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusFa,
    this.statusFaHtml,
    this.decimal,
    this.icon,
    this.percent,
    this.currencyOne,
    this.currencyTwo,
    this.balanceOne,
    this.balanceTwo,
    this.currencyBuyer,
  });

  final int? id;
  final String? symbol;
  final int? currencyBuy;
  final int? currencySell;
  double? price;
  final String? minPrice;
  final String? maxPrice;
  final String? lastPrice;
  final String? volume;
  final String? change24;
  final String? average24;
  final String? market;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? statusFa;
  final String? statusFaHtml;
  final String? decimal;
  final DataCurrency? currencyBuyer;

  final String? icon;
  final String? percent;
  final String? currencyOne;
  final String? currencyTwo;
  final double? balanceOne;
  final double? balanceTwo;

  void setPrice(double _price) {
    this.price = _price;
  }

  factory MarketElement.fromJson(String str) => MarketElement.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory MarketElement.fromMap(Map<String, dynamic> json) => MarketElement(
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        percent: json["percent"] == null ? null : json["percent"],
        currencyOne: json["currencyOne"] == null ? null : json["currencyOne"],
        currencyTwo: json["currencyTwo"] == null ? null : json["currencyTwo"],
        balanceOne: json["balanceOne"] == null ? null : json["balanceOne"],
        balanceTwo: json["balanceTwo"] == null ? null : json["balanceTwo"],
        symbol: json["symbol"] == null ? null : json["symbol"],
        currencyBuy: json["currency_buy"] == null ? null : json["currency_buy"],
        currencySell: json["currency_sell"] == null ? null : json["currency_sell"],
        price: json["price"] == null ? null : doubleFromJson(json, "price"),
        minPrice: json["min_price"] == null ? null : json["min_price"],
        maxPrice: json["max_price"] == null ? null : json["max_price"],
        lastPrice: json["last_price"] == null ? null : json["last_price"],
        volume: json["volume"] == null ? null : json["volume"],
        change24: json["change_24"] == null ? null : json["change_24"],
        average24: json["average_24"] == null ? null : json["average_24"],
        market: json["market"] == null ? null : json["market"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        statusFa: json["status_fa"] == null ? null : json["status_fa"],
        statusFaHtml: json["status_fa_html"] == null ? null : json["status_fa_html"],
        decimal: json["decimal"] == null ? null : json["decimal"],
        currencyBuyer: json["currency_buyer"] == null ? null : DataCurrency.fromMap(json["currency_buyer"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "icon": symbol == null ? null : icon,
        "percent": percent == null ? null : percent,
        "currencyOne": currencyOne == null ? null : currencyOne,
        "currencyTwo": currencyTwo == null ? null : currencyTwo,
        "balanceOne": balanceOne == null ? null : balanceOne,
        "balanceTwo": balanceTwo == null ? null : balanceTwo,
        "symbol": symbol == null ? null : symbol,
        "currency_buy": currencyBuy == null ? null : currencyBuy,
        "currency_sell": currencySell == null ? null : currencySell,
        "price": price == null ? null : price,
        "min_price": minPrice == null ? null : minPrice,
        "max_price": maxPrice == null ? null : maxPrice,
        "last_price": lastPrice == null ? null : lastPrice,
        "volume": volume == null ? null : volume,
        "change_24": change24 == null ? null : change24,
        "average_24": average24 == null ? null : average24,
        "market": market == null ? null : market,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "status_fa": statusFa == null ? null : statusFa,
        "status_fa_html": statusFaHtml == null ? null : statusFaHtml,
        "decimal": decimal == null ? null : decimal,
        "currency_buyer": currencyBuyer == null ? null : currencyBuyer!.toMap(),
      };
}

class Network {
  Network({
    this.id,
    this.coin,
    this.network,
    this.name,
    this.address,
    this.tag,
    this.qrAddress,
    this.qrTag,
    this.addressRegex,
    this.memoRegex,
    this.withdrawFee,
    this.withdrawMin,
    this.withdrawMax,
    this.minConfirm,
    this.explorer,
    this.isDefault,
    this.active,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? coin;
  final String? network;
  final String? name;
  final String? address;
  final String? tag;
  final String? qrAddress;
  final String? qrTag;
  final String? addressRegex;
  final String? memoRegex;
  final String? withdrawFee;
  final String? withdrawMin;
  final String? withdrawMax;
  final String? minConfirm;
  final String? explorer;
  final int? isDefault;
  final int? active;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Network.fromJson(String str) => Network.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Network.fromMap(Map<String, dynamic> json) => Network(
        id: json["id"] == null ? null : json["id"],
        coin: json["coin"] == null ? null : json["coin"],
        network: json["network"] == null ? null : json["network"],
        name: json["name"] == null ? null : json["name"],
        address: json["address"] == null ? null : json["address"],
        tag: json["tag"] == null ? null : json["tag"],
        qrAddress: json["qr_address"] == null ? null : json["qr_address"],
        qrTag: json["qr_tag"] == null ? null : json["qr_tag"],
        addressRegex: json["addressRegex"] == null ? null : json["addressRegex"],
        memoRegex: json["memoRegex"] == null ? null : json["memoRegex"],
        withdrawFee: json["withdrawFee"] == null ? null : json["withdrawFee"],
        withdrawMin: json["withdrawMin"] == null ? null : json["withdrawMin"],
        withdrawMax: json["withdrawMax"] == null ? null : json["withdrawMax"],
        minConfirm: json["minConfirm"] == null ? null : json["minConfirm"],
        explorer: json["explorer"],
        isDefault: json["isDefault"] == null ? null : json["isDefault"],
        active: json["active"] == null ? null : json["active"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "coin": coin == null ? null : coin,
        "network": network == null ? null : network,
        "name": name == null ? null : name,
        "address": address == null ? null : address,
        "tag": tag == null ? null : tag,
        "qr_address": qrAddress == null ? null : qrAddress,
        "qr_tag": qrTag == null ? null : qrTag,
        "addressRegex": addressRegex == null ? null : addressRegex,
        "memoRegex": memoRegex == null ? null : memoRegex,
        "withdrawFee": withdrawFee == null ? null : withdrawFee,
        "withdrawMin": withdrawMin == null ? null : withdrawMin,
        "withdrawMax": withdrawMax == null ? null : withdrawMax,
        "minConfirm": minConfirm == null ? null : minConfirm,
        "explorer": explorer,
        "isDefault": isDefault == null ? null : isDefault,
        "active": active == null ? null : active,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
