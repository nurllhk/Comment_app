import 'package:acikliyorum/FutureFunc.dart';
import 'package:acikliyorum/api/messages_page_api.dart';
import 'package:acikliyorum/api/single_user.dart';
import 'package:acikliyorum/models/GelenMesajlar_model.dart';
import 'package:acikliyorum/models/GidenMesaj_model.dart';
import 'package:acikliyorum/models/messages_page_model.dart';
import 'package:acikliyorum/models/single_user.dart';
import 'package:acikliyorum/pages/main_pages/chat/user_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import '../profile/unverified_user.dart';
import 'chat_Content.dart';
import 'package:acikliyorum/utils/database_helper.dart';

class ChatPage extends StatefulWidget {
  String id;
  ChatPage(this.id);


  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  

  late final Future<List<UserInfo>> _gelenMsj;
  
  @override
  void initState() {
    super.initState();
    _gelenMsj = Fonksiyonlar(widget.id.toString()).gelenMesajlar(widget.id.toString());
    debugPrint(widget.id);
  }
  @override

  List useridlist=[];
  List denemelist=[];



  Widget build(BuildContext context) {
    var dbHelper = DbHelper();
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
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
        ),
        child: FutureBuilder(
          future: dbHelper.kullaniciSorgu("1"),
          builder: (context,snapshot){
            if(snapshot.hasData){
              return FutureBuilder<List<MessagesPageModel>>(
                  future: MessagesPageApi.getReviewsData(widget.id),
                  builder: (context,snapshot){
                    if(snapshot.hasData){
                      var data = snapshot.data!;
                      for(var i = 0;i<=data.length-1;i++){
                        if(denemelist.contains(data[i].userTo)==false){
                          denemelist.add(data[i].userTo);
                        }if(denemelist.contains(data[i].userFrom)==false){
                          denemelist.add(data[i].userFrom);
                        }
                      }
                      debugPrint(denemelist.toString());

                      return ListView.builder(
                        itemCount: denemelist.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<List<SingleUserModel>>(
                            future: SingleUserApi.getUserData(denemelist[index]),
                            builder: (context, snapshot) {
                              if(snapshot.hasData){
                                var response = snapshot.data!;
                                String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${response[0].avatar}";
                                _ppControl(){
                                  if(response[0].avatar==null ||response[0].avatar==""){
                                    return response[0].gender=="Erkek"?
                                    const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                                    const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                                  }
                                  else{
                                    return NetworkImage(userPhotoUrl);
                                  }
                                }

                                if(response[0].id!=widget.id){
                                  return Card(
                                    child: ListTile(
                                      title: Text(response[0].username.toString()),
                                      leading: CircleAvatar(backgroundImage: _ppControl()),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return ChatDetailPage("asd", response[0].id.toString(), widget.id);
                                              },
                                            ));
                                      },
                                    ),
                                  );
                                }else{
                                  return Container();
                                }



                              }else if (snapshot.hasError){
                                return Center(child: Text("Mesaj Bulunmamakta"),);
                              }else{
                                return Container();
                              }

                            },);

                        },);


                    }
                    else{
                      return const Center(child: CircularProgressIndicator());
                    }

                  });
            }
            else if(snapshot.hasError){
              return Unverified();
            }else{
              return Center(child: CircularProgressIndicator(),);
            }

          },
        )


      )
    );
        }

  FutureBuilder<List<UserInfo>> chatBuilder() {
    return FutureBuilder<List<UserInfo>>(
      future: _gelenMsj,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var userList = snapshot.data!;
          return ListView.builder(
            itemBuilder: (context, index){
              var message = userList[index];
              String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${message.avatar}";
              _ppControl(){
                if(message.avatar==null ||message.avatar==""){
                  return message.gender=="Erkek"?
                  const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                  const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                }
                else{
                  return NetworkImage(userPhotoUrl);
                }
              }

              if(useridlist.contains(message.id)==false){
                useridlist.add(message.id.toString());
                if (index >= 1) {
                  if (message.username.toString() !=
                      userList[(index - 1)].username.toString()) {
                    return Card(
                      child: ListTile(
                        title: Text(message.username.toString()),
                        leading: CircleAvatar(backgroundImage: _ppControl()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) {
                                    return ChatDetailPage(
                                        message.username.toString(),
                                        message.id,
                                        widget.id);
                                  },
                                  settings:
                                      RouteSettings(arguments: message.id)));
                        },
                      ),
                    );
                  } else {
                    return Container();
                  }
                } else {
                  if (message.username.isNotEmpty) {
                    return Card(
                      color: Colors.white,
                      child: ListTile(
                        title: Text(message.username.toString()),
                        leading: CircleAvatar(backgroundImage: _ppControl()),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return ChatDetailPage(
                                message.username, message.id, widget.id);
                          }));
                        },
                      ),
                    );
                  } else {
                    return const Text("data");
                  }
                }
              }else{return Container();}
            },
            itemCount: userList.length  ,
          );
        } else if (snapshot.hasError) {
          return Text("Göderilen mesajınız bulunmamakta ");
        } else
        { return Center(child: const CircularProgressIndicator());}
      },
    );
  }
  }

