import 'package:acikliyorum/ad_helper.dart';
import 'package:acikliyorum/api/search_api.dart';
import 'package:acikliyorum/models/search_model.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:acikliyorum/widgets/my_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../users/product_page.dart';
const int maxFailedLoadAttempts = 3;
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

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
    String searchWord = ModalRoute.of(context)!.settings.arguments.toString();
    debugPrint(searchWord);
    return Scaffold(
      appBar: acikliyorumAppBar(),
      body: FutureBuilder<List<SearchModel>>(
        future: SearchApi.getReviewsData(searchWord),
        builder: (context,snapshot){
          if(snapshot.hasData){
            var data = snapshot.data!;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
              String productName=data[index].prodcuts.title.toString();
              String productPhoto="https://www.acikliyorum.com/uploads/images/${data[index].prodcuts.image}";
              String productCategory=data[index].categories.toString();
              String productRate=data[index].toString();
              return Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: (){
                        _showInterstitialAd();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProductPage(),
                              settings: RouteSettings(arguments: data[index].prodcuts.id.toString()),
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
                                    "5",
                                    style: FontStyles.homeContent,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },);
          }
          else if(snapshot.hasError){
            return Center(child: Text(snapshot.error.toString()),);
          }else{
            return const Center(child: CircularProgressIndicator(),);
          }

        },
      ),
    );
  }
}
