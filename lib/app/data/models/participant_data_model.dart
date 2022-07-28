// To parse this JSON data, do
//
//     final participantDataModel = participantDataModelFromJson(jsonString);

import 'dart:convert';

ParticipantDataModel participantDataModelFromJson(String str) => ParticipantDataModel.fromJson(json.decode(str));

String participantDataModelToJson(ParticipantDataModel data) => json.encode(data.toJson());

class ParticipantDataModel {
  ParticipantDataModel({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  Data? data;

  factory ParticipantDataModel.fromJson(Map<String, dynamic> json) => ParticipantDataModel(
    error: json["error"],
    msg: json["msg"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  Data({
    this.division,
    this.district,
    this.upozila,
    this.unions,
    this.parentName,
    this.relation,
    this.nidPassport,
    this.pMobile,
    this.pAddress,
    this.schoolName,
    this.dataClass,
    this.group,
    this.pGroup,
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.mobile,
    this.dateOfBirth,
    this.type,
    this.registrationStep,
  });

  String? division;
  String? district;
  String? upozila;
  String? unions;
  String? parentName;
  String? relation;
  String? nidPassport;
  String? pMobile;
  String? pAddress;
  String? schoolName;
  String? dataClass;
  String? group;
  String? pGroup;
  int? id;
  String? name;
  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? mobile;
  String? dateOfBirth;
  String? type;
  String?  registrationStep;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    division: json["division"],
    district: json["district"],
    upozila: json["upozila"],
    unions: json["unions"],
    parentName: json["parent_name"],
    relation: json["relation"],
    nidPassport: json["nid_passport"],
    pMobile: json["p_mobile"],
    pAddress: json["p_address"],
    schoolName: json["school_name"],
    dataClass: json["class"],
    group: json["group"],
    pGroup: json["p_group"],
    id: json["id"],
    name: json["name"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    username: json["username"],
    mobile: json["mobile"],
    dateOfBirth: json["date_of_birth"],
    type: json["type"],
    registrationStep: json["registration_step"],
  );

  Map<String, dynamic> toJson() => {
    "division": division,
    "district": district,
    "upozila": upozila,
    "unions": unions,
    "parent_name": parentName,
    "relation": relation,
    "nid_passport": nidPassport,
    "p_mobile": pMobile,
    "p_address": pAddress,
    "school_name": schoolName,
    "class": dataClass,
    "group": group,
    "p_group": pGroup,
    "id": id,
    "name": name,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "username": username,
    "mobile": mobile,
    "date_of_birth": dateOfBirth,
    "type": type,
    "registration_step": registrationStep,
  };
}
