// To parse this JSON data, do
//
//     final userTo = userToFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserTo> userToFromMap(String str) => List<UserTo>.from(json.decode(str).map((x) => UserTo.fromMap(x)));

String userToToMap(List<UserTo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserTo {
    UserTo({
        required this.userFrom,
        required this.content,
    });

    final String userFrom;
    final String content;

    factory UserTo.fromMap(Map<String, dynamic> json) => UserTo(
        userFrom: json["user_from"],
        content: json["content"],
    );

    Map<String, dynamic> toMap() => {
        "user_from": userFrom,
        "content": content,
    };
}
