// class DbUser{
//   int? id;
//   String? username;
//   String? userid;
//
//   DbUser(this.username,this.userid);
//
//   DbUser.withID(this.id,this.username,this.userid);
//
//   Map<String,dynamic> toMap(){
//     var map=<String, dynamic>{};
//     map["userid"] = userid;
//     map["username"]=username;
//
//     return map;
//   }
//   DbUser.fromMap(Map<String,dynamic> map){
//     userid=map["userid"];
//     username=map["username"];
//   }
//
//   @override
//   String toString() {
//     return 'User{id: $id, username: $username, userid: $userid}';
//   }
// }



import 'package:flutter/material.dart';

class UserDb {
  int? _id;
  String? _userid;

  UserDb(this._userid);
  UserDb.withId(this._id, this._userid);

  int get id => _id!;
  String get userid => _userid!;


  set userid(String newUser) {
    if (newUser.length <= 255) {
      _userid = newUser;
    }
  }


  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["userid"] = _userid;
    if (_id != null){
      map["id"] = _id;
    }
    return map;
  }


  UserDb.fromObject(dynamic o){
    this._id = o["id"];
    this._userid = o["userid"];
  }
}

