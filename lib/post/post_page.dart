import 'package:acikliyorum/api/comments_api.dart';
import 'package:acikliyorum/api/single_review_api.dart';
import 'package:acikliyorum/models/comments_model.dart';
import 'package:acikliyorum/models/single_review.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/pages/users/user_page.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../api/post_apies.dart';
import '../api/post_buttons_api.dart';
import '../pages/users/product_page.dart';
import '../utils/database_helper.dart';


class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {

  bool _isPressed = false;
  bool _isCommentPressed = false;
  var dbHelper = DbHelper();

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 10), () async {
    //   await dbHelper.getBalance("1");
    //   return initState();
    //
    //
    // });
  }



  @override
  Widget build(BuildContext context) {
    TextEditingController _commnet = TextEditingController();
    var dbHelper = DbHelper();
    var commentKey = GlobalKey<FormFieldState>();


     String reviewid = ModalRoute.of(context)!.settings.arguments.toString();
    // int indexof = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
        ),
        child: FutureBuilder<List<SingleReviewModel>>(
          future: SingleReviewApi.getReviewsData(reviewid),
          builder: (context,snapshot){
            if(snapshot.hasData){
              var response = snapshot.data!;
              String content = response[0].reviews.content.toString();
              content = content.replaceAll("<br />", "");
              String txt1;
              String txt2;
              String txt3;
              String txt4;
              String photo1;
              String photo2;
              String photo3;
              String photo4;
              _txt1(){
                txt1 = content;
                txt1 = txt1.substring(txt1.indexOf("<p>")+3,txt1.indexOf("</p>"));
                return Text(txt1);
              }
              _txt2(){
                txt2 = content;
                txt2 = txt2.replaceFirst("<p>", "").replaceFirst("</p>", "");
                txt2 = txt2.substring(txt2.indexOf("<p>")+3,txt2.indexOf("</p>"));
                return Text(txt2);
              }
              _txt3(){
                txt3 = content;
                for(var i = 0;i<=1;i++){
                  txt3 = txt3.replaceFirst("<p>", "").replaceFirst("</p>", "");
                }
                txt3 = txt3.substring(txt3.indexOf("<p>")+3,txt3.indexOf("</p>"));
                return Text(txt3);

              }
              _txt4(){
                txt4 = content;
                for(var i = 0;i<=2;i++){
                  txt4 = txt4.replaceFirst("<p>", "").replaceFirst("</p>", "");
                }
                txt4 = txt4.substring(txt4.indexOf("<p>")+3,txt4.indexOf("</p>"));
                return Text(txt4);
              }
              photo1 = content;
              photo1 = photo1.substring(photo1.indexOf("<img src=")+10,photo1.indexOf(".webp")+5);

              photo2 = content;
              photo2 = photo2.replaceFirst("<img src=", "").replaceFirst(".webp", "");
              photo2 = photo2.substring(photo2.indexOf("<img src=")+10,photo2.indexOf(".webp")+5);

              photo3 = content;
              photo3 = photo3.replaceFirst("<img src=", "").replaceFirst(".webp", "").
              replaceFirst("<img src=", "").replaceFirst(".webp", "");
              photo3 = photo3.substring(photo3.indexOf("<img src=")+10,photo3.indexOf(".webp")+5);

              photo4 = content;
              photo4 = photo4.replaceFirst("<img src=", "").replaceFirst(".webp", "").
              replaceFirst("<img src=", "").replaceFirst(".webp", "").
              replaceFirst("<img src=", "").replaceFirst(".webp", "");
              photo4 = photo4.substring(photo4.indexOf("<img src=")+10,photo4.indexOf(".webp")+5);
              String puan = response[0].reviews.rate.toString();
              String recco = response[0].reviews.recommend.toString();
              String priceRate = response[0].reviews.priceRate.toString();
              String like = response[0].reviews.liked.toString();
              String unlike = response[0].reviews.unliked.toString();
              String views=response[0].reviews.views.toString();
              String userName = response[0].users.username.toString();
              String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${response[0].users.avatar}";
              String userlvl = response[0].users.userLevel.toString();
              int usrlvl = int.parse(userlvl);
              DateTime time = response[0].reviews.date;
              DateTime now = DateTime.now();
              int yilfark = now.year-time.year;
              int ayfark = now.month-time.month;
              int gunfark = now.day-time.day;
              int saatfark = now.hour-time.hour;
              int dakikafark = now.minute-time.minute;
              int haftafark = now.weekday-time.weekday;
              String productName=response[0].products.title.toString();
              String productPhoto="https://www.acikliyorum.com/uploads/images/${response[0].products.image}";
              String productCategory=response[0].categories.title.toString();
              String productRate=response[0].reviews.rate.toString();
              _timeControl(){
                if(yilfark>=1){
                  return Text("$yilfark yıl önce");
                }else if(ayfark>=1){
                  return Text("$ayfark ay önce");
                }else if(haftafark>=1){
                  return Text("$haftafark gün önce");
                }else if(gunfark>=1){
                  return Text("$gunfark gün önce");
                }else if(saatfark>=1){
                  return Text("$saatfark saat önce");
                }else if(dakikafark>=1){
                  return Text("$dakikafark dakika önce");
                }else{
                  return Text("şimdi");
                }
              }
              _ppControl(){
                if(response[0].users.avatar==null ||response[0].users.avatar==""){
                  return response[0].users.gender=="Erkek"?
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
              String userid = response[0].users.id.toString();
              return ListView(
                children: [
                  Card(
                    child: Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const UserPage(),
                                  // settings: RouteSettings(arguments: userid),
                                ));

                          },
                          leading: CircleAvatar(
                            backgroundImage: _ppControl(),
                          ),
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
                          trailing: _timeControl()
                        ),
                        buildDivider(),
                        ListTile(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ProductPage(),
                                  settings: RouteSettings(arguments: response[0].products.id.toString()),
                                ));

                          },
                          leading: Image(
                            image: NetworkImage(productPhoto),
                          ),
                          title: Text(productName),
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
                                      Flexible(
                                        child: Text(
                                          productCategory,overflow: TextOverflow.ellipsis,
                                          // style: FontStyles.homeContent,
                                        ),
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
                                        child: const Icon(
                                          Icons.star,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        productRate,
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
                          title: Text(response[0].reviews.title.toString()),
                          subtitle: Column(
                            children: [
                              _txt1(),
                              Image(image: NetworkImage(photo1)),
                              _txt2(),
                              Image(image: NetworkImage(photo2)),
                              _txt3(),
                              Image(image: NetworkImage(photo3)),
                              _txt4(),
                              Image(image: NetworkImage(photo4))

                            ],
                          ),
                        ),
                        buildDivider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.black38)
                              ),
                              child: Row(
                                children: [
                                  Icon(FontAwesomeIcons.solidStar,color: Colors.yellow,),
                                  SizedBox(width: 5,),
                                  Text(puan)

                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.black38)


                              ),
                              child: recco=="1"?Row(
                                children: const [
                                  Icon(FontAwesomeIcons.solidThumbsUp,color: Colors.green,),
                                  SizedBox(width: 5,),
                                  Text("tavsiye ediyor")
                                ],
                              ):Row(children: const [
                                Icon(FontAwesomeIcons.solidThumbsDown,color: Colors.red,),
                                SizedBox(width: 5,),
                                Text("tavsiye etmiyor")

                              ],)
                            ),
                            Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(color: Colors.black54)


                              ),
                              child: priceRate=="1"?Row(
                                children: const [
                                  Icon(FontAwesomeIcons.solidThumbsUp,color: Colors.green,),
                                  SizedBox(width: 5,),
                                  Text("fiyat/performans")

                                ],
                              ):
                                  Row(
                                    children: const [
                                      Icon(FontAwesomeIcons.solidThumbsDown,color: Colors.red,),
                                      SizedBox(width: 5,),
                                      Text("fiyatını haketmiyor")

                                    ],
                                  )
                            ),
                          ],
                        ),
                        buildDivider(),
                        Row(
                          children: [
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    if(_isPressed==false){
                                      setState((){
                                        _isPressed = true;
                                        PostButtonsApi().postlike(reviewid);
                                      });
                                    }else {
                                      debugPrint("Gönderi daha önce beğenildi");
                                    }
                                  },
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 30,
                                          color: Colors.green,
                                          child: const Icon(
                                            FontAwesomeIcons.solidThumbsUp,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          child: Text(like),
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        )
                                      ],
                                    ),
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
                                        color: Colors.blue[700],
                                        child: const Icon(
                                          FontAwesomeIcons.solidComments,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Container(
                                        child: Text(views),
                                      ),
                                      const SizedBox(
                                        width: 1,
                                      )
                                    ],
                                  ),
                                )),
                            SizedBox(width: 5),
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    if(_isPressed==false){
                                      setState((){
                                        _isPressed = true;
                                        PostButtonsApi().postUnlike(reviewid);
                                      });
                                    }else {
                                      debugPrint("Gönderi daha önce beğenildi");
                                    }
                                  },
                                  child: Card(
                                    color: Colors.grey.shade200,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 30,
                                          color: Colors.red,
                                          child: const Icon(
                                            FontAwesomeIcons.solidThumbsDown,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Container(
                                          child: Text(unlike),
                                        ),
                                        const SizedBox(
                                          width: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                          ],
                        )

                      ],
                    ),
                  ),
                  _headerTile("Yorumlar", FontAwesomeIcons.solidComments),
                  FutureBuilder<List<CommentsModel>>(
                    future: PostCommentswApi.getReviewsData(reviewid),
                    builder: (context, snapshot) {
                      if(snapshot.hasData){
                        var data = snapshot.data!;
                        debugPrint(data.toString());

                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data[0].comments.length,
                          itemBuilder: (context, index) {
                            String userNames = data[0].commentsUser[index].username.toString();
                            String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[0].commentsUser[index].avatar}";
                            String userlvl = data[0].commentsUser[index].userLevel.toString();
                            int usrlvl = int.parse(userlvl);
                            DateTime time = data[0].comments[index].date;
                            DateTime now = DateTime.now();
                            int yilfark = now.year-time.year;
                            int ayfark = now.month-time.month;
                            int gunfark = now.day-time.day;
                            int saatfark = now.hour-time.hour;
                            int dakikafark = now.minute-time.minute;
                            int haftafark = now.weekday-time.weekday;
                            _timeControl(){
                              if(yilfark>=1){
                                return Text("$yilfark yıl önce");
                              }else if(ayfark>=1){
                                return Text("$ayfark ay önce");
                              }else if(haftafark>=1){
                                return Text("$haftafark gün önce");
                              }else if(gunfark>=1){
                                return Text("$gunfark gün önce");
                              }else if(saatfark>=1){
                                return Text("$saatfark saat önce");
                              }else if(dakikafark>=1){
                                return Text("$dakikafark dakika önce");
                              }else{
                                return Text("şimdi");
                              }
                            }
                            _ppControl2(){
                              if(data[0].commentsUser[index].avatar==null ||data[0].commentsUser[index].avatar==""){
                                return data[0].commentsUser[index].gender=="Erkek"?
                                const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                                const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                              }
                              else{
                                return NetworkImage(userPhotoUrl);
                              }
                            }
                            _userLvlControl2(){
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
                              child: Column(
                              children: [
                                ListTile(
                                  onTap: (){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const UserPage(),
                                          settings: RouteSettings(arguments: userid),
                                        ));
                                  },
                                  leading: CircleAvatar(
                                    backgroundImage: _ppControl2(),
                                  ),
                                  title: Text(userNames),
                                  subtitle: Row(
                                    children: [
                                      CircleAvatar(
                                        maxRadius: 15,
                                        backgroundColor: Colors.grey.shade300,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.white,
                                          maxRadius: 12,
                                          child: _userLvlControl2(),
                                        ),
                                      )
                                    ],
                                  ),
                                  trailing: _timeControl(),
                                ),
                                buildDivider(),
                                ListTile(
                                  title: Text(data[0].comments[index].content.toString()),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: (){
                                                if(_isCommentPressed==false){
                                                  setState((){
                                                    _isCommentPressed = true;
                                                    PostApi().postCommentlike(data[0].comments[index].id.toString());
                                                  });
                                                }else {
                                                  debugPrint("Gönderi daha önce beğenildi");
                                                }
                                              },
                                              child: Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Row(
                                                    children:  [
                                                      SizedBox(width: 10,),
                                                      Icon(Icons.thumb_up,color: Colors.green,),
                                                      SizedBox(width: 15,),
                                                      Text(data[0].comments[index].liked.toString()),
                                                      SizedBox(width: 10,)
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10,),
                                            InkWell(
                                              onTap: (){
                                                if(_isCommentPressed==false){
                                                  setState((){
                                                    _isCommentPressed = true;
                                                    PostApi().postCommentUnlike(data[0].comments[index].id.toString());
                                                  });
                                                }else {
                                                  debugPrint("Gönderi daha önce beğenildi");
                                                }
                                              },

                                              child: Card(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: Row(children:  [
                                                    SizedBox(width: 10,),
                                                    Icon(Icons.thumb_down,color: Colors.red,),
                                                    SizedBox(width: 15,),
                                                    Text(data[0].comments[index].unliked.toString()),
                                                    SizedBox(width: 10,)

                                                  ],),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),);


                        },);



                      }else if(snapshot.data![0].comments.isEmpty){
                        return Center(child: Text("yorum bulunmamakta"),);
                      }else{
                        return CircularProgressIndicator();
                      }

                  },),
                  FutureBuilder(
                      future: dbHelper.getTodos("1"),
                      builder: (context,snapshot){
                        if(snapshot.hasData){
                          var loginedUser = snapshot.data!;
                          return ListTile(
                            title: TextFormField(

                              controller: _commnet,
                              maxLength: 40,
                              key: commentKey,
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(FontAwesomeIcons.message,color: Colors.orange,),
                                  label: Text("Yorum yap"),
                                  border: OutlineInputBorder()),
                              obscureText: false,
                              onSaved: (deger) {
                                _commnet = deger! as TextEditingController;
                              },
                              validator: (e){
                                if(e!.length<=3){
                                  return "Düşüncelerinizi en az bir kelime ile anlatınız";
                              }
                              }
                            ),
                            trailing: IconButton(
                              icon: const Icon(FontAwesomeIcons.arrowRight,color: Colors.orange,),
                              onPressed: (){

                                debugPrint(_commnet.text);
                                commentKey.currentState!.validate()?
                                    PostButtonsApi().postComment(_commnet.text, reviewid, loginedUser.toString()):debugPrint("şartlar karşılanmadı");
                                showDialog(context: context, builder: (context) {
                                  return AlertDialog(content: Text("İşlem Başarılı"),
                                  actions: [
                                    TextButton(onPressed: () {
                                      _commnet.clear();
                                    Navigator.pop(context);
                                    setState(() {
                                    });
                                  }, child: Text("Tamam"))],
                                  );
                                },);




                              },
                            ),
                          );
                        }return Container();

                      }),

                  // ListTile(
                  //   title: TextFormField(
                  //
                  //     controller: _commnet,
                  //     maxLength: 40,
                  //     decoration: const InputDecoration(
                  //         prefixIcon: Icon(FontAwesomeIcons.message,color: Colors.orange,),
                  //         label: Text("Yorum yap"),
                  //         border: OutlineInputBorder()),
                  //     obscureText: false,
                  //     onSaved: (deger) {
                  //       _commnet = deger! as TextEditingController;
                  //     },
                  //     validator: (e){
                  //       if(e!.length<=3){
                  //         print("Bu alan 3 harften küçük olamaz");
                  //       }
                  //
                  //     },
                  //   ),
                  //   trailing: IconButton(
                  //     icon: const Icon(FontAwesomeIcons.arrowRight,color: Colors.orange,),
                  //     onPressed: (){
                  //       debugPrint(_commnet.text);
                  //
                  //
                  //       PostButtonsApi().postComment(_commnet.text, reviewid, );
                  //
                  //     },
                  //   ),
                  // ),

                ],
              );
            }
            else if (snapshot.hasError){
              return Center(child: Text(snapshot.error.toString()),);
            }
            else {
              return Center(child: CircularProgressIndicator(),);
            }

          },
        ),
      ),
    );
  }
  Card _headerTile(String baslik, IconData icon) {
    return Card(
      color: Colors.white,
      child: ListTile(
        tileColor: Colors.white,
        title: Text(baslik),
        leading: Icon(FontAwesomeIcons.solidComments,color: Colors.orange[700],)
      ),
    );
  }
  
  Divider buildDivider() => const Divider(
    thickness: 1,
    color: Colors.black12,
    indent: 10,
    endIndent: 10,
  );
}
