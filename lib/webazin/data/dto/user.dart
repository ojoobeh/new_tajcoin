// To parse this JSON data, do
//
//     final callAccreditation = callAccreditationFromMap(jsonString);

import 'dart:convert';

class DataUser {
  DataUser({
    this.id,
    this.name,
    this.avatar,
    this.nationalCode,
    this.userName,
    this.birthday,
    this.email,
    this.phone,
    this.mobile,
    this.balance,
    this.docUrl,
    this.type,
    this.levelText,
    this.levelImage,
    this.createdAtFa,
    this.createdAtFaText,
    this.wageP2P,
    this.apiToken,
    this.setting,
    this.accountancy,
    this.password,
    this.code,
    this.passwordConfirmation,
    this.parentId,
    this.info,
    this.vip,
    this.cards,
  });

  final int? id;
  final String? name;
  final String? avatar;
  final String? nationalCode;
  final String? userName;
  final String? birthday;
  final String? email;
  final String? phone;
  final String? mobile;
  final String? balance;
  final String? docUrl;
  final String? type;
  final String? levelText;
  final String? levelImage;
  final String? createdAtFa;
  final String? createdAtFaText;
  final String? wageP2P;
  final String? apiToken;
  final String? password;
  final String? passwordConfirmation;
  final String? code;
  final Setting? setting;
  final int? parentId;
  final Accountancy? accountancy;
  final DataUserInfo? info;
  final Vip? vip;
  final List<DataCards>? cards;

  factory DataUser.fromJson(String str) => DataUser.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataUser.fromMap(Map<String, dynamic> json) => DataUser(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        nationalCode: json["national_code"] == null ? null : json["national_code"],
        userName: json["user_name"] == null ? null : json["user_name"],
        birthday: json["birthday"] == null ? null : json["birthday"],
        email: json["email"] == null ? null : json["email"],
        code: json["code"] == null ? null : json["code"],
        phone: json["phone"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        passwordConfirmation: json["password_confirmation"] == null ? null : json["password_confirmation"],
        balance: json["balance"] == null ? null : (json["balance"])!.toString(),
        docUrl: json["doc_url"] == null ? null : json["doc_url"],
        type: json["type"] == null ? null : json["type"],
        levelText: json["level_text"] == null ? null : json["level_text"],
        levelImage: json["level_image"] == null ? null : json["level_image"],
        parentId: json["parent_id"] == null ? null : json["parent_id"],
        createdAtFa: json["created_at_fa"],
        createdAtFaText: json["created_at_fa_text"],
        wageP2P: json["wage_p2p"],
        apiToken: json["api_token"] == null ? null : json["api_token"],
        setting: json["setting"] == null ? null : Setting.fromMap(json["setting"]),
        accountancy: json["accountancy"] == null ? null : Accountancy.fromMap(json["accountancy"]),
        info: json["info"] == null ? null : DataUserInfo.fromMap(json["info"]),
        vip: json["vip"] == null ? null : Vip.fromMap(json["vip"]),
        cards: json["cards"] == null ? null : List<DataCards>.from(json["cards"].map((x) => DataCards.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "avatar": avatar == null ? null : avatar,
        "national_code": nationalCode == null ? null : nationalCode,
        "user_name": userName == null ? null : userName,
        "birthday": birthday == null ? null : birthday,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "code": code == null ? null : code,
        "password_confirmation": passwordConfirmation == null ? null : passwordConfirmation,
        "phone": phone,
        "mobile": mobile == null ? null : mobile,
        "balance": balance == null ? null : balance,
        "doc_url": docUrl == null ? null : docUrl,
        "parent_id": parentId == null ? null : parentId,
        "type": type == null ? null : type,
        "level_text": levelText == null ? null : levelText,
        "level_image": levelImage == null ? null : levelImage,
        "created_at_fa": createdAtFa,
        "created_at_fa_text": createdAtFaText,
        "wage_p2p": wageP2P,
        "api_token": apiToken == null ? null : apiToken,
        "setting": setting == null ? null : setting!.toMap(),
        "accountancy": accountancy == null ? null : accountancy!.toMap(),
        "info": info == null ? null : info!.toMap(),
        "vip": vip == null ? null : vip!.toMap(),
        "cards": cards == null ? null : List<dynamic>.from(cards!.map((x) => x.toMap())),
      };
}

class Accountancy {
  Accountancy({
    this.dayBuy,
    this.maxBuy,
    this.remaining,
  });

  final int? dayBuy;
  final int? maxBuy;
  final int? remaining;

  factory Accountancy.fromJson(String str) => Accountancy.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Accountancy.fromMap(Map<String, dynamic> json) => Accountancy(
        dayBuy: json["day_buy"] == null ? null : json["day_buy"],
        maxBuy: json["max_buy"] == null ? null : json["max_buy"],
        remaining: json["remaining"] == null ? null : json["remaining"],
      );

  Map<String, dynamic> toMap() => {
        "day_buy": dayBuy == null ? null : dayBuy,
        "max_buy": maxBuy == null ? null : maxBuy,
        "remaining": remaining == null ? null : remaining,
      };
}

class DataCards {
  DataCards({
    this.id,
    this.icon,
    this.bankName,
    this.cardNumber,
    this.accountNumber,
    this.sheba,
    this.status,
    this.statusColor,
  });

  final int? id;
  final String? icon;
  final String? bankName;
  final String? cardNumber;
  final String? accountNumber;
  final String? sheba;
  final String? status;
  final String? statusColor;

  factory DataCards.fromJson(String str) => DataCards.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataCards.fromMap(Map<String, dynamic> json) => DataCards(
        id: json["id"] == null ? null : json["id"],
        icon: json["icon"] == null ? null : json["icon"],
        bankName: json["bank_name"] == null ? null : json["bank_name"],
        cardNumber: json["card_number"] == null ? null : json["card_number"],
        accountNumber: json["account_number"] == null ? null : json["account_number"],
        sheba: json["sheba"] == null ? null : json["sheba"],
        status: json["status"] == null ? null : json["status"],
        statusColor: json["status_color"] == null ? null : json["status_color"],
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "icon": icon == null ? null : icon,
        "bank_name": bankName == null ? null : bankName,
        "card_number": cardNumber == null ? null : cardNumber,
        "account_number": accountNumber == null ? null : accountNumber,
        "sheba": sheba == null ? null : sheba,
        "status": status == null ? null : status,
        "status_color": statusColor == null ? null : statusColor,
      };
}

class DataUserInfo {
  DataUserInfo({
    this.tickets,
  });

  final Tickets? tickets;

  factory DataUserInfo.fromJson(String str) => DataUserInfo.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataUserInfo.fromMap(Map<String, dynamic> json) => DataUserInfo(
        tickets: json["tickets"] == null ? null : Tickets.fromMap(json["tickets"]),
      );

  Map<String, dynamic> toMap() => {
        "tickets": tickets == null ? null : tickets!.toMap(),
      };
}

class Tickets {
  Tickets({
    this.all,
    this.open,
  });

  final int? all;
  final int? open;

  factory Tickets.fromJson(String str) => Tickets.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Tickets.fromMap(Map<String, dynamic> json) => Tickets(
        all: json["all"] == null ? null : json["all"],
        open: json["open"] == null ? null : json["open"],
      );

  Map<String, dynamic> toMap() => {
        "all": all == null ? null : all,
        "open": open == null ? null : open,
      };
}

class Setting {
  Setting({
    this.twoFactorType,
    this.notificationEmail,
    this.notificationSms,
    this.notificationApp,
    this.google2FaSecret,
    this.status,
    this.mobileStatus,
    this.statusText,
    this.statusColor,
    this.docStatus,
    this.phoneStatus,
    this.docStatusFa,
    this.docStatusColor,
    this.cardStatus,
    this.cardStatusColor,
    this.usdPrice,
  });

  final String? twoFactorType;
  final int? notificationEmail;
  final int? notificationSms;
  final int? notificationApp;
  final String? google2FaSecret;
  final bool? status;
  final DateTime? mobileStatus;
  final String? statusText;
  final String? statusColor;
  final String? docStatus;
  final int? phoneStatus;
  final String? docStatusFa;
  final String? docStatusColor;
  final bool? cardStatus;
  final String? cardStatusColor;
  final String? usdPrice;

  factory Setting.fromJson(String str) => Setting.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Setting.fromMap(Map<String, dynamic> json) => Setting(
        twoFactorType: json["two_factor_type"] == null ? null : json["two_factor_type"],
        notificationEmail: json["notification_email"] == null ? null : json["notification_email"],
        notificationSms: json["notification_sms"] == null ? null : json["notification_sms"],
        notificationApp: json["notification_app"] == null ? null : json["notification_app"],
        google2FaSecret: json["google2fa_secret"] == null ? null : (json["google2fa_secret"]).toString(),
        status: json["status"] == null ? null : json["status"],
        mobileStatus: json["mobile_status"] == null ? null : DateTime.parse(json["mobile_status"]),
        statusText: json["status_text"] == null ? null : json["status_text"],
        statusColor: json["status_color"],
        docStatus: json["doc_status"] == null ? null : (json["doc_status"]).toString(),
        phoneStatus: json["phone_status"] == null ? null : json["phone_status"],
        docStatusFa: json["doc_status_fa"] == null ? null : json["doc_status_fa"],
        docStatusColor: json["doc_status_color"] == null ? null : json["doc_status_color"],
        cardStatus: json["card_status"] == null ? null : json["card_status"],
        cardStatusColor: json["card_status_color"] == null ? null : json["card_status_color"],
        usdPrice: json["usd_price"] == null ? null : json["usd_price"],
      );

  Map<String, dynamic> toMap() => {
        "two_factor_type": twoFactorType == null ? null : twoFactorType,
        "notification_email": notificationEmail == null ? null : notificationEmail,
        "notification_sms": notificationSms == null ? null : notificationSms,
        "notification_app": notificationApp == null ? null : notificationApp,
        "google2fa_secret": google2FaSecret == null ? null : google2FaSecret,
        "status": status == null ? null : status,
        "mobile_status": mobileStatus == null ? null : mobileStatus!.toIso8601String(),
        "status_text": statusText == null ? null : statusText,
        "status_color": statusColor,
        "doc_status": docStatus == null ? null : docStatus,
        "phone_status": phoneStatus == null ? null : phoneStatus,
        "doc_status_fa": docStatusFa == null ? null : docStatusFa,
        "doc_status_color": docStatusColor == null ? null : docStatusColor,
        "card_status": cardStatus == null ? null : cardStatus,
        "card_status_color": cardStatusColor == null ? null : cardStatusColor,
        "usd_price": usdPrice == null ? null : usdPrice,
      };
}

class Vip {
  Vip({
    this.active,
    this.days,
  });

  final bool? active;
  final int? days;

  factory Vip.fromJson(String str) => Vip.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Vip.fromMap(Map<String, dynamic> json) => Vip(
        active: json["active"] == null ? null : json["active"],
        days: json["days"] == null ? null : json["days"],
      );

  Map<String, dynamic> toMap() => {
        "active": active == null ? null : active,
        "days": days == null ? null : days,
      };
}
