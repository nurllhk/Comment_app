
import 'dart:convert';

DestekModel destekModelFromMap(String str) => DestekModel.fromMap(json.decode(str));

String destekModelToMap(DestekModel data) => json.encode(data.toMap());

class DestekModel {
  DestekModel({
    required this.id,
    required this.uId,
    required this.type,
    required this.reviewId,
    required this.title,
    required this.content,
    required this.creationDate,
    required this.updateDate,
    required this.toAdmin,
    required this.status,
  });

  final String? id;
  final String? uId;
  final String? type;
  final String? reviewId;
  final String? title;
  final String? content;
  final DateTime creationDate;
  final DateTime updateDate;
  final String? toAdmin;
  final String? status;

  factory DestekModel.fromMap(Map<String, dynamic> json) => DestekModel(
    id: json["id"],
    uId: json["u_id"],
    type: json["type"],
    reviewId: json["review_id"],
    title: json["title"],
    content: json["content"],
    creationDate: DateTime.parse(json["creation_date"]),
    updateDate: DateTime.parse(json["update_date"]),
    toAdmin: json["to_admin"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "u_id": uId,
    "type": type,
    "review_id": reviewId,
    "title": title,
    "content": content,
    "creation_date": creationDate.toIso8601String(),
    "update_date": updateDate.toIso8601String(),
    "to_admin": toAdmin,
    "status": status,
  };
}
