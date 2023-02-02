
import 'package:acikliyorum/api/blocked_api.dart';
import 'package:acikliyorum/api/post_buttons_api.dart';
import 'package:acikliyorum/models/blocked_model.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Engellenenler extends StatefulWidget {
  const Engellenenler({Key? key}) : super(key: key);

  @override
  State<Engellenenler> createState() => _EngellenenlerState();
}

class _EngellenenlerState extends State<Engellenenler> {
  @override
  Widget build(BuildContext context) {
    String myId = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
        ),
        child: FutureBuilder<List<BlockedModel>>(
          future: BlockedApi.getReviewsData(myId),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var data = snapshot.data!;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  String userlvl = data[index].engellenen.userLevel.toString();
                  String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[index].engellenen.avatar}";
                  int usrlvl = int.parse(userlvl);
                  _ppControl(){
                    if(data[index].engellenen.avatar==null ||data[index].engellenen.avatar==""){
                      return data[index].engellenen.gender=="Erkek"?
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
                  return Card(child:
                    ListTile(
                      leading:  CircleAvatar(
                        backgroundImage: _ppControl(),
                      ),
                      title: Text(data[index].engellenen.username.toString()),
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
                      trailing: OutlinedButton.icon(onPressed: () {
                        PostButtonsApi().engelKaldir(myId, data[index].engellenen.id.toString());
                        setState(() {
                        });
                      }, icon: Icon(Icons.block,color: Colors.red,), label: Text("Kaldır"))
                    ));

              },);

            }else if(snapshot.hasError){
              return Center(child: Text("Engellenen kullanıcı bulunamadı"));
            }else{
              return Center(child: CircularProgressIndicator(),);
            }

          },
        ),
      ),
    );
  }
}
