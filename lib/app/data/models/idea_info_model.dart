// To parse this JSON data, do
//
//     final ideaInfoModel = ideaInfoModelFromJson(jsonString);

import 'dart:convert';

IdeaInfoModel ideaInfoModelFromJson(String str) => IdeaInfoModel.fromJson(json.decode(str));

String ideaInfoModelToJson(IdeaInfoModel data) => json.encode(data.toJson());

class IdeaInfoModel {
  IdeaInfoModel({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  Data? data;

  factory IdeaInfoModel.fromJson(Map<String, dynamic> json) => IdeaInfoModel(
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
    this.participantInfo,
    this.profileInfo,
  });

  ParticipantInfo? participantInfo;
  ProfileInfo? profileInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    participantInfo: ParticipantInfo.fromJson(json["participant_info"]),
    profileInfo: ProfileInfo.fromJson(json["profile_info"]),
  );

  Map<String, dynamic> toJson() => {
    "participant_info": participantInfo?.toJson(),
    "profile_info": profileInfo?.toJson(),
  };
}

class ParticipantInfo {
  ParticipantInfo({
    this.addressInfo,
    this.guardianInfo,
    this.institutonInfo,
    this.teamInfo,
    this.ideaInfo,
  });

  AddressInfo? addressInfo;
  GuardianInfo? guardianInfo;
  InstitutionInfo? institutonInfo;
  TeamInfo? teamInfo;
  IdeaInfo? ideaInfo;

  factory ParticipantInfo.fromJson(Map<String, dynamic> json) => ParticipantInfo(
    addressInfo: AddressInfo.fromJson(json["address_info"]),
    guardianInfo: GuardianInfo.fromJson(json["guardian_info"]),
    institutonInfo: InstitutionInfo.fromJson(json["instituton_info"]),
    teamInfo: TeamInfo.fromJson(json["team_info"]),
    ideaInfo: IdeaInfo.fromJson(json["idea_info"]),
  );

  Map<String, dynamic> toJson() => {
    "address_info": addressInfo?.toJson(),
    "guardian_info": guardianInfo?.toJson(),
    "instituton_info": institutonInfo?.toJson(),
    "team_info": teamInfo?.toJson(),
    "idea_info": ideaInfo?.toJson(),
  };
}

class AddressInfo {
  AddressInfo({
    this.division,
    this.district,
    this.upozila,
    this.unions,
  });

  String? division;
  String? district;
  String? upozila;
  String? unions;

  factory AddressInfo.fromJson(Map<String, dynamic> json) => AddressInfo(
    division: json["division"],
    district: json["district"],
    upozila: json["upozila"],
    unions: json["unions"],
  );

  Map<String, dynamic> toJson() => {
    "division": division,
    "district": district,
    "upozila": upozila,
    "unions": unions,
  };
}

class GuardianInfo {
  GuardianInfo({
    this.parentName,
    this.relation,
    this.nidPassport,
    this.pMobile,
    this.pAddress,
  });

  String? parentName;
  String? relation;
  String? nidPassport;
  String? pMobile;
  String? pAddress;

  factory GuardianInfo.fromJson(Map<String, dynamic> json) => GuardianInfo(
    parentName: json["parent_name"],
    relation: json["relation"],
    nidPassport: json["nid_passport"],
    pMobile: json["p_mobile"],
    pAddress: json["p_address"] ?? "",
  );

  Map<String, dynamic> toJson() => {
    "parent_name": parentName,
    "relation": relation,
    "nid_passport": nidPassport,
    "p_mobile": pMobile,
    "p_address": pAddress ?? "",
  };
}

class IdeaInfo {
  IdeaInfo({
    this.ideaDetails,
    this.imageFile,
    this.pdfFile,
    this.audioFile,
    this.videoFile,
  });

  String? ideaDetails;
  String? imageFile;
  String? pdfFile;
  String? audioFile;
  String? videoFile;

  factory IdeaInfo.fromJson(Map<String, dynamic> json) => IdeaInfo(
    ideaDetails: json["idea_details"],
    imageFile: json["image_file"],
    pdfFile: json["pdf_file"],
    audioFile: json["audio_file"],
    videoFile: json["video_file"],
  );

  Map<String, dynamic> toJson() => {
    "idea_details": ideaDetails,
    "image_file": imageFile,
    "pdf_file": pdfFile,
    "audio_file": audioFile,
    "video_file": videoFile,
  };
}

class InstitutionInfo {
  InstitutionInfo({
    this.schoolName,
    this.institutionInfoClass,
    this.group,
    this.pGroup,
  });

  String? schoolName;
  String? institutionInfoClass;
  String? group;
  String? pGroup;

  factory InstitutionInfo.fromJson(Map<String, dynamic> json) => InstitutionInfo(
    schoolName: json["school_name"],
    institutionInfoClass: json["class"],
    group: json["group"],
    pGroup: json["p_group"],
  );

  Map<String, dynamic> toJson() => {
    "school_name": schoolName,
    "class": institutionInfoClass,
    "group": group,
    "p_group": pGroup,
  };
}

class TeamInfo {
  TeamInfo({
    this.regType,
    this.teamName,
    this.member2,
    this.contact2,
    this.member3,
    this.contact3,
  });

  String? regType;
  String? teamName;
  String? member2;
  String? contact2;
  String? member3;
  String? contact3;

  factory TeamInfo.fromJson(Map<String, dynamic> json) => TeamInfo(
    regType: json["reg_type"],
    teamName: json["team_name"],
    member2: json["member2"],
    contact2: json["contact2"],
    member3: json["member3"],
    contact3: json["contact3"],
  );

  Map<String, dynamic> toJson() => {
    "reg_type": regType,
    "team_name": teamName,
    "member2": member2,
    "contact2": contact2,
    "member3": member3,
    "contact3": contact3,
  };
}

class ProfileInfo {
  ProfileInfo({
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

  int? id;
  String? name;
  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? mobile;
  String? dateOfBirth;
  String? type;
  String? registrationStep;

  factory ProfileInfo.fromJson(Map<String, dynamic> json) => ProfileInfo(
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
