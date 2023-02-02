import 'package:acikliyorum/ad_helper.dart';
import 'package:acikliyorum/pages/main_pages/search/category_page.dart';
import 'package:acikliyorum/pages/main_pages/styles.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const int maxFailedLoadAttempts = 3;
class AllCategories extends StatefulWidget {
  const AllCategories({Key? key}) : super(key: key);

  @override
  State<AllCategories> createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  final List _icons = [
    const Image(image: AssetImage("assets/category_icons/category_araclar.webp")),
    const Image(image: AssetImage("assets/category_icons/category_anne-bebek.webp")),
    const Image(image: AssetImage("assets/category_icons/category_canlilar.webp")),
    const Image(image: AssetImage("assets/category_icons/category_elektronik.webp")),
    const Image(image: AssetImage("assets/category_icons/category_restaurant.webp")),
    const Image(image: AssetImage("assets/category_icons/category_ev-dekorasyon.webp")),
    const Image(image: AssetImage("assets/category_icons/category_giyim.webp")),
    const Image(image: AssetImage("assets/category_icons/category_kitap-film-muzik.webp")),
    const Image(image: AssetImage("assets/category_icons/category_kozmetik-kisisel-bakim.webp")),
    const Image(image: AssetImage("assets/category_icons/category_online-pazar-yerleri.webp")),
    const Image(image: AssetImage("assets/category_icons/category_oteller.webp")),
    const Image(image: AssetImage("assets/category_icons/category_spesifik.webp")),
    const Image(image: AssetImage("assets/category_icons/category_supermarket.webp")),
    const Image(image: AssetImage("assets/category_icons/category_turizm.webp")),
    const Image(image: AssetImage("assets/category_icons/category_yapi-market-oto.webp")),
  ];
  final List<String> category = [
    "195",
    "52",
    "112",
    "111",
    "199",
    "55",
    "53",
    "82",
    "32",
    "123",
    "124",
    "110",
    "68",
    "114",
    "12",];

  final List<String> _categoryname = [
        "Araçlar",
        "Anne & Bebek",
        "Canlılar",
        "Elektronik",
        "Restaurant",
        "Ev Dekorasyon",
        "Giyim",
        "Kitap & Film",
        "Kozmetik Kişisel Bakım",
        "Online Pazar Yerleri",
        "Oteller",
        "Spesifik",
        "Süpermarket",
        "Turizm",
        "Yapı Market",
  ];



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
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background.jpeg")
            )
        ),
        child: GridView.count(
          crossAxisCount: 3,
          children: List.generate(15, (index) {
            return Center(
              child: Card(

                child: InkWell(
                  onTap: (){
                    _showInterstitialAd();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoryPage(),
                        settings: RouteSettings(arguments: category[index]),
                      ),
                    );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(child: _icons[index],),
                      const SizedBox(height: 7),
                      Center(child: Text(_categoryname[index].toString()))
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}





class CategoryName {
  final String category;

  CategoryName(this.category);

}