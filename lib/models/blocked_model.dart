// To parse this JSON data, do
//
//     final blockedModel = blockedModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

BlockedModel blockedModelFromMap(String str) => BlockedModel.fromMap(json.decode(str));

String blockedModelToMap(BlockedModel data) => json.encode(data.toMap());

class BlockedModel {
  BlockedModel({
    required this.engelleyen,
    required this.engellenen,
  });

  final Engelleyen engelleyen;
  final Engellenen engellenen;

  factory BlockedModel.fromMap(Map<String, dynamic> json) => BlockedModel(
    engelleyen: Engelleyen.fromMap(json["Engelleyen"]),
    engellenen: Engellenen.fromMap(json["Engellenen"]),
  );

  Map<String, dynamic> toMap() => {
    "Engelleyen": engelleyen.toMap(),
    "Engellenen": engellenen.toMap(),
  };
}

class Engellenen {
  Engellenen({
    required this.id,
    required this.activationKey,
    required this.referer,
    required this.refererKey,
    required this.username,
    required this.phone,
    required this.bankNumber,
    required this.email,
    required this.avatar,
    required this.gender,
    required this.balance,
    required this.userLevel,
    required this.password,
    required this.passwordHash,
    required this.bannedMsg,
    required this.banFinishTime,
    required this.sef,
    required this.lastLogin,
    required this.lastIp,
    required this.registerIp,
    required this.registerDate,
    required this.firstReviewStep,
    required this.timepayTime,
    required this.editor,
    required this.copyReviews,
    required this.rejectedReviews,
    required this.status,
  });

  final String? id;
  final String? activationKey;
  final String? referer;
  final String? refererKey;
  final String? username;
  final String? phone;
  final dynamic bankNumber;
  final String? email;
  final dynamic avatar;
  final String? gender;
  final String? balance;
  final String? userLevel;
  final String? password;
  final dynamic passwordHash;
  final String? bannedMsg;
  final String? banFinishTime;
  final String? sef;
  final DateTime lastLogin;
  final String? lastIp;
  final String? registerIp;
  final DateTime registerDate;
  final String? firstReviewStep;
  final String? timepayTime;
  final String? editor;
  final String? copyReviews;
  final String? rejectedReviews;
  final String? status;

  factory Engellenen.fromMap(Map<String, dynamic> json) => Engellenen(
    id: json["id"],
    activationKey: json["activation_key"],
    referer: json["referer"],
    refererKey: json["referer_key"],
    username: json["username"],
    phone: json["phone"],
    bankNumber: json["bank_number"],
    email: json["email"],
    avatar: json["avatar"],
    gender: json["gender"],
    balance: json["balance"],
    userLevel: json["user_level"],
    password: json["password"],
    passwordHash: json["password_hash"],
    bannedMsg: json["banned_msg"],
    banFinishTime: json["ban_finish_time"],
    sef: json["sef"],
    lastLogin: DateTime.parse(json["last_login"]),
    lastIp: json["last_ip"],
    registerIp: json["register_ip"],
    registerDate: DateTime.parse(json["register_date"]),
    firstReviewStep: json["first_review_step"],
    timepayTime: json["timepay_time"],
    editor: json["editor"],
    copyReviews: json["copy_reviews"],
    rejectedReviews: json["rejected_reviews"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "activation_key": activationKey,
    "referer": referer,
    "referer_key": refererKey,
    "username": username,
    "phone": phone,
    "bank_number": bankNumber,
    "email": email,
    "avatar": avatar,
    "gender": gender,
    "balance": balance,
    "user_level": userLevel,
    "password": password,
    "password_hash": passwordHash,
    "banned_msg": bannedMsg,
    "ban_finish_time": banFinishTime,
    "sef": sef,
    "last_login": lastLogin.toIso8601String(),
    "last_ip": lastIp,
    "register_ip": registerIp,
    "register_date": registerDate.toIso8601String(),
    "first_review_step": firstReviewStep,
    "timepay_time": timepayTime,
    "editor": editor,
    "copy_reviews": copyReviews,
    "rejected_reviews": rejectedReviews,
    "status": status,
  };
}

class Engelleyen {
  Engelleyen({
    required this.id,
    required this.uId,
    required this.blockedUser,
    required this.date,
  });

  final String? id;
  final String? uId;
  final String? blockedUser;
  final DateTime date;

  factory Engelleyen.fromMap(Map<String, dynamic> json) => Engelleyen(
    id: json["id"],
    uId: json["u_id"],
    blockedUser: json["blocked_user"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "u_id": uId,
    "blocked_user": blockedUser,
    "date": date.toIso8601String(),
  };
}
