// To parse this JSON data, do
//
//     final callAccreditation = callAccreditationFromMap(jsonString);

import 'dart:convert';


class DataApplicationInfo {
  DataApplicationInfo({
    this.version,
    this.force,
    this.link,
    this.authImg,
    this.title,
    this.description,
    this.wallet,
    this.market,
    this.marketOrder,
    this.orderPlane,
    this.portfolio,
    this.referrals,
    this.vip,
    this.discount,
    this.accreditation,
    this.reward,
    this.cooperation,
    this.metaverse,
    this.airdrop,
    this.analysis,
    this.message,
    this.slides,
    this.popup,
  });

  final String? version;
  final String? force;
  final String? link;
  final String? authImg;
  final String? title;
  final String? description;
  final bool? wallet;
  final bool? market;
  final bool? marketOrder;
  final bool? orderPlane;
  final bool? portfolio;
  final bool? referrals;
  final bool? vip;
  final bool? discount;
  final bool? accreditation;
  final bool? reward;
  final bool? cooperation;
  final bool? metaverse;
  final bool? airdrop;
  final bool? analysis;
  final String? message;
  final List<DataSlider>? slides;
  final DataPopup? popup;

  factory DataApplicationInfo.fromJson(String str) => DataApplicationInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataApplicationInfo.fromMap(Map<String, dynamic> json) => DataApplicationInfo(
    version: json["version"] == null ? null : json["version"],
    force: json["force"] == null ? null : json["force"],
    link: json["link"] == null ? null : json["link"],
    authImg: json["auth_img"] == null ? null : json["auth_img"],
    title: json["title"] == null ? null : json["title"],
    description: json["description"] == null ? null : json["description"],
    wallet: json["wallet"] == null ? null : json["wallet"],
    market: json["market"] == null ? null : json["market"],
    marketOrder: json["marketOrder"] == null ? null : json["marketOrder"],
    orderPlane: json["orderPlane"] == null ? null : json["orderPlane"],
    portfolio: json["portfolio"] == null ? null : json["portfolio"],
    referrals: json["referrals"] == null ? null : json["referrals"],
    vip: json["vip"] == null ? null : json["vip"],
    discount: json["discount"] == null ? null : json["discount"],
    accreditation: json["accreditation"] == null ? null : json["accreditation"],
    reward: json["reward"] == null ? null : json["reward"],
    cooperation: json["cooperation"] == null ? null : json["cooperation"],
    metaverse: json["metaverse"] == null ? null : json["metaverse"],
    airdrop: json["airdrop"] == null ? null : json["airdrop"],
    analysis: json["analysis"] == null ? null : json["analysis"],
    message: json["message"],
    slides: json["slides"] == null ? null : List<DataSlider>.from(json["slides"].map((x) => DataSlider.fromMap(x))),
    popup: json["popup"] == null ? null : DataPopup.fromMap(json["popup"]),
  );

  Map<String, dynamic> toMap() => {
    "version": version == null ? null : version,
    "force": force == null ? null : force,
    "link": link == null ? null : link,
    "auth_img": authImg == null ? null : authImg,
    "title": title == null ? null : title,
    "description": description == null ? null : description,
    "wallet": wallet == null ? null : wallet,
    "market": market == null ? null : market,
    "marketOrder": marketOrder == null ? null : marketOrder,
    "orderPlane": orderPlane == null ? null : orderPlane,
    "portfolio": portfolio == null ? null : portfolio,
    "referrals": referrals == null ? null : referrals,
    "vip": vip == null ? null : vip,
    "discount": discount == null ? null : discount,
    "accreditation": accreditation == null ? null : accreditation,
    "reward": reward == null ? null : reward,
    "cooperation": cooperation == null ? null : cooperation,
    "metaverse": metaverse == null ? null : metaverse,
    "airdrop": airdrop == null ? null : airdrop,
    "analysis": analysis == null ? null : analysis,
    "message": message,
    "slides": slides == null ? null : List<dynamic>.from(slides!.map((x) => x.toMap())),
    "popup": popup == null ? null : popup!.toMap(),
  };
}

class DataPopup {
  DataPopup({
    this.id,
    this.image,
    this.link,
    this.title,
    this.message,
  });

  final String? id;
  final String? image;
  final String? link;
  final String? title;
  final String? message;

  factory DataPopup.fromJson(String str) => DataPopup.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataPopup.fromMap(Map<String, dynamic> json) => DataPopup(
    id: json["id"] == null ? null : json["id"],
    image: json["image"] == null ? null : json["image"],
    link: json["link"] == null ? null : json["link"],
    title: json["title"] == null ? null : json["title"],
    message: json["message"] == null ? null : json["message"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "image": image == null ? null : image,
    "link": link == null ? null : link,
    "title": title == null ? null : title,
    "message": message == null ? null : message,
  };
}

class DataSlider {
  DataSlider({
    this.id,
    this.link,
    this.category,
    this.title,
    this.slug,
    this.image,
    this.shortBody,
    this.body,
    this.createdAt,
  });

  final int? id;
  final String? link;
  final String? category;
  final String? title;
  final String? slug;
  final String? image;
  final String? shortBody;
  final String? body;
  final String? createdAt;

  factory DataSlider.fromJson(String str) => DataSlider.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataSlider.fromMap(Map<String, dynamic> json) => DataSlider(
    id: json["id"] == null ? null : json["id"],
    link: json["link"] == null ? null : json["link"],
    category: json["category"] == null ? null : json["category"],
    title: json["title"] == null ? null : json["title"],
    slug: json["slug"] == null ? null : json["slug"],
    image: json["image"] == null ? null : json["image"],
    shortBody: json["short_body"] == null ? null : json["short_body"],
    body: json["body"] == null ? null : json["body"],
    createdAt: json["created_at"] == null ? null : json["created_at"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "link": link == null ? null : link,
    "category": category == null ? null : category,
    "title": title == null ? null : title,
    "slug": slug == null ? null : slug,
    "image": image == null ? null : image,
    "short_body": shortBody == null ? null : shortBody,
    "body": body == null ? null : body,
    "created_at": createdAt == null ? null : createdAt,
  };
}


