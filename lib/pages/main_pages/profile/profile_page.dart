import 'dart:io';

import 'package:acikliyorum/ad_helper.dart';
import 'package:acikliyorum/api/single_user.dart';
import 'package:acikliyorum/models/single_user.dart';
import 'package:acikliyorum/pages/login_page_second.dart';
import 'package:acikliyorum/pages/main_pages/find_product/find_post.dart';
import 'package:acikliyorum/pages/main_pages/find_product/post_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/ayarlar_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/destek_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/engellenenler.dart';
import 'package:acikliyorum/pages/main_pages/profile/nasil_calisir.dart';
import 'package:acikliyorum/pages/main_pages/profile/odeme_talep.dart';
import 'package:acikliyorum/pages/main_pages/profile/referans_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/takipciler.dart';
import 'package:acikliyorum/pages/main_pages/profile/unverified_user.dart';

import 'package:acikliyorum/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../users/inceleme_page.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);


  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  //11425
  @override
  Widget build(BuildContext context) {
    var dbHelper = DbHelper();

    return FutureBuilder(
        future: dbHelper.getTodos("1"),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var loginedUser = snapshot.data!;
            return FutureBuilder<List<SingleUserModel>>(
              future: SingleUserApi.getUserData(loginedUser.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!;
                  if(data[0].bannedMsg.toString().length>=5){
                    dbHelper.deleteTodo(1);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondLogin(),));
                  }
                  String email = data[0].email.toString();
                  String username = data[0].username.toString();
                  String balance = data[0].balance.toString();
                  int usrlvl = int.parse(data[0].userLevel.toString());
                  String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[0].avatar}";
                  _ppControl(){
                    if(data[0].avatar==null ||data[0].avatar==""){
                      return data[0].gender=="Erkek"?
                      const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                      const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                    }
                    else{
                      return NetworkImage(userPhotoUrl);
                    }
                  }
                  _userLvlControl(){
                    if(usrlvl <= 5000){
                      return const Icon(FontAwesomeIcons.solidUser,color: Colors.orange,size: 14,);
                    }
                    else if(usrlvl <= 10000){
                      return const Icon(FontAwesomeIcons.userGraduate,color: Colors.yellow,size: 14,);

                    }
                    else if(usrlvl>=10001){
                      return const Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.blue,size: 14,);
                    }
                  }
                  return Container(
                    margin: const EdgeInsets.only(top: 3),
                    color: Colors.white,
                    child: ListView(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(13),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                  image: DecorationImage(image: _ppControl()),
                                  shape: BoxShape.circle
                              ),
                            ),


                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(child: Text(username, style: TextStyle(fontSize: 20))),
                            SizedBox(width: 10,),
                            CircleAvatar(
                              maxRadius: 15,
                              backgroundColor: Colors.grey.shade300,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                maxRadius: 12,
                                child: _userLvlControl(),
                              ),
                            )
                          ],
                        ),
                        Center(child: Text("Kullanıcı Seviyesi : "+ data[0].userLevel.toString())),
                        TextButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.coins,color: Colors.grey,), label: Text(balance.toString())),

                        Column(
                          children: [
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Text("Nasıl Çalışır"),
                                minWidth: 340,
                                height: 30,
                                textColor: Colors.white,
                                color: Colors.orange[700],
                                onPressed: () {
                                  setState(() {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NasilCalisir(),
                                        ));
                                  });
                                }),

                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("İnceleme ve Yorumlarım"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => IncelemePage(),
                                      settings: RouteSettings(arguments: loginedUser.toString())
                                    ));

                              },
                            ),

                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("Takipçiler"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Takip(),
                                      settings: RouteSettings(arguments: data[0].id)
                                    ));
                              },
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("Ödeme Talebi"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                if(double.parse(data[0].balance.toString())<35.0000){
                                  showDialog(context: context, builder: (context){
                                    return AlertDialog(
                                      title: Text("İşlem başarısız"),
                                      content: Text("Ödeme talebi oluşturabilmek için bakiyeniz minimum 35 TL olmalıdır"),
                                      actions: [
                                        TextButton(onPressed: () {
                                          Navigator.pop(context);
                                        }, child: Text("Tamam"))
                                      ],
                                    );
                                  });

                                }else{
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const OdemeTalep(),
                                      settings: RouteSettings(arguments: data[0].id)
                                  ));

                                }


                              },
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("Engellenenler"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => Engellenenler(),
                                settings: RouteSettings(arguments: data[0].id)
                                ));
                              },
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DestekPage(),
                                settings: RouteSettings(arguments: data[0].id)));
                              },
                              child: const Text("İletişim"),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AyarlarPage(),
                                settings: RouteSettings(arguments: data[0].id)));
                              },
                              child: const Text("Ayarlar"),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("Referans"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ReferansPage(data[0].refererKey.toString(), data[0].referer.toString()),));
                              },
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              child: Text("Çıkış Yap"),
                              minWidth: 340,
                              height: 30,
                              textColor: Colors.white,
                              color: Colors.orange[700],
                              onPressed: () {
                                dbHelper.deleteTodo(1);
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondLogin(),));
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Birşeyler ters gitti"),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          }else{
            return const Unverified();
          }

        });


  }

  _bilgiler() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Kullanıcı Adı :",
                style: TextStyle(fontSize: 20),
              ),
              Text("AtakPolat", style: TextStyle(fontSize: 20)),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Mail Adresi :",
                style: TextStyle(fontSize: 20),
              ),
              Text("av.polatatak@gmail.com", style: TextStyle(fontSize: 20)),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Bakiye :",
                style: TextStyle(fontSize: 20),
              ),
              Text("34.589", style: TextStyle(fontSize: 20)),
            ],
          ),
          Divider(
            thickness: 1,
            color: Colors.black54,
          ),
        ],
      ),
    );
  }
}

// class ProfileDemo extends StatelessWidget {
//   const ProfileDemo({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//
//       CustomScrollView(
//       slivers: [
//         SliverAppBar(
//           title: Text("Kullanıcı adı"),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextButton.icon(onPressed: () {}, icon: Icon(FontAwesomeIcons.coins,color: Colors.grey,), label: Text("48.35")),
//             )
//           ],
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             expandedHeight: 200,
//             flexibleSpace: const FlexibleSpaceBar(
//               background: Icon(
//                 Icons.account_circle,
//                 size: 150,
//               ),
//             )),
//
//         SliverList(
//           delegate:  SliverChildListDelegate([
//             TextButton(onPressed: () {}, child: Text("İnceleme Ekle",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("İncelemelerim",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Yorumlarım",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Bakiyem",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Takipçiler",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Takip Edilenler",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Engellenenler",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Mesajlar",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Destek Talepleri",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Ayarlar",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Profilim",style: FontStyles.profileHeader,)),
//             TextButton(onPressed: () {}, child: Text("Çıkış",style: FontStyles.profileHeader,)),
//           ]),
//         ),
//       ],
//     );
//   }
// }
