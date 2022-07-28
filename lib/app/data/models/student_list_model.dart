// To parse this JSON data, do
//
//     final studentListModel = studentListModelFromJson(jsonString);

import 'dart:convert';

StudentListModel studentListModelFromJson(String str) => StudentListModel.fromJson(json.decode(str));

String studentListModelToJson(StudentListModel data) => json.encode(data.toJson());

class StudentListModel {
  StudentListModel({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  List<Student>? data;

  factory StudentListModel.fromJson(Map<String, dynamic> json) => StudentListModel(
    error: json["error"],
    msg: json["msg"],
    data: List<Student>.from(json["data"].map((x) => Student.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "msg": msg,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Student {
  Student({
    this.userId,
    this.firstName,
    this.lastName,
    this.regType,
    this.step,
    this.createdAt,
  });

  int? userId;
  String? firstName;
  String? lastName;
  String? regType;
  String? step;
  DateTime? createdAt;

  factory Student.fromJson(Map<String, dynamic> json) => Student(
    userId: json["user_id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    regType: json["reg_type"],
    step: json["step"],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "first_name": firstName,
    "last_name": lastName,
    "reg_type": regType,
    "step": step,
    "created_at": createdAt?.toIso8601String(),
  };
}
