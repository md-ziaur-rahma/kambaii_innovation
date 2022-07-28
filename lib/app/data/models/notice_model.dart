// To parse this JSON data, do
//
//     final noticeModel = noticeModelFromJson(jsonString);

import 'dart:convert';

NoticeModel noticeModelFromJson(String str) => NoticeModel.fromJson(json.decode(str));

String noticeModelToJson(NoticeModel data) => json.encode(data.toJson());

class NoticeModel {
  NoticeModel({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  List<Notice>? data;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => NoticeModel(
    error: json["error"],
    msg: json["msg"],
    data: List<Notice>.from(json["data"].map((x) => Notice.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Notice {
  Notice({
    this.id,
    this.title,
    this.description,
    this.image,
    this.pdf,
    this.createdBy,
    this.userType,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? title;
  String? description;
  String? image;
  String? pdf;
  int? createdBy;
  String? userType;
  String? createdAt;
  String? updatedAt;

  factory Notice.fromJson(Map<String, dynamic> json) => Notice(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    pdf: json["pdf"],
    createdBy: json["created_by"],
    userType: json["user_type"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "pdf": pdf,
    "created_by": createdBy,
    "user_type": userType,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}
