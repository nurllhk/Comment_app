import 'package:acikliyorum/api/user_post_api.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:acikliyorum/pages/users/inceleme_page.dart';
import 'package:acikliyorum/pages/users/yorum_page.dart';
import 'package:acikliyorum/post/sample_post.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/pages/uye_girisi.dart';

import 'chat_Content.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {

    TabController tabController = TabController(length: 2, vsync: this);
    String userid = ModalRoute.of(context)!.settings.arguments.toString();
    debugPrint("user id = $userid");
    var dbHelper = DbHelper();

    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: FutureBuilder<List<UserPostModel>>(
        future: UserPostApi.getUserData(userid),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var response = snapshot.data!;
            String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${response[0].user.avatar}";
            String follower = response[0].followers.toString();
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
            return ListView(
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: _ppControl()),
                        title: Text(response[0].user.username.toString(),),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: const [
                            CircleAvatar(child: Icon(FontAwesomeIcons.accusoft),),
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
                              child: Container(
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

                                    ],)),
                            ),
                            Expanded(
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

                          ],),
                      )
                    ],
                  ),
                ),
              ],
            );

          }else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }
          else{
            return const Center(child: CircularProgressIndicator(),);
          }

        },
      )
    );
  }
}
