// To parse this JSON data, do
//
//     final userFrom = userFromFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<UserFrom> userFromFromMap(String str) => List<UserFrom>.from(json.decode(str).map((x) => UserFrom.fromMap(x)));

String userFromToMap(List<UserFrom> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserFrom {
    UserFrom({
        required this.userFrom,
        required this.content,
    });

    final String userFrom;
    final String content;

    factory UserFrom.fromMap(Map<String, dynamic> json) => UserFrom(
        userFrom: json["user_from"],
        content: json["content"],
    );

    Map<String, dynamic> toMap() => {
        "user_from": userFrom,
        "content": content,
    };
}
