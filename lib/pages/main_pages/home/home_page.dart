
import 'dart:async';

import 'package:acikliyorum/api/reviews_api.dart';
import 'package:acikliyorum/models/reviews_model.dart';
import 'package:acikliyorum/post/user_posts.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/post/sample_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var dbHelper = DbHelper();

  @override
  // void initState() {
  //   super.initState();
  //   Timer.periodic(const Duration(seconds: 4), (timer) {
  //     dbHelper.getBalance("1");
  //   });
  // }


  @override
  Widget build(BuildContext context) {

    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background.jpeg")
            )
        ),

        child: Post()
    );


  }



}

_haftaninUrunu() {
  return Card(
    margin: EdgeInsets.only(top: 3),
    child: Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          title: Text("Haftanın Ürünü"),
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.orange[700],
            ),
            height: 35,
            width: 35,

            child: Icon(FontAwesomeIcons.bagShopping,color: Colors.white,),
          ),
        ),
        Divider(height: 2,),
        ListTile(
          tileColor: Colors.white,
            leading: Image(
              image: AssetImage("assets/category_icons/category_araclar.webp"),
            ),
            title: Text("Doom Eternal video game",style: FontStyles.homeContentH,),
            subtitle: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        Card(
                          color: Colors.lightBlue,
                          child: Icon(
                            Icons.info_rounded,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Dijital Oyunlar",
                          style: FontStyles.homeContent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Card(
                    color: Colors.grey.shade300,
                    child: Row(
                      children: [
                        Card(
                          color: Colors.yellow[600],
                          child: Icon(
                            Icons.star,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "5.0",
                          style: FontStyles.homeContent,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


        ),
      ],
    ),
  );
}

_haftaninMarkasi() {
  return Card(
    margin: EdgeInsets.all(3),
    child: Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          title: Text("Haftanın Markası"),
          leading: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Colors.orange[700]),
            height: 35,
            width: 35,
            child: Icon(FontAwesomeIcons.tags,color: Colors.white,),
          ),
        ),
        Divider(height: 2,),
        ListTile(
          tileColor: Colors.white,
          leading: Image(
            image: AssetImage("assets/category_icons/category_spesifik.webp"),
          ),
          title: Text("Lorem ipsum",style: FontStyles.homeContentH,),
          subtitle: Card(

            color: Colors.grey.shade300,
            child: Row(
              children: [
                Card(
                  color: Colors.yellow[600],
                  child: Icon(
                    Icons.star,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "5.0",
                  style: FontStyles.homeContent,
                ),
              ],
            ),
          ),


        ),
      ],
    ),
  );
}

_haftaninYazari() {
  return Card(
    margin: EdgeInsets.all(3),
    child: Column(
      children: [
        ListTile(
          tileColor: Colors.white,
          title: Text("Haftanın Yazarı"),
          leading: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: Colors.orange[700]),
            child: Icon(FontAwesomeIcons.star,color: Colors.white,),
          ),
        ),
        Divider(height: 1,),
        ListTile(
          tileColor: Colors.white,
          leading: Image(
            image: AssetImage("assets/category_icons/category_anne-bebek.webp"),
          ),
          title: Text("Kullanıcı Adı",style: FontStyles.homeContentH,),
          subtitle: Row(
            children: [
              CircleAvatar(child: Icon(
                FontAwesomeIcons.circleCheck,
                color: Colors.white,
                size: 25,
              ),
              backgroundColor: Colors.blue,
                maxRadius: 15,
              ),
            ],
          )


        ),
      ],
    ),
  );
}


