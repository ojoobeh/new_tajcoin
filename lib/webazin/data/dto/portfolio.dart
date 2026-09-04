import 'dart:convert';

import 'package:webazin/webazin/utility/global.dart';


class DataPortfolio {
  DataPortfolio({
    this.id,
    this.symbol,
    this.icon='',
    this.remaining,
    this.unitIrt,
    this.unitUsdt,
    this.unitIrtNow,
    this.unitUsdtNow,
    this.percent,
    this.positive=false,
    this.sumIrt,
    this.sumIrtNow,
    this.sumUsdt,
    this.sumUsdtNow,
    this.position,
    this.irtOscillation,
    this.usdtOscillation,
  });

  final int? id;
  final String? symbol;
  final String icon;
  final double? remaining;
  final String? unitIrt;
  final String? unitUsdt;
  final String? unitIrtNow;
  final String? unitUsdtNow;
  final String? percent;
  final bool positive;
  final String? sumIrt;
  final String? sumIrtNow;
  final String? sumUsdt;
  final String? sumUsdtNow;
  final double? position;
  final String? irtOscillation;
  final String? usdtOscillation;

  factory DataPortfolio.fromJson(String str) => DataPortfolio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataPortfolio.fromMap(Map<String, dynamic> json) => DataPortfolio(
    id: json["id"] == null ? null : json["id"],
    symbol: json["symbol"] == null ? null : json["symbol"],
    icon: json["icon"] == null ? null : json["icon"],
    remaining: doubleFromJson(json, 'remaining'),
    unitIrt: json["unit_irt"] == null ? null : json["unit_irt"],
    unitUsdt: json["unit_usdt"] == null ? null : json["unit_usdt"],
    unitIrtNow: json["unit_irt_now"] == null ? null : json["unit_irt_now"],
    unitUsdtNow: json["unit_usdt_now"] == null ? null : json["unit_usdt_now"],
    percent: json["percent"] == null ? null : json["percent"],
    positive: json["positive"] == null ? null : json["positive"],
    sumIrt: json["sum_irt"] == null ? null : json["sum_irt"],
    sumIrtNow: json["sum_irt_now"] == null ? null : json["sum_irt_now"],
    sumUsdt: json["sum_usdt"] == null ? null : json["sum_usdt"],
    sumUsdtNow: json["sum_usdt_now"] == null ? null : json["sum_usdt_now"],
    position: doubleFromJson(json, 'position'),
    irtOscillation: json["irt_oscillation"] == null ? null : json["irt_oscillation"],
    usdtOscillation: json["usdt_oscillation"] == null ? null : json["usdt_oscillation"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "symbol": symbol == null ? null : symbol,
    "icon": icon == null ? null : icon,
    "remaining": remaining == null ? null : remaining,
    "unit_irt": unitIrt == null ? null : unitIrt,
    "unit_usdt": unitUsdt == null ? null : unitUsdt,
    "unit_irt_now": unitIrtNow == null ? null : unitIrtNow,
    "unit_usdt_now": unitUsdtNow == null ? null : unitUsdtNow,
    "percent": percent == null ? null : percent,
    "positive": positive == null ? null : positive,
    "sum_irt": sumIrt == null ? null : sumIrt,
    "sum_irt_now": sumIrtNow == null ? null : sumIrtNow,
    "sum_usdt": sumUsdt == null ? null : sumUsdt,
    "sum_usdt_now": sumUsdtNow == null ? null : sumUsdtNow,
    "position": position == null ? null : position,
    "irt_oscillation": irtOscillation == null ? null : irtOscillation,
    "usdt_oscillation": usdtOscillation == null ? null : usdtOscillation,
  };
}
