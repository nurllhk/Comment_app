// To parse this JSON data, do
//
//     final singleProductModel = singleProductModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SingleProductModel singleProductModelFromMap(String str) => SingleProductModel.fromMap(json.decode(str));

String singleProductModelToMap(SingleProductModel data) => json.encode(data.toMap());

class SingleProductModel {
  SingleProductModel({
    required this.produtcs,
    required this.categories,
  });

  final Produtcs produtcs;
  final Categories categories;

  factory SingleProductModel.fromMap(Map<String, dynamic> json) => SingleProductModel(
    produtcs: Produtcs.fromMap(json["Produtcs"]),
    categories: Categories.fromMap(json["Categories"]),
  );

  Map<String, dynamic> toMap() => {
    "Produtcs": produtcs.toMap(),
    "Categories": categories.toMap(),
  };
}

class Categories {
  Categories({
    required this.id,
    required this.cId,
    required this.title,
    required this.image,
    required this.seoContent,
    required this.sef,
    required this.rank,
    required this.status,
  });

  final String? id;
  final String? cId;
  final String? title;
  final String? image;
  final String? seoContent;
  final String? sef;
  final String? rank;
  final String? status;

  factory Categories.fromMap(Map<String, dynamic> json) => Categories(
    id: json["id"],
    cId: json["c_id"],
    title: json["title"],
    image: json["image"],
    seoContent: json["seo_content"],
    sef: json["sef"],
    rank: json["rank"],
    status: json["status"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "c_id": cId,
    "title": title,
    "image": image,
    "seo_content": seoContent,
    "sef": sef,
    "rank": rank,
    "status": status,
  };
}

class Produtcs {
  Produtcs({
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

  factory Produtcs.fromMap(Map<String, dynamic> json) => Produtcs(
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
