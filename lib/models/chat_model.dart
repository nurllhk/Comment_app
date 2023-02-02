// To parse this JSON data, do
//
//     final chat = chatFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Chat> chatFromMap(String str) => List<Chat>.from(json.decode(str).map((x) => Chat.fromMap(x)));

String chatToMap(List<Chat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Chat {
    Chat({
        required this.out,
        required this.chatIn,
    });

    final In out;
    final In chatIn;

    factory Chat.fromMap(Map<String, dynamic> json) => Chat(
        out: In.fromMap(json["Out"]),
        chatIn: In.fromMap(json["In"]),
    );

    Map<String, dynamic> toMap() => {
        "Out": out.toMap(),
        "In": chatIn.toMap(),
    };
}

class In {
    In({
        required this.id,
        required this.userFrom,
        required this.userTo,
        required this.content,
        required this.toRead,
        required this.fromDelete,
        required this.toDelete,
        required this.date,
    });

    final String id;
    final String userFrom;
    final String userTo;
    final String content;
    final String toRead;
    final String fromDelete;
    final String toDelete;
    final DateTime date;

    factory In.fromMap(Map<String, dynamic> json) => In(
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
