// To parse this JSON data, do
//
//     final mesajlar = mesajlarFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Mesajlar mesajlarFromMap(String str) => Mesajlar.fromMap(json.decode(str));

String mesajlarToMap(Mesajlar data) => json.encode(data.toMap());

class Mesajlar {
    Mesajlar({
        required this.id,
        required this.userFrom,
        required this.userTo,
        required this.content,
        required this.toRead,
        required this.fromDelete,
        required this.toDelete,
        required this.date,
    });

    final String? id;
    final String? userFrom;
    final String? userTo;
    final String? content;
    final String? toRead;
    final String? fromDelete;
    final String? toDelete;
    final DateTime date;

    factory Mesajlar.fromMap(Map<String, dynamic> json) => Mesajlar(
        id: json["id"],
        userFrom: json["user_from"],
        userTo: json["user_to"],
        content: json["content"],
        toRead: json["to_read"],
        fromDelete: json["from_delete"],
        toDelete: json["to_delete"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_from": userFrom,
        "user_to": userTo,
        "content": content,
        "to_read": toRead,
        "from_delete": fromDelete,
        "to_delete": toDelete,
        "date": date.toIso8601String(),
    };
}
