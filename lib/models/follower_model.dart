// To parse this JSON data, do
//
//     final followerModel = followerModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FollowerModel followerModelFromMap(String str) => FollowerModel.fromMap(json.decode(str));

String followerModelToMap(FollowerModel data) => json.encode(data.toMap());

class FollowerModel {
  FollowerModel({
    required this.user,
    required this.takipEden,
    required this.takipEdilen,
  });

  final List<TakipEden> user;
  final List<TakipEden> takipEden;
  final List<TakipEden> takipEdilen;

  factory FollowerModel.fromMap(Map<String, dynamic> json) => FollowerModel(
    user: List<TakipEden>.from(json["User"].map((x) => TakipEden.fromMap(x))),
    takipEden: List<TakipEden>.from(json["Takip Eden"].map((x) => TakipEden.fromMap(x))),
    takipEdilen: List<TakipEden>.from(json["Takip Edilen"].map((x) => TakipEden.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "User": List<dynamic>.from(user.map((x) => x.toMap())),
    "Takip Eden": List<dynamic>.from(takipEden.map((x) => x.toMap())),
    "Takip Edilen": List<dynamic>.from(takipEdilen.map((x) => x.toMap())),
  };
}

class TakipEden {
  TakipEden({
    required this.id,
    required this.uId,
    required this.followUser,
    required this.date,
  });

  final String? id;
  final String? uId;
  final String? followUser;
  final DateTime date;

  factory TakipEden.fromMap(Map<String, dynamic> json) => TakipEden(
    id: json["id"],
    uId: json["u_id"],
    followUser: json["follow_user"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "u_id": uId,
    "follow_user": followUser,
    "date": date.toIso8601String(),
  };
}
