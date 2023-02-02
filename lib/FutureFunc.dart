import 'dart:convert';

import 'package:acikliyorum/models/GidenMesaj_model.dart';
import 'package:acikliyorum/models/Mesajlar_model.dart';
import 'package:acikliyorum/models/products_model.dart';
import 'package:acikliyorum/pages/main_pages/chat/user_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'models/GelenMesajlar_model.dart';
import 'models/Mesajlar_model.dart';
import 'models/Notifications.model.dart';

class Fonksiyonlar{
  String id ; 
  Fonksiyonlar(this.id);

  Future<List<UserInfo>> gelenMesajlar(id) async {
    try {
      var response = await Dio().get("https://www.acikliyorum.com/api/json/GelenMesajlar.php?id=$id");
      List<UserFrom> _userlist = [];
      List<UserInfo> _user = [];
      
      
      if(response.statusCode == 200){
        _userlist = (response.data as List).map((e) => UserFrom.fromMap(e)).toList();
        for(int i = 0 ; i<_userlist.length; i++){
          
          var res = await Dio().get("https://www.acikliyorum.com/api/json/user_info.php?id=${_userlist[i].userFrom}");
          _user.addAll((res.data as List).map((e) => UserInfo.fromMap(e)).toList());
        }
        debugPrint(_user.length.toString());
        
      }
      
      return _user;
    } on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return [];
    }
  }
  Future<List<UserTo>> gidenMesajlar(id) async {
    try {
      var response = await Dio().get("https://www.acikliyorum.com/api/json/GidenMesajlar.php?id=$id");
      List<UserTo> _userlist = [];
      if(response.statusCode == 200){
        _userlist = (response.data as List).map((e) => UserTo.fromMap(e)).toList();
      }
      
      return _userlist;
    } on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return [];
    }
  }

  Future<List<Mesajlar>> message(id) async {
    try {
        var response = await Dio().get("https://www.acikliyorum.com/api/json/mesajlar.php?id=$id");
        List<Mesajlar> _userlist = [];
        if(response.statusCode == 200){
          _userlist = (response.data as List).map((e) => Mesajlar.fromMap(e)).toList();
        }

        return _userlist;
    } on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return [];
    }
  }

  Future<List<UserInfo>> userInfo(id) async {
    

    try {
      var res = await Dio().get("https://www.acikliyorum.com/api/json/user_info.php?id=$id");
      List<UserInfo> _userlist = [];
      if(res.statusCode == 200){
        _userlist = (res.data as List).map((e) => UserInfo.fromMap(e)).toList();
        
      }
      
      return _userlist;
    } on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return [];
    }
  }
  Future<List<Notifications>> notification(id) async {
    

    try {
      var res = await Dio().get("https://www.acikliyorum.com/api/json/notifications.php?id=$id");
      List<Notifications> _userlist = [];
      if(res.statusCode == 200){
        _userlist = (res.data as List).map((e) => Notifications.fromMap(e)).toList();
        
      }
      
      return _userlist;
    } on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return [];
    }
  }
  
}
class Fonksiyonlar1{
  Future<String> Register(username,email,password,gender,phone) async{
    try{
      var result = Dio().post('https://www.acikliyorum.com/api/json/register.php?username=$username&email=$email&pass=$password&phn=$phone&gender=$gender');
      return result.toString();
    }
    on DioError catch(e) {
      debugPrint(Future.error(e.message).toString());
      return e.message.toString();
  }

}


}