import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/api/user_post_api.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/pages/users/inceleme_page.dart';
import 'package:acikliyorum/pages/users/yorum_page.dart';
import 'package:acikliyorum/post/sample_post.dart';
import 'package:acikliyorum/post/user_posts.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main_pages/chat/chat_Content.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {



  bool buttonPressed=false;
  @override
  Widget build(BuildContext context) {

    TabController tabController = TabController(length: 2, vsync: this);
    String userid = ModalRoute.of(context)!.settings.arguments.toString();
    debugPrint("user id = $userid");

    var dbHelper = DbHelper();

    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: FutureBuilder(
        future: dbHelper.kullaniciSorgu("1"),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var myid = snapshot.data!;
            return FutureBuilder<List<UserPostModel>>(
              future: UserPostApi.getUserData(userid),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var response = snapshot.data!;
                  String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${response[0].user.avatar}";
                  String follower = response[0].followers.toString();
                  String userlvl = response[0].user.userLevel.toString();
                  int usrlvl = int.parse(userlvl);
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
                  _ppControl(){
                    if(response[0].user.avatar==null ||response[0].user.avatar==""){
                      return response[0].user.gender=="Erkek"?
                      const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                      const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                    }
                    else{
                      return NetworkImage(userPhotoUrl);
                    }
                  }
                  return Container(
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/background.jpeg"),
                            fit: BoxFit.cover)),
                    child: ListView(
                      children: [
                        Card(
                          child: Column(
                            children: [
                              ListTile(
                                leading: CircleAvatar(
                                    backgroundImage: _ppControl()),
                                title: Text(response[0].user.username.toString()),
                                subtitle: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
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
                              ),

                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                          margin: EdgeInsets.all(7),
                                          height: 60,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              color: Colors.amber,
                                              borderRadius: BorderRadius.circular(5)
                                          ),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text("Takipçiler",style: TextStyle(height: 1,color: Colors.white,fontWeight: FontWeight.w800)),
                                              SizedBox(height: 10,),
                                              Text(follower=="null"?"0":follower,
                                                  style: const TextStyle(height: 1,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w800))
                                            ],)),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          setState((){
                                            buttonPressed==false?
                                                buttonPressed=true:
                                                buttonPressed=false;
                                            debugPrint("${myid.toString()} is follofed to ${userid}");
                                            PostButtonsApi().postFollow(myid.toString(), userid);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(
                                                content: Text('Kullanıcı takip edildi'),

                                              ),
                                            );
                                          });
                                        },
                                        child: buttonPressed==false?
                                        Container(
                                            margin: EdgeInsets.all(7),
                                            height: 60,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade800,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(FontAwesomeIcons.circlePlus,color: Colors.white,),
                                                SizedBox(height: 10,),
                                                Text("Takip Et",style: TextStyle(height: 1,color: Colors.white,fontWeight: FontWeight.w800))

                                              ],)):
                                        Container(
                                            margin: EdgeInsets.all(7),
                                            height: 60,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.blue.shade500,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(FontAwesomeIcons.squareCheck,color: Colors.white,),
                                                SizedBox(height: 10,),
                                                Text("Takip",style: TextStyle(height: 1,color: Colors.white,fontWeight: FontWeight.w800))

                                              ],)),
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        onTap: (){
                                          debugPrint(myid.toString());
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return ChatDetailPage(response[0].user.username.toString(), response[0].user.id.toString(), myid.toString());
                                          }));
                                        },
                                        child: Container(
                                            margin: EdgeInsets.all(7),
                                            height: 60,
                                            width: 100,
                                            decoration: BoxDecoration(
                                                color: Colors.orange[800],
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: const [
                                                Icon(FontAwesomeIcons.commentDots,color: Colors.white,),
                                                SizedBox(height: 10,),
                                                Text("Mesaj Gönder",style: TextStyle(height: 1,color: Colors.white,fontWeight: FontWeight.w800))
                                              ],)),
                                      ),
                                    ),

                                  ],),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => IncelemePage(),settings: RouteSettings(arguments: userid)));

                              }, child: const Text("İnceleme ve Yorumlar",style: TextStyle(color: Colors.white),)),
                        ),


                      ],
                    ),
                  );

                }else if(snapshot.hasError){
                  return Center(child: Text(snapshot.error.toString()),);
                }
                else{
                  return const Center(child: CircularProgressIndicator(),);
                }

              },
            );

          }else{
            return Center(child: CircularProgressIndicator(),);
          }
        },
      )



    );
  }
}
