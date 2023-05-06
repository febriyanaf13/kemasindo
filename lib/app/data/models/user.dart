// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

List<User> userFromJson(List lst) =>
    List<User>.from(lst.map((x) => User.fromJson(x)));

String userToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.userid,
    this.username,
    this.nama,
    this.email,
    this.telepon,
    this.initial,
  });

  int? userid;
  String? username;
  String? nama;
  String? email;
  String? telepon;
  String? initial;

  factory User.fromJson(Map<String, dynamic> json) => User(
        userid: json["userid"],
        username: json["username"],
        nama: json["nama"],
        email: json["email"],
        telepon: json["telepon"],
        initial: json["initial"],
      );

  Map<String, dynamic> toJson() => {
        "userid": userid,
        "username": username,
        "nama": nama,
        "email": email,
        "telepon": telepon,
        "initial": initial,
      };
}
