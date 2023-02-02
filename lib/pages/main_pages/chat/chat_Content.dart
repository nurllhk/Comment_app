
import 'package:acikliyorum/FutureFunc.dart';
import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/api/single_user.dart';
import 'package:acikliyorum/api/tester_chat_api.dart';
import 'package:acikliyorum/models/Mesajlar_model.dart';
import 'package:acikliyorum/models/single_user.dart';
import 'package:acikliyorum/models/tester_chat_model.dart';
import 'package:flutter/material.dart';
import '../../../FutureFunc.dart';

class ChatDetailPage extends StatefulWidget{
  String uname ;
  String id;
  String me_id;
  ChatDetailPage(this.uname,this.id,this.me_id);



  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}
class _ChatDetailPageState extends State<ChatDetailPage> {
  late final Future<List<Mesajlar>> _message;
  

  @override
  void initState() {
    super.initState();
    _message = Fonksiyonlar(widget.id).message(widget.me_id);
  }

  TextEditingController myMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    String fromuserid = ModalRoute.of(context)!.settings.arguments.toString();


    return  FutureBuilder<List<SingleUserModel>>(
      future: SingleUserApi.getUserData(widget.id),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var data = snapshot.data!;
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
          debugPrint(widget.me_id+"asd"+widget.id);
          return Scaffold(
            appBar: AppBar(
              actions: [
                PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        onTap: (){
                          debugPrint("engelleme butonu tıklandı");
                          PostButtonsApi().engelle(widget.me_id, widget.id);
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [Icon(Icons.block,color: Colors.red,),
                            SizedBox(width: 5,),
                            Text("Engelle")

                          ],
                        ),
                      ),
                      // PopupMenuItem(
                      //   onTap: (){
                      //     PostButtonsApi().sohbetiSil(widget.me_id, widget.id);
                      //     Navigator.pop(context);
                      //   },
                      //   child: Row(
                      //     children: [Icon(Icons.delete,color: Colors.blue,),
                      //       SizedBox(width: 5,),
                      //       Text("Konuşmayı sil")
                      //
                      //     ],
                      //   ),
                      // ),
                    ]),
              ],
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white,
              flexibleSpace: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Row(
                    children: <Widget>[
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back,color: Colors.black,),
                      ),
                      SizedBox(width: 2,),
                      CircleAvatar(
                        backgroundImage: _ppControl(),
                        maxRadius: 20,
                      ),
                      SizedBox(width: 12,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(widget.uname,style: TextStyle( fontSize: 16 ,fontWeight: FontWeight.w600),),
                            SizedBox(height: 6,),
                            // Text("Online",style: TextStyle(color: Colors.grey.shade600, fontSize: 13),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                    child: FutureBuilder<List<TesterChatModel>>(
                      future: TesterChatApi.getReviewsData(widget.me_id,widget.id),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          var response = snapshot.data!;
                          final message = snapshot.data!.reversed.toList();
                                return ListView.builder(
                                  reverse: true,
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    if(message[index].userForm==widget.me_id){
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 300),
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                color: Colors.orange[700],
                                                borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: Text(message[index].content.toString()
                                              ,style: TextStyle(fontSize: 15,color: Colors.white),
                                              ),
                                            ),
                                          )

                                        ],
                                      );
                                    }else{
                                      return Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Container(
                                              constraints: BoxConstraints(maxWidth: 300),
                                              padding: EdgeInsets.all(10),
                                              margin: EdgeInsets.all(3),
                                              decoration: BoxDecoration(
                                                border: Border.all(color: Colors.orange),
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(15)
                                              ),
                                              child: Text(message[index].content.toString(),style: const TextStyle(
                                                fontSize: 15,color: Colors.orange
                                              ),),
                                            ),
                                          )

                                        ],
                                      );

                                    }


                                    return Text("asjdhaskjd");
                                },itemCount: message.length);
                        }else if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()),);
                        }

                        else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                      },
                    )


                  ),
                  ListTile(
                    trailing: InkWell(
                      onTap: (){
                        setState((){
                          if(myMessage.text!="")
                          PostButtonsApi().sendMessage(widget.me_id, widget.id, myMessage.text);
                          myMessage.clear();
                        });
                      },
                      child: CircleAvatar(
                          child: const Icon(Icons.send,color: Colors.white,),
                          backgroundColor: Colors.orange[700]),
                    ),
                    title: TextFormField(
                      controller: myMessage,
                      decoration: const InputDecoration(
                          label: Text("Mesaj"),
                          border: OutlineInputBorder()),
                      obscureText: false,
                    ),
                  ),
                ],
              ),
            ),

          );
        }
        else{
          return Container();
        }





    },);
  
  }
} 

