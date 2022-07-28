// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    this.error,
    this.msg,
    this.data,
  });

  bool? error;
  String? msg;
  Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
    this.id,
    this.name,
    this.firstname,
    this.lastname,
    this.email,
    this.username,
    this.mobile,
    this.type,
    this.jwtToken,
  });

  int? id;
  String? name;
  String? firstname;
  String? lastname;
  String? email;
  String? username;
  String? mobile;
  String? type;
  String? registrationStep;
  JwtToken? jwtToken;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    username: json["username"],
    mobile: json["mobile"],
    type: json["type"],
    jwtToken: JwtToken.fromJson(json["jwt_token"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "username": username,
    "mobile": mobile,
    "type": type,
    "jwt_token": jwtToken?.toJson(),
  };
}

class JwtToken {
  JwtToken({
    this.headers,
    this.original,
  });

  Headers? headers;
  Original? original;

  factory JwtToken.fromJson(Map<String, dynamic> json) => JwtToken(
    headers: Headers.fromJson(json["headers"]),
    original: Original.fromJson(json["original"]),
  );

  Map<String, dynamic> toJson() => {
    "headers": headers?.toJson(),
    "original": original?.toJson(),
  };
}

class Headers {
  Headers();

  factory Headers.fromJson(Map<String, dynamic> json) => Headers(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Original {
  Original({
    this.accessToken,
    this.tokenType,
    this.expiresIn,
  });

  String? accessToken;
  String? tokenType;
  int? expiresIn;

  factory Original.fromJson(Map<String, dynamic> json) => Original(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "expires_in": expiresIn,
  };
}
