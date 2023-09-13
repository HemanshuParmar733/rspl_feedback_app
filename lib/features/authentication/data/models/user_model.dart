// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  String? email;
  String? username;
  String? uid;

  UserModel({this.email, this.username, this.uid});

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
  }) =>
      UserModel(
        email: email ?? this.email,
        uid: uid ?? this.uid,
        username: username ?? this.username,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json["email"],
        username: json["username"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "uid": uid,
      };
}
