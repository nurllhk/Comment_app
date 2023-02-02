import 'package:acikliyorum/api/follower_api.dart';
import 'package:acikliyorum/api/single_user.dart';
import 'package:acikliyorum/models/follower_model.dart';
import 'package:acikliyorum/models/single_user.dart';
import 'package:acikliyorum/pages/users/user_page.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Takip extends StatefulWidget {
  const Takip({Key? key}) : super(key: key);

  @override
  State<Takip> createState() => _TakipState();
}

class _TakipState extends State<Takip> {
  @override
  Widget build(BuildContext context) {
    String userLoginId = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const Divider(height: 1,),
              Container(
                color: Colors.white,
                child: const TabBar(

                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  tabs: [
                    Tab(text: "Takipçilerim"),
                    Tab(text: "Takip Ettiklerim"),

                  ],
                ),
              ),
              Flexible(
                child: Container(
                    width: double.maxFinite,
                    height: 490,
                    child: TabBarView(
                      children: [
                        _falower(userLoginId),
                        _falowing(userLoginId)

                      ],
                    )),
              )
            ],
          )),
    );
  }

  _falower(String mainUserID) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
      ),
      child: FutureBuilder<List<FollowerModel>>(
        future: FollowerApi.getReviewsData(mainUserID),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data[0].takipEdilen.length,
              itemBuilder: (context, index) {
                return FutureBuilder<List<SingleUserModel>>(
                  future: SingleUserApi.getUserData(data[0].takipEdilen[index].uId.toString()),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      String userid = data[0].id.toString();
                      String userName = data[0].username.toString();
                      String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[0].avatar}";
                      String userlvl = data[0].userLevel.toString();
                      int usrlvl = int.parse(userlvl);
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
                          return const Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.blue,size: 14,);
                        }
                        else if(usrlvl <= 10000){
                          return const Icon(FontAwesomeIcons.userGraduate,color: Colors.yellow,size: 14,);

                        }
                        else if(usrlvl>=10001){
                          return const Icon(FontAwesomeIcons.solidUser,color: Colors.orange,size: 14,);
                        }

                      }
                      return Card(
                        color: Colors.white,
                        child: Column(children: [
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(),
                              settings: RouteSettings(arguments: userid)
                              ));
                            },
                            leading: CircleAvatar(backgroundImage: _ppControl(),),
                            title: Text(userName),
                            subtitle: Row(
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
                          )
                        ],),
                      );
                    }else if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),);
                    }else{
                      return Center(child: CircularProgressIndicator(),);
                    }


                },);


            },);
          }else if(snapshot.hasError){
            return Center(child: Text("Henüz takipçiniz bulunmamakta"),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }


      },),
    );
  }

  //"3156"

  _falowing(String mainUserID) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
      ),
      child: FutureBuilder<List<FollowerModel>>(
        future: FollowerApi.getReviewsData(mainUserID),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data[0].takipEden.length,
              itemBuilder: (context, index) {
                return FutureBuilder<List<SingleUserModel>>(
                  future: SingleUserApi.getUserData(data[0].takipEden[index].followUser.toString()),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      String userid = data[0].id.toString();
                      String userName = data[0].username.toString();
                      String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[0].avatar}";
                      String userlvl = data[0].userLevel.toString();
                      int usrlvl = int.parse(userlvl);
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
                          return const Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.blue,size: 14,);
                        }
                        else if(usrlvl <= 10000){
                          return const Icon(FontAwesomeIcons.userGraduate,color: Colors.yellow,size: 14,);

                        }
                        else if(usrlvl>=10001){
                          return const Icon(FontAwesomeIcons.solidUser,color: Colors.orange,size: 14,);
                        }

                      }
                      return Card(
                        color: Colors.white,
                        child: Column(children: [
                          ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => UserPage(),
                                  settings: RouteSettings(arguments: userid)
                              ));
                            },
                            leading: CircleAvatar(backgroundImage: _ppControl(),),
                            title: Text(userName),
                            subtitle: Row(
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
                          )
                        ],),
                      );
                    }else if(snapshot.hasError){
                      return Center(child: Text(snapshot.error.toString()),);
                    }else{
                      return Container();
                    }


                  },);


              },);
          }
          else if(snapshot.hasError){
            return Center(child: Text("Henüz kimseyi takip etmiyorsunuz"),);
          }else{
            return Center(child: CircularProgressIndicator(),);
          }


        },),
    );
  }
}
