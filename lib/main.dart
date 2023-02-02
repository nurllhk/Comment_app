import 'dart:async';
import 'dart:io';
import 'package:acikliyorum/ad_helper.dart';
import 'package:acikliyorum/api/balance_control.dart';
import 'package:acikliyorum/pages/first_page.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'api/single_user.dart';
import 'models/single_user.dart';


AppOpenAd? appOpenAd;

Future<void> loadAd()async{
  await AppOpenAd.load(
      adUnitId: "ca-app-pub-4316948893098839/3701235692",
      request: AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          print("App loaded");
          appOpenAd = ad;
          appOpenAd!.show();
        }, onAdFailedToLoad: (error) {
        print("Error");
      },), orientation: AppOpenAd.orientationPortrait);
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await loadAd();
  runApp(const MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override


  var dbHelper = DbHelper();

  getBalance(){
    Timer.periodic(const Duration(seconds: 10), (timer) async {
      debugPrint("cüzdan arttı");
      await dbHelper.getBalance("1");
    });
  }
  @override
  Widget build(BuildContext context) {
    getBalance();


    return ScreenUtilInit(
        designSize: const Size(412, 732),
        builder: (_, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.orange),
            home: const Login()));
  }
}
