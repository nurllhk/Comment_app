

import 'package:acikliyorum/api/destek_api.dart';
import 'package:acikliyorum/api/post_apies.dart';
import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/api/user_comment_api.dart';
import 'package:acikliyorum/api/user_post_api.dart';
import 'package:acikliyorum/models/destek_model.dart';
import 'package:acikliyorum/models/user_comment_model.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/pages/users/product_page.dart';
import 'package:acikliyorum/pages/users/user_page.dart';
import 'package:acikliyorum/pages/users/yorum_page.dart';
import 'package:acikliyorum/post/sample_post.dart';
import 'package:acikliyorum/post/user_posts.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class DestekPage extends StatefulWidget {
  const DestekPage({Key? key}) : super(key: key);

  @override
  State<DestekPage> createState() => _DestekPageState();
}

class _DestekPageState extends State<DestekPage> with TickerProviderStateMixin{

  String destekBaslik="İstek";
  String talepBaslik="";
  String content="";
  TextEditingController isim = TextEditingController();
  TextEditingController telefon = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController mesaj = TextEditingController();


  @override
  Widget build(BuildContext context) {
    String userid = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
        appBar: acikliyorumAppBar(),
        body: Container(
          color: Colors.white,
          child: ListView(
            children: [
              ListTile(
                title: Text("İsminiz"),
                subtitle: TextFormField(
                  controller: isim,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              ListTile(
                title: Text("Telefon Numaranız"),
                subtitle: TextFormField(
                  controller: telefon,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              ListTile(
                title: Text("Email Adresiniz"),
                subtitle: TextFormField(
                  controller: mail,
                  decoration: InputDecoration(
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              ListTile(
                title: Text("Konu"),
                subtitle:DropdownButton<String>(
                  isExpanded: true,
                  hint: Text(destekBaslik),
                  items: <String>['İstek','Şikayet',"Hukuki Sorunlar","Öneri","Reklam ve İşbirliği","Diğer"]
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (s){
                    setState(() {
                      destekBaslik = s!;
                      print(destekBaslik);
                    });
                  },
                  value: destekBaslik,
                ),
              ),
              ListTile(
                title: Text("Mesajınız"),
                subtitle: Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: TextFormField(
                    controller: mesaj,
                    minLines: 10,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder()
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ElevatedButton.icon(
                        onPressed: () {
                          debugPrint("name : ${isim.text}");
                          debugPrint("phone : ${telefon.text}");
                          debugPrint("mail : ${mail.text}");
                          debugPrint("header : ${destekBaslik}");
                          debugPrint("content : ${mesaj.text}");
                          PostButtonsApi().sendIletisim("", isim.text, telefon.text, mail.text, destekBaslik, mesaj.text);
                          SnackBar(content: Text("Talebiniz alınmıştır"),);
                          Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_forward,color: Colors.white,),
                        label: Text("Gönder",style: TextStyle(color: Colors.white),)),
                  )
                ],
              )

            ],
          ),
        )


    );


  }

}
