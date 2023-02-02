import 'package:acikliyorum/api/user_comment_api.dart';
import 'package:acikliyorum/api/user_post_api.dart';
import 'package:acikliyorum/models/user_comment_model.dart';
import 'package:acikliyorum/models/user_post_model.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/pages/users/product_page.dart';
import 'package:acikliyorum/pages/users/user_page.dart';
import 'package:acikliyorum/pages/users/yorum_page.dart';
import 'package:acikliyorum/post/sample_post.dart';
import 'package:acikliyorum/post/user_posts.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../post/post_page.dart';

class IncelemePage extends StatefulWidget {
  const IncelemePage({Key? key}) : super(key: key);

  @override
  State<IncelemePage> createState() => _IncelemePageState();
}

class _IncelemePageState extends State<IncelemePage> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    String userid = ModalRoute.of(context)!.settings.arguments.toString();

    TabController tabController = TabController(length: 2, vsync: this);

    return Scaffold(
      appBar: acikliyorumAppBar(),
        body: Column(
          children: [
            Card(
              child: TabBar(
                controller: tabController,
                tabs: const [
                  Tab(text: "İncelemeler",),
                  Tab(text: "Yorumlar",)

                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover
                    )),
                // width: double.maxFinite,
                // height: double.infinity,
                child:
                TabBarView(
                  controller: tabController,
                  children:  [
                    FutureBuilder<List<UserPostModel>>(
                      future: UserPostApi.getUserData(userid),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          var data = snapshot.data!;
                          if(data.length>=1){
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                String content = data[index].reviews.content.toString().replaceAll("<br />", "");
                                String photo1 = content;
                                photo1 = photo1.substring(photo1.indexOf("<img src=")+10,photo1.indexOf(".webp")+5);

                                String photo2 = content;
                                photo2 = photo2.replaceFirst("<img src=", "").replaceFirst(".webp", "");
                                photo2 = photo2.substring(photo2.indexOf("<img src=")+10,photo2.indexOf(".webp")+5);

                                String photo3 = content;
                                photo3 = photo3.replaceFirst("<img src=", "").replaceFirst(".webp", "").
                                replaceFirst("<img src=", "").replaceFirst(".webp", "");
                                photo3 = photo3.substring(photo3.indexOf("<img src=")+10,photo3.indexOf(".webp")+5);

                                String photo4 = content;
                                photo4 = photo4.replaceFirst("<img src=", "").replaceFirst(".webp", "").
                                replaceFirst("<img src=", "").replaceFirst(".webp", "").
                                replaceFirst("<img src=", "").replaceFirst(".webp", "");
                                photo4 = photo4.substring(photo4.indexOf("<img src=")+10,photo4.indexOf(".webp")+5);

                                content = content.substring(content.indexOf("<p>")+3,content.indexOf("</p>"));
                                String productName=data[index].produtcs.title.toString();
                                String productPhoto="https://www.acikliyorum.com/uploads/images/${data[index].produtcs.image}";
                                String productCategory=data[index].categories.title.toString();
                                String productRate=data[index].reviews.rate.toString();
                                String contentHeader=data[index].reviews.title.toString();
                                String like=data[index].reviews.liked.toString();
                                String unlike=data[index].reviews.unliked.toString();
                                String views=data[index].reviews.views.toString();
                                String userlvl = data[index].user.userLevel.toString();
                                int usrlvl = int.parse(userlvl);
                                _userLvlControl(){
                                  if(usrlvl <= 5000){
                                    return Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.blue,);
                                  }
                                  else if(usrlvl <= 10000){
                                    return Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.red,);

                                  }
                                  else if(usrlvl>=10001){
                                    return Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.green,);
                                  }

                                }
                                return Card(
                                  margin: EdgeInsets.only(bottom: 10),
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const ProductPage(),
                                                settings: RouteSettings(arguments: data[index].produtcs.id.toString()),
                                              ));

                                        },
                                        leading: Image(
                                          image: NetworkImage(productPhoto),
                                        ),
                                        title: Text(productName+data[index].produtcs.id.toString()),
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
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => const PostPage(),
                                                settings: RouteSettings(
                                                  arguments: data[index].reviews.id
                                                  ,),
                                              ));

                                        },
                                        child: ListTile(
                                          title: Text(contentHeader),
                                          subtitle: Text(content, maxLines: 15),
                                        ),
                                      ),
                                      buildDivider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 90,
                                            width: 90,
                                            child: Image(image: NetworkImage(photo1),),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 90,
                                            width: 90,
                                            child: Image(image: NetworkImage(photo2),),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 90,
                                            width: 90,
                                            child: Image(image: NetworkImage(photo3),),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(10)
                                            ),
                                            height: 90,
                                            width: 90,
                                            child: Image(image: NetworkImage(photo4),),
                                          )
                                        ],
                                      ),

                                      buildDivider(),
                                      Row(
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
                                                      child: Text(like),
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
                                                      child: Text(views),
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
                                                      child: Text(unlike),
                                                    ),
                                                    SizedBox(
                                                      width: 1,
                                                    )
                                                  ],
                                                ),
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },itemCount: data.length,
                            );
                          }else{
                            return const Center(child: Text("Henüz inceleme bulunmamakta"),);
                          }
                        }
                        else if(snapshot.hasError){
                          return Center(child: Text(snapshot.error.toString()),);
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }
                    },),
                    FutureBuilder<List<KullaniciCommentModel>>(
                      future: UserCommentApi.getUserData(userid),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          var data = snapshot.data!;
                          return ListView.builder(
                            itemCount: data[0].comments.length,
                            itemBuilder: (context, index) {
                              // String productName=data[0].products[index].title.toString();
                              // String productRate=data[0].reviews[index].rate.toString();
                              // String productCategory=data[0].categories[0].title.toString();
                              String productPhoto="https://www.acikliyorum.com/uploads/images/${data[0].products[index].image}";
                              return Card(
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    // ListTile(
                                    //   onTap: (){
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //           builder: (context) => const PostPage(),
                                    //           settings: RouteSettings(arguments: data[0].reviews[index].id.toString()),
                                    //         ));
                                    //
                                    //   },
                                    //   leading: Image(
                                    //     image: NetworkImage(productPhoto),
                                    //   ),
                                    //   title: Text(productName),
                                    //   subtitle: Row(
                                    //     children: [
                                    //       Expanded(
                                    //         flex: 2,
                                    //         child: Card(
                                    //           color: Colors.grey.shade300,
                                    //           child: Row(
                                    //             children: [
                                    //               const Card(
                                    //                 color: Colors.lightBlue,
                                    //                 child: Icon(
                                    //                   Icons.info_rounded,
                                    //                   color: Colors.white,
                                    //                 ),
                                    //               ),
                                    //               Flexible(
                                    //                 child: Text(
                                    //                   productCategory,overflow: TextOverflow.ellipsis,
                                    //                   // style: FontStyles.homeContent,
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //       Expanded(
                                    //         flex: 1,
                                    //         child: Card(
                                    //           color: Colors.grey.shade300,
                                    //           child: Row(
                                    //             children: [
                                    //               Card(
                                    //                 color: Colors.yellow[600],
                                    //                 child: const Icon(
                                    //                   Icons.star,
                                    //                   color: Colors.white,
                                    //                 ),
                                    //               ),
                                    //               Text(
                                    //                 productRate,
                                    //                 style: FontStyles.homeContent,
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    buildDivider(),
                                    ListTile(
                                        onTap: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PostPage(),
                                          settings: RouteSettings(arguments: data[0].comments[index].rId)
                                          ));
                                        },
                                        title: Text(data[0].comments[index].content.toString())),
                                  ],
                                ),
                              );

                          },);
                        }else if (snapshot.hasError){
                          return Center(child: Text("Yorum Bulunmamakta"));
                        }else{
                          return Center(child: CircularProgressIndicator(),);
                        }

                    },)

                  ],
                ),
              ),
            )

          ],
        )
    );


  }

}
