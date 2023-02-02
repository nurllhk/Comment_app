// To parse this JSON data, do
//
//     final notifications = notificationsFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Notifications> notificationsFromMap(String str) => List<Notifications>.from(json.decode(str).map((x) => Notifications.fromMap(x)));

String notificationsToMap(List<Notifications> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Notifications {
    Notifications({
        required this.id,
        required this.uId,
        required this.type,
        required this.title,
        required this.guid,
        required this.status,
        required this.date,
    });

    final String id;
    final String uId;
    final String type;
    final String title;
    final String guid;
    final String status;
    final DateTime date;

    factory Notifications.fromMap(Map<String, dynamic> json) => Notifications(
        id: json["id"],
        uId: json["u_id"],
        type: json["type"],
        title: json["title"],
        guid: json["guid"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "u_id": uId,
        "type": type,
        "title": title,
        "guid": guid,
        "status": status,
        "date": date.toIso8601String(),
    };
}
