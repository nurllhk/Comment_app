import 'package:acikliyorum/FutureFunc.dart';
import 'package:acikliyorum/api/GoogleSign_api.dart';
import 'package:acikliyorum/pages/kayit_ol.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:acikliyorum/pages/styles/login_page_styles.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:acikliyorum/pages/uye_girisi.dart';

class SecondLogin extends StatefulWidget {


  @override
  State<SecondLogin> createState() => _SecondLoginState();
}

class _SecondLoginState extends State<SecondLogin> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background.jpeg")
            )
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(
                  width: 330,
                  image: AssetImage("assets/logo.png")),
              SizedBox(height: 80),
              _loginButtonTest(),
              SizedBox(height: 80),
              Row(children: const <Widget>[
                Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                      endIndent: 10,
                      indent: 100,
                    )),
                Text("Veya"),
                Expanded(
                    child: Divider(
                      thickness: 1,
                      color: Colors.black,
                      indent: 10,
                      endIndent: 100,
                    )),
              ]),
              SizedBox(height: 15),
              socialLogins()
            ],
          ),
        ),
      ),
    );
  }



  Row socialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SocialLoginButton(
            height: 44,
            text: "İle Kayıt",
            buttonType: SocialLoginButtonType.google,
            mode: SocialLoginButtonMode.single,
            onPressed: () {
              singIn();

            }),
        SizedBox(width: 10),

      ],
    );
  }

  _loginButtonTest() {
    return Container(
      width: 200,
      child: Column(
        children: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 40),
                  primary: Colors.orange[800],
                  onPrimary: Colors.white),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UyeGiris(),
                      ));
                });
              },
              child: Text("Giriş Yap", style: FontStyles.button,)),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  minimumSize: Size(120, 40),
                  primary: Colors.orange[800],
                  onPrimary: Colors.white),
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => KayitOl(),
                      ));
                });
              },
              child: Text("Kayıt Ol", style: FontStyles.button,)),
          OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.orange[800]!),
                minimumSize: Size(120, 40),
              ),
              onPressed: () {
                setState(() {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MainPages(),
                      ));
                });
              },
              child: Text("Devam",
                style: TextStyle(color: Colors.orange[800]),
              )),
        ],
      ),
    );
  }

  Future singIn() async{
    final user = await GoogleSignApi.login();
    if(user == null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed")));
    }else{
      String replaces = user.displayName.toString().replaceFirst(' ', '');
      debugPrint(replaces.toString());
      Future<String> register(username,email,password,gender,phone) async{
        try{
          var result = Dio().post('https://www.acikliyorum.com/api/json/register.php?username=$username&email=$email&pass=$password&phn=$phone&gender=$gender');
          debugPrint("kayit basarili");
          Navigator.push(context, MaterialPageRoute(builder: (context) => UyeGiris(),));

          return result.toString();
        }

        on DioError catch(e) {
          debugPrint(Future.error(e.message).toString());
          return e.message.toString();
        }

      }
      register(replaces.toString() + 'gml75', user.email, 123456 , "erkek", "phone");
    }
  }

}
