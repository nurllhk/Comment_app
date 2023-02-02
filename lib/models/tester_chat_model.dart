// To parse this JSON data, do
//
//     final testerChatModel = testerChatModelFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

TesterChatModel testerChatModelFromMap(String str) => TesterChatModel.fromMap(json.decode(str));

String testerChatModelToMap(TesterChatModel data) => json.encode(data.toMap());

class TesterChatModel {
  TesterChatModel({
    required this.userForm,
    required this.userTo,
    required this.content,
  });

  final String? userForm;
  final String? userTo;
  final String? content;

  factory TesterChatModel.fromMap(Map<String, dynamic> json) => TesterChatModel(
    userForm: json["user_form"],
    userTo: json["user_to"],
    content: json["content"],
  );

  Map<String, dynamic> toMap() => {
    "user_form": userForm,
    "user_to": userTo,
    "content": content,
  };
}
