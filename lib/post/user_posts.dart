
import 'package:acikliyorum/api/reviews_api.dart';
import 'package:acikliyorum/api/user_post_api.dart';
import 'package:acikliyorum/models/reviews_model.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../pages/main_pages/styles.dart';

class UserPosts extends StatefulWidget {
  const UserPosts({Key? key}) : super(key: key);

  @override
  State<UserPosts> createState() => _UserPostsState();
}

class _UserPostsState extends State<UserPosts> {
  @override
  Widget build(BuildContext context) {
      return FutureBuilder<List<UserPostModel>>(
      future: UserPostApi.getUserData("1198"),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          var data = snapshot.data!;
           return ListView.builder(
             scrollDirection: Axis.vertical,
             shrinkWrap: true,
             itemCount: data.length,
             itemBuilder: (context, index) {
               String txt = data[index].reviews.content.toString().replaceAll("<br />", "");
               String txt1;
               String txt2;
               String txt3;
               String txt4;
               String photo1;
               String photo2;
               String photo3;
               String photo4;
               _txt1(){
                 txt1 = txt;
                 txt1 = txt1.substring(txt1.indexOf("<p>")+3,txt1.indexOf("</p>"));
                 return Text(txt1);
               }
               _txt2(){
                 txt2 = txt;
                 txt2 = txt2.replaceFirst("<p>", "").replaceFirst("</p>", "");
                 txt2 = txt2.substring(txt2.indexOf("<p>")+3,txt2.indexOf("</p>"));
                 return Text(txt2);
               }
               _txt3(){
                 txt3 = txt;
                 for(var i = 0;i<=1;i++){
                   txt3 = txt3.replaceFirst("<p>", "").replaceFirst("</p>", "");
                 }
                 txt3 = txt3.substring(txt3.indexOf("<p>")+3,txt3.indexOf("</p>"));
                 return Text(txt3);

               }
               _txt4(){
                 txt4 = txt;
                 for(var i = 0;i<=2;i++){
                   txt4 = txt4.replaceFirst("<p>", "").replaceFirst("</p>", "");
                 }
                 txt4 = txt4.substring(txt4.indexOf("<p>")+3,txt4.indexOf("</p>"));
                 String deneme;
                 return Text(txt4);
               }
               photo1 = txt;
               photo1 = photo1.substring(photo1.indexOf("<img src=")+10,photo1.indexOf(".webp")+5);

               photo2 = txt;
               photo2 = photo2.replaceFirst("<img src=", "").replaceFirst(".webp", "");
               photo2 = photo2.substring(photo2.indexOf("<img src=")+10,photo2.indexOf(".webp")+5);

               photo3 = txt;
               photo3 = photo3.replaceFirst("<img src=", "").replaceFirst(".webp", "").
               replaceFirst("<img src=", "").replaceFirst(".webp", "");
               photo3 = photo3.substring(photo3.indexOf("<img src=")+10,photo3.indexOf(".webp")+5);

               photo4 = txt;
               photo4 = photo4.replaceFirst("<img src=", "").replaceFirst(".webp", "").
               replaceFirst("<img src=", "").replaceFirst(".webp", "").
               replaceFirst("<img src=", "").replaceFirst(".webp", "");
               photo4 = photo4.substring(photo4.indexOf("<img src=")+10,photo4.indexOf(".webp")+5);

               return ListTile(
                   title: Column(children: [
                     Text(data[index].reviews.cId.toString()),
                     _txt1()
                   ],),
                   leading: Text(index.toString()));
             },
           );
        }
        else if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
          return Center(child: Text(snapshot.error.toString()),);
      },
    );

  }

}

ListView buildListView(List<dynamic> data) {
  return ListView.builder(
    itemBuilder: (context, index) {
      return Card(
        color: Colors.white,
        child: Column(
          children: [
            ListTile(
              leading: Icon(
                Icons.account_circle,
                size: 50,
              ),
              title: Text("kullanıcı adı"),
              subtitle: Row(
                children: const [
                  Icon(Icons.ac_unit),
                ],
              ),
            ),
            buildDivider(),
            ListTile(
              leading: Image(
                image:
                    AssetImage("assets/category_icons/category_araclar.webp"),
              ),
              title: Text(data[0].title.toString()),
              subtitle: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Card(
                      color: Colors.grey.shade300,
                      child: Row(
                        children: [
                          const Card(
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
            buildDivider(),
            ListTile(
              title: Text("İnceleme Başlık"),
              subtitle: Text("deneme", maxLines: 20),
            ),
            buildDivider(),
            _likeButtons()
          ],
        ),
      );
    },
    itemCount: 1,
  );
}

Card buildCard() {
  return Card(
    color: Colors.white,
    child: Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.account_circle,
            size: 50,
          ),
          title: Text("Kullanıcı adı"),
          subtitle: Row(
            children: [
              Icon(Icons.ac_unit),
            ],
          ),
        ),
        buildDivider(),
        ListTile(
          leading: Image(
            image: AssetImage("assets/category_icons/category_araclar.webp"),
          ),
          title: Text("ürün/Hizmet adı"),
          subtitle: Row(
            children: [
              Expanded(
                flex: 2,
                child: Card(
                  color: Colors.grey.shade300,
                  child: Row(
                    children: [
                      const Card(
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
        buildDivider(),
        ListTile(
          title: Text("İnceleme Başlık"),
          subtitle: Text("ajshdkasdljakd", maxLines: 20),
        ),
        buildDivider(),
        _likeButtons()
      ],
    ),
  );
}

Divider buildDivider() => Divider(
      thickness: 1,
      color: Colors.black12,
      indent: 10,
      endIndent: 10,
    );

_likeButtons() {
  return Row(
    children: [
      Expanded(
          child: Card(
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 35,
              height: 30,
              child: Icon(
                FontAwesomeIcons.solidThumbsUp,
                color: Colors.white,
              ),
              color: Colors.green,
            ),
            Container(
              child: Text("12"),
            ),
            SizedBox(
              width: 1,
            )
          ],
        ),
      )),
      SizedBox(width: 5),
      Expanded(
          child: Card(
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 35,
              height: 30,
              child: Icon(
                FontAwesomeIcons.solidComments,
                color: Colors.white,
              ),
              color: Colors.blue[700],
            ),
            Container(
              child: Text("18"),
            ),
            SizedBox(
              width: 1,
            )
          ],
        ),
      )),
      SizedBox(width: 5),
      Expanded(
          child: Card(
        color: Colors.grey.shade200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 35,
              height: 30,
              child: Icon(
                FontAwesomeIcons.solidThumbsDown,
                color: Colors.white,
              ),
              color: Colors.red,
            ),
            Container(
              child: Text("18"),
            ),
            SizedBox(
              width: 1,
            )
          ],
        ),
      )),
    ],
  );
}
