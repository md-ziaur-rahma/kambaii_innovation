// To parse this JSON data, do
//
//     final regStep1Model = regStep1ModelFromJson(jsonString);

import 'dart:convert';

RegStep1Model regStep1ModelFromJson(String str) => RegStep1Model.fromJson(json.decode(str));

String regStep1ModelToJson(RegStep1Model data) => json.encode(data.toJson());

class RegStep1Model {
  RegStep1Model({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  Data? data;

  factory RegStep1Model.fromJson(Map<String, dynamic> json) => RegStep1Model(
    error: json["error"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": data!.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.name,
    this.username,
    this.mobile,
    this.usertype,
    this.registrationStep,
    this.token,
  });

  int? id;
  String? name;
  String? username;
  String? mobile;
  String? usertype;
  String? registrationStep;
  int? token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    mobile: json["mobile"],
    usertype: json["usertype"],
    registrationStep: json["registration_step"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "mobile": mobile,
    "usertype": usertype,
    "registration_step": registrationStep,
    "token": token,
  };
}
