
import 'dart:convert';

List<UserInfo> userInfoFromMap(String str) => List<UserInfo>.from(json.decode(str).map((x) => UserInfo.fromMap(x)));

String userInfoToMap(List<UserInfo> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class UserInfo {
    UserInfo({
        required this.username,
        required this.email,
        required this.balance,
        required this.id,
        required this.avatar,
        required this.gender,
    });

    final String username;
    final String email;
    final String balance;
    final String id;
    final String? avatar;
    final String? gender;

    factory UserInfo.fromMap(Map<String, dynamic> json) => UserInfo(
        username: json["username"],
        email: json["email"],
        balance: json["balance"],
        id: json["id"],
        avatar: json["avatar"],
        gender: json["gender"],
    );

    Map<String, dynamic> toMap() => {
        "username": username,
        "email": email,
        "balance": balance,
        "id": id,
        "avatar":avatar,
        "gender":gender,
    };
}