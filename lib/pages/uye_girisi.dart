import 'dart:convert';

import 'package:acikliyorum/api/GoogleSign_api.dart';
import 'package:acikliyorum/api/users_api.dart';
import 'package:acikliyorum/models/user_login_model.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:acikliyorum/pages/main_pages/chat/user_info.dart';
import 'package:acikliyorum/pages/main_pages/home/home_page.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
// import 'package:http/http.dart' as http;
import 'package:acikliyorum/pages/kayit_ol.dart';
import '../models/database_model.dart';
import '../models/user_login_model.dart';

class UyeGiris extends StatefulWidget {
  const UyeGiris({Key? key,}) : super(key: key);


  @override
  State<UyeGiris> createState() => _UyeGirisState();
}

class _UyeGirisState extends State<UyeGiris> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  var dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
  }




  Future<List<Login>> _getUserInfo() async {
    try {
      var response = await Dio().get("https://www.acikliyorum.com/api/json/users.php?email=${_email.text}&pass=${_password.text}");
      List<Login> _userlist = [];
      if(response.statusCode == 200){
        _userlist = (response.data as List).map((e) => Login.fromMap(e)).toList();
        if(_userlist[0].bannedMsg.toString().length>=5){
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text(
                _userlist[0].banFinishTime!.toString()!="Sınırsız"?
                  "Hesabınız ${_userlist[0].banFinishTime!.toString()} tarihine kadar askıya alınmıştır\nEngellenme sebebi:${_userlist[0].bannedMsg!.toString()}":
                    "Hesabınız kapatılmıştır \nKapatılma sebebi sebebi:${_userlist[0].bannedMsg!.toString()}"
              ),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Tamam"))
              ],

            );
          });
        }

        else{
          await dbHelper.insertTodo(UserDb(_userlist[0].id!)).then((userid) => {
            if(userid>0){
              debugPrint("başarılı bir şekilde eklendi: $userid")
            }
          });
          Navigator.pop(context);
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  MainPages(),settings: RouteSettings(arguments: _userlist[0].id)));

        }

            }

            return _userlist;

            } on DioError catch(e) {
      print(e.toString());
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text("Hatalı mail & şifre kombinasyonu"),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            }, child: Text("Kapat"))
          ],

        );
      });
          debugPrint(Future.error(e.message).toString());
          return [];
        }
      }


  var mailKey = GlobalKey<FormFieldState>();
  var pwdKey = GlobalKey<FormFieldState>();




  @override
  Widget build(BuildContext context) {
    bool userLogin = false;
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Image(
            image: AssetImage("assets/logo.png"),
            alignment: Alignment.centerLeft,
            height: 40,
          )),
      body: Container(
          margin: EdgeInsets.only(top: 3),
          decoration: const BoxDecoration(
              color: Colors.white
          ),
          child: _girisBilgileri()),
    );
  }

  _girisBilgileri() {
    bool userLogin = true;
    return ListView(
      children: [
        Container(
            height: 40,
            child: const Center(child: Text(("Email İle Giriş")))),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: mailKey,
            decoration: const InputDecoration(
                hintText: "Email Adresiniz",
                prefixIcon: Icon(FontAwesomeIcons.envelope),
                label: Text("Email"),
                border: OutlineInputBorder()),
            obscureText: false,
            controller: _email,
            onSaved: (deger) {
              _email = deger as TextEditingController;
            },
          ),
        ),
        const SizedBox(
            height: 10
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            key: pwdKey,
            decoration: const InputDecoration(
                hintText: "Şifreniz",
                prefixIcon: Icon(FontAwesomeIcons.unlockKeyhole),
                label: Text("Şifre"),
                border: OutlineInputBorder()),
            obscureText: true,
            controller: _password,
            onSaved: (deger) {
              _password = deger! as TextEditingController;
            },
            validator: (e){

            },
          ),
        ),
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.orange[700],
                ),
                onPressed: () {
                  _getUserInfo();

                },
                icon: const Icon(
                  FontAwesomeIcons.arrowRight,
                  color: Colors.white,
                ),
                label: const Text(
                  "Giriş Yap",
                  style: TextStyle(color: Colors.white),
                )),
          ],
        ),

        const SizedBox(height: 100,),
        Row(children: const <Widget>[
          Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black,
                endIndent: 10,
                indent: 130,
              )),
          Text("Veya"),
          Expanded(
              child: Divider(
                thickness: 1,
                color: Colors.black,
                indent: 10,
                endIndent: 130,
              )),
        ]),
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialLoginButton(
                      height: 44,
                      text: "Google ile Giriş Yap",
                      buttonType: SocialLoginButtonType.google,
                      mode: SocialLoginButtonMode.single,
                      onPressed: () =>singIn()
                  ),

                ],
              ),
            ),
          ],
        )
      ],
    );
  }
  Future singIn() async{
    final user = await GoogleSignApi.login();
    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
    }else{
      Future<List<UserInfo>> userInfo(String email) async {
        try {
          var res = await Dio().get("https://www.acikliyorum.com/api/json/googleSignin.php?email=$email");
          List<UserInfo> _userlist = [];
          if(res.statusCode == 200){
            _userlist = (res.data as List).map((e) => UserInfo.fromMap(e)).toList();

            await dbHelper.insertTodo(UserDb(_userlist[0].id)).then((userid) => {
              if(userid>0){
                debugPrint("başarılı bir şekilde eklendi: $userid")
              }
            });

            if(_userlist[0].email == email.toString()){
              debugPrint("Giris Yapildi");
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPages(),settings: RouteSettings(arguments: _userlist[0].id.toString())));
            }

          }
          return _userlist;
        } on DioError catch(e) {
          debugPrint(Future.error(e.message).toString());
          showDialog(context: context, builder: (context){
            return AlertDialog(
              content: Text("Hatalı kullanıcı adı yada şifre"),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                }, child: Text("Kapat"))
              ],
            );
          });
          return [];
        }
      }
      userInfo(user.email);


    }
  }

}



