
import 'package:acikliyorum/pages/kayit_ol.dart';
import 'package:acikliyorum/pages/uye_girisi.dart';
import 'package:flutter/material.dart';
import 'package:social_login_buttons/social_login_buttons.dart';


class Unverified extends StatelessWidget {
  const Unverified({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2),
      color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Lütfen önce giriş yapınız",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 20),),
          SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                minimumSize: Size(120, 40),
              primary: Colors.orange[800],
              onPrimary: Colors.white
            ),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => UyeGiris(),));
              },
              child: Text("Giriş Yap")),
          OutlinedButton(
            style: OutlinedButton.styleFrom(

              side: BorderSide(color: Colors.orange[800]!),
              minimumSize: Size(120, 40),

            ),
              onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => KayitOl(),));
              },
              child: Text("Kayıt Ol",style: TextStyle(color: Colors.orange[800]),)),




          SizedBox(height: 100),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}

Row socialLogins() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      SocialLoginButton(
          height: 44,
          text: "İle Bağlan",
          buttonType: SocialLoginButtonType.google,
          mode: SocialLoginButtonMode.single,
          onPressed: () {}),
      SizedBox(
        width: 10,
      ),
      SocialLoginButton(
          height: 44,
          text: "İle Bağlan",
          buttonType: SocialLoginButtonType.facebook,
          mode: SocialLoginButtonMode.single,
          onPressed: () {})
    ],
  );
}
