import 'package:acikliyorum/FutureFunc.dart';
import 'package:acikliyorum/models/Notifications.model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';

import '../../../utils/database_helper.dart';
import '../profile/unverified_user.dart';


class NotificationPage extends StatefulWidget {
  String id;
  

  NotificationPage(this.id);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  late final Future<List<Notifications>> _notification;
  
  @override
  void initState() {
    super.initState();
    _notification = Fonksiyonlar(widget.id).notification(widget.id);
  }
  @override
  Widget build(BuildContext context) {
    var dbHelper = DbHelper();
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: acikliyorumAppBar(),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
          ),
          child: FutureBuilder(
              future: dbHelper.getTodos("1"),
              builder: (context,snapshot){
                if(snapshot.hasData){
                  var loginedUser = snapshot.data!;
                  return notificationPage();
                }else{
                  return const Unverified();
                }

              }),
        )
    );
  }

  FutureBuilder<List<Notifications>> notificationPage() {
    return FutureBuilder<List<Notifications>>(
        future: _notification,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var userList = snapshot.data!;
            if(userList.isNotEmpty){
              return ListView.builder(
              itemBuilder: (context, index){
                var bildirim = userList[index];
                String icerik = bildirim.title;
                icerik = icerik.replaceAll("<p>", "").replaceAll("</p>", "").replaceAll("</b>", "")
                .replaceAll("<u>", "").replaceAll("</u>", "").replaceAll("<b>", "");

                return Card(
                  margin: EdgeInsets.only(top: 3),
                  child: ListTile(
                    onTap: (){},
                    tileColor: Colors.white,
                    // title: Text(bildirim.type.toString()),
                    title: Text(icerik),
                    leading: bildirim.type=="admin"?CircleAvatar(
                        backgroundColor: Colors.orange[700],
                        child: Icon(FontAwesomeIcons.info,color: Colors.white,)):
                    CircleAvatar(
                        backgroundColor: Colors.orange[700],
                        child: Icon(FontAwesomeIcons.solidBell,color: Colors.white,))

                  ),
                );
              },
              itemCount: userList.length  ,
            );

            }else{
              return Center(child: Text("bildiriminiz Bulunmamakta"));
            }

            } else if (snapshot.hasError) {
            return Text("Göderilen mesajınız bulunmamakta ");
          } else
          { return const CircularProgressIndicator();}
        },
      );
  }

  ListView _notifications() {
    return ListView.builder(itemBuilder: (context, index) {
        return Card(
          margin: EdgeInsets.only(top: 3),
          child: ListTile(
            onTap: (){},
            tileColor: Colors.white,
            title: Text("Kullanici adi"),
            subtitle: Text("Bildirim içeriği buraya gelcek"),
            leading: CircleAvatar(child: Icon(FontAwesomeIcons.user)),
          ),
        );
      }, itemCount: 20);
  }



}
