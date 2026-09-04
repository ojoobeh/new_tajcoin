// To parse this JSON data, do
//
//     final callAccreditation = callAccreditationFromMap(jsonString);

import 'dart:convert';

class DataTicket {
  DataTicket({
    this.id,
    this.roleId,
    this.category,
    this.subject,
    this.message,
    this.status,
    this.statusFa,
    this.statusClass,
    this.statusColor,
    this.createdAt,
    this.createdAtFa,
    this.updatedAt,
    this.answers,
  });

  final int? id;
  final String? roleId;
  final String? category;
  final String? subject;
  final String? message;
  final String? status;
  final String? statusFa;
  final String? statusClass;
  final String? statusColor;
  final String? createdAt;
  final String? createdAtFa;
  final String? updatedAt;
  final List<DataAnswer>? answers;

  factory DataTicket.fromJson(String str) => DataTicket.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataTicket.fromMap(Map<String, dynamic> json) => DataTicket(
        id: json["id"] == null ? null : json["id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        category: json["category"] == null ? null : json["category"],
        subject: json["subject"] == null ? null : json["subject"],
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        statusFa: json["status_fa"] == null ? null : json["status_fa"],
        statusClass: json["status_class"] == null ? null : json["status_class"],
        statusColor: json["status_color"] == null ? null : json["status_color"],
        createdAt: json["created_at"] == null ? null : json["created_at"],
        createdAtFa: json["created_at_fa"] == null ? null : json["created_at_fa"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
        answers: json["answers"] == null ? null : List<DataAnswer>.from(json["answers"].map((x) => DataAnswer.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "role_id": roleId == null ? null : roleId,
        "category": category == null ? null : category,
        "subject": subject == null ? null : subject,
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "status_fa": statusFa == null ? null : statusFa,
        "status_class": statusClass == null ? null : statusClass,
        "status_color": statusColor == null ? null : statusColor,
        "created_at": createdAt == null ? null : createdAt,
        "created_at_fa": createdAtFa == null ? null : createdAtFa,
        "updated_at": updatedAt == null ? null : updatedAt,
        "answers": answers == null ? null : List<dynamic>.from(answers!.map((x) => x.toMap())),
      };
}

class DataAnswer {
  DataAnswer({
    this.id,
    this.roleId,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final String? roleId;
  final String? message;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory DataAnswer.fromJson(String str) => DataAnswer.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataAnswer.fromMap(Map<String, dynamic> json) => DataAnswer(
        id: json["id"] == null ? null : json["id"],
        roleId: json["role_id"] == null ? null : json["role_id"],
        message: json["message"] == null ? null : json["message"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id == null ? null : id,
        "role_id": roleId == null ? null : roleId,
        "message": message == null ? null : message,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}

class DataTicketCategory {
  DataTicketCategory({
    this.id,
    this.title,
    this.body,
  });

  final int? id;
  final String? title;
  final String? body;

  factory DataTicketCategory.fromJson(String str) => DataTicketCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataTicketCategory.fromMap(Map<String, dynamic> json) => DataTicketCategory(
    id: json["id"] == null ? null : json["id"],
    title: json["title"] == null ? null : json["title"],
    body: json["body"],
  );

  Map<String, dynamic> toMap() => {
    "id": id == null ? null : id,
    "title": title == null ? null : title,
    "body": body,
  };
}

