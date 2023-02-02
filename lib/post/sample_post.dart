
import 'dart:io';

import 'package:acikliyorum/ad_helper.dart';
import 'package:acikliyorum/api/reviews_api.dart';
import 'package:acikliyorum/models/reviews_model.dart';
import 'package:acikliyorum/pages/users/product_page.dart';
import 'package:acikliyorum/pages/users/user_page.dart';
import 'package:acikliyorum/post/post_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../api/post_buttons_api.dart';
import '../pages/main_pages/styles.dart';

const int maxFailedLoadAttempts = 3;

class Post extends StatefulWidget {
  const Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;


  @override
  void initState() {
    super.initState();
    _createInterstitialAd();

  }
  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: AdHelper.interstitialAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewsModel>>(
        future: ReviewsApi.getReviewsData(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            var data = snapshot.data!;
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
                String userid = data[index].users.id.toString();
                String userName = data[index].users.username.toString();
                String? userPhotoUrl="https://www.acikliyorum.com/uploads/images/thumb/${data[index].users.avatar}";
                String productName=data[index].products.title.toString();
                String productPhoto="https://www.acikliyorum.com/uploads/images/${data[index].products.image}";
                String productCategory=data[index].categories.title.toString();
                String productRate=data[index].reviews.rate.toString();
                String contentHeader=data[index].reviews.title.toString();
                String like=data[index].reviews.liked.toString();
                String unlike=data[index].reviews.unliked.toString();
                String views=data[index].reviews.views.toString();
                String userlvl = data[index].users.userLevel.toString();
                int usrlvl = int.parse(userlvl);
                DateTime time = data[index].reviews.date;
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
                _ppControl(){
                  if(data[index].users.avatar==null ||data[index].users.avatar==""){
                    return data[index].users.gender=="Erkek"?
                    const NetworkImage("https://www.acikliyorum.com/uploads/images/erkek.jpg"):
                        const NetworkImage("https://www.acikliyorum.com/uploads/images/bayan.jpg");
                  }
                  else{
                    return NetworkImage(userPhotoUrl);
                  }
                }
                _userLvlControl(){
                  if(usrlvl <= 5000){
                    return const Icon(FontAwesomeIcons.solidUser,color: Colors.orange,size: 14,);
                  }
                  else if(usrlvl <= 10000){
                    return const Icon(FontAwesomeIcons.userGraduate,color: Colors.yellow,size: 14,);

                  }
                  else if(usrlvl>=10001){
                    return const Icon(FontAwesomeIcons.solidCircleCheck,color: Colors.blue,size: 14,);
                  }
                }
                return Card(
                  color: Colors.white,
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
                        trailing: _timeControl(),
                      ),
                      buildDivider(),
                      ListTile(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ProductPage(),
                                settings: RouteSettings(arguments: data[index].products.id.toString()),
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
                      InkWell(
                        onTap: (){
                          _showInterstitialAd();
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
                              child: InkWell(
                                onTap: (){
                                  _showInterstitialAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PostPage(),
                                        settings: RouteSettings(
                                          arguments: data[index].reviews.id
                                          ,),
                                      ));
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
                                      Text(like),
                                      const SizedBox(
                                        width: 1,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(width: 5),
                          Expanded(
                              child: InkWell(
                                onTap: (){
                                  _showInterstitialAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PostPage(),
                                        settings: RouteSettings(
                                          arguments: data[index].reviews.id
                                          ,),
                                      ));

                                },
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
                                      Text(views),
                                      const SizedBox(
                                        width: 1,
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          const SizedBox(width: 5),
                          Expanded(
                              child: InkWell(
                                onTap: (){
                                  _showInterstitialAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const PostPage(),
                                        settings: RouteSettings(
                                          arguments: data[index].reviews.id
                                          ,),
                                      ));
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
                                      Text(unlike),
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
                );
            },itemCount: data.length,
                );
          }
          else if(snapshot.hasError){
            return Center(child: Text("Lütfen internet bağlantınızı kontrol edin"));
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }
      },
    );


  }



  Divider buildDivider() => const Divider(
        thickness: 1,
        color: Colors.black12,
        indent: 10,
        endIndent: 10,
      );


}
