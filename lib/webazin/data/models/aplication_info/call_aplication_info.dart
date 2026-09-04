class CallApplicationInfo {
  String? code;
  DataApplicationInfo? data;
  String? message;

  CallApplicationInfo({
    this.code,
    this.data,
    this.message,
  });

  CallApplicationInfo.fromJson(Map<String, dynamic> json) {
    code = json['code'].toString();
    data = json['data'] != null ? DataApplicationInfo.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class DataApplicationInfo {
  String? version;
  String? force;
  String? link;
  String? authImg;
  String? title;
  String? description;
  bool? wallet;
  bool? market;
  bool? marketOrder;
  bool? orderPlane;
  bool? portfolio;
  bool? referrals;
  bool? vip;
  bool? discount;
  bool? accreditation;
  bool? reward;
  bool? cooperation;
  bool? metaverse;
  bool? airdrop;
  bool? analysis;

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
  });

  DataApplicationInfo.fromJson(Map<String, dynamic> json) {
    version = json['version'] ?? "1";
    force = json['force'];
    link = json['link'] ?? "";
    authImg = json['auth_img'] ?? "";
    title = json['title'];
    description = json['description'];
    wallet = json['wallet'] ?? false;
    market = json['market'] ?? false;
    marketOrder = json['marketOrder'] ?? false;
    orderPlane = json['orderPlane'] ?? false;
    portfolio = json['portfolio'] ?? false;
    referrals = json['referrals'] ?? false;
    vip = json['vip'] ?? false;
    discount = json['discount'] ?? false;
    accreditation = json['accreditation'] ?? false;
    reward = json['reward'] ?? false;
    cooperation = json['cooperation'] ?? false;
    metaverse = json['metaverse'] ?? false;
    airdrop = json['airdrop'] ?? false;
    analysis = json['analysis'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['version'] = this.version;
    data['force'] = this.force;
    data['link'] = this.link;
    data['auth_img'] = this.authImg;
    data['title'] = this.title;
    data['description'] = this.description;
    data['wallet'] = wallet;
    data['market'] = market;
    data['marketOrder'] = marketOrder;
    data['orderPlane'] = orderPlane;
    data['portfolio'] = portfolio;
    data['referrals'] = referrals;
    data['vip'] = vip;
    data['discount'] = discount;
    data['accreditation'] = accreditation;
    data['reward'] = reward;
    data['cooperation'] = cooperation;
    data['metaverse'] = metaverse;
    data['airdrop'] = airdrop;
    data['analysis'] = analysis;
    return data;
  }
}
