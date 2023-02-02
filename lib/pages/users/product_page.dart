import 'package:acikliyorum/api/product_api.dart';
import 'package:acikliyorum/api/reviews_api.dart';
import 'package:acikliyorum/models/products_model.dart';
import 'package:acikliyorum/models/reviews_model.dart';
import 'package:acikliyorum/pages/main_pages/create_post/create_post.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/post/product_posts.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';

import '../../api/single_product_api.dart';
import '../../models/single_product_model.dart';
import '../main_pages/create_post/create_post_tester.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({Key? key}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin {


  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    String indexof = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
        appBar: acikliyorumAppBar(),
        body: Container(

          decoration: const BoxDecoration(
              image: DecorationImage(image: AssetImage("assets/background.jpeg",),fit: BoxFit.cover)),
          child: FutureBuilder<List<SingleProductModel>>(
            future: SingleProductApi.getReviewsData(indexof),
            builder: (context,snapshot){
              if(snapshot.hasData){
                var data = snapshot.data!;
                String productName=data[0].produtcs.title.toString();
                String productPhoto="https://www.acikliyorum.com/uploads/images/${data[0].produtcs.image}";
                String productCategory=data[0].categories.title.toString();
                return ListView(
                  children: [
                    Card(
                      child: Column(
                        children: [
                          Row(
                            children: [
                            Flexible(
                              child: Container(
                                margin: EdgeInsets.all(8),
                                child: Text(
                                  productName,style: TextStyle(fontWeight: FontWeight.w500),overflow: TextOverflow.visible,),
                              ),
                            ),

                          ],),
                          Row(children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                              height: 120,width: 150,
                                  child: Image(image: NetworkImage(productPhoto),height: 120,width: 150,)),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  margin: EdgeInsets.all(3),
                                  width: 220,
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
                                        productCategory,overflow: TextOverflow.ellipsis,
                                        // style: FontStyles.homeContent,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(3),
                                  width: 220,
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
                                        "5",
                                        style: FontStyles.homeContent,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(3),
                                  width: 220,
                                  color: Colors.grey.shade300,
                                  child: Row(
                                    children: [
                                      const Card(
                                        color: Colors.black,
                                        child: Icon(
                                          FontAwesomeIcons.squarePen,
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        data[0].produtcs.status.toString(),overflow: TextOverflow.ellipsis,
                                        // style: FontStyles.homeContent,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductPosts(),settings: RouteSettings(arguments:data[0].produtcs.id)));

                          }, child: const Text("İnceleme ve Yorumlar",style: TextStyle(color: Colors.white),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePostTester(data[0].produtcs.id.toString(),productName,data[0].categories.id.toString(),data[0].produtcs.bId.toString()),settings: RouteSettings(arguments:data[0].produtcs.id)));

                          }, child: const Text("İnceleme Ekle",style: TextStyle(color: Colors.white),)),
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
          ),
        )
    );
  }
}
