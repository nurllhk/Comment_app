// To parse this JSON data, do
//
//     final searchModel = searchModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchModel searchModelFromMap(String str) => SearchModel.fromMap(json.decode(str));

String searchModelToMap(SearchModel data) => json.encode(data.toMap());

class SearchModel {
  SearchModel({
    required this.prodcuts,
    required this.categories,
  });

  final Prodcuts prodcuts;
  final String categories;

  factory SearchModel.fromMap(Map<String, dynamic> json) => SearchModel(
    prodcuts: Prodcuts.fromMap(json["Prodcuts"]),
    categories: json["Categories"],
  );

  Map<String, dynamic> toMap() => {
    "Prodcuts": prodcuts.toMap(),
    "Categories": categories,
  };
}

class Prodcuts {
  Prodcuts({
    required this.id,
    required this.addUser,
    required this.cId,
    required this.bId,
    required this.title,
    required this.image,
    required this.price,
    required this.gtinNo,
    required this.sef,
    required this.views,
    required this.status,
  });

  final String? id;
  final String? addUser;
  final String? cId;
  final String? bId;
  final String? title;
  final String? image;
  final String? price;
  final String? gtinNo;
  final String? sef;
  final String? views;
  final String? status;

  factory Prodcuts.fromMap(Map<String, dynamic> json) => Prodcuts(
    id: json["id"],
    addUser: json["add_user"],
    cId: json["c_id"],
    bId: json["b_id"],
    title: json["title"],
    image: json["image"],
    price: json["price"],
    gtinNo: json["gtin_no"],
    sef: json["sef"],
    views: json["views"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "add_user": addUser,
    "c_id": cId,
    "b_id": bId,
    "title": title,
    "image": image,
    "price": price,
    "gtin_no": gtinNo,
    "sef": sef,
    "views": views,
    "status": status,
  };
}
