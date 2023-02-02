import 'dart:async';

import 'package:acikliyorum/pages/main_pages/chat/chat_page.dart';
import 'package:acikliyorum/pages/main_pages/create_post/create_post.dart';
import 'package:acikliyorum/pages/main_pages/home/home_page.dart';
import 'package:acikliyorum/pages/main_pages/notifications/notification_page.dart';
import 'package:acikliyorum/pages/main_pages/find_product/post_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/profile_page.dart';
import 'package:acikliyorum/pages/main_pages/profile/unverified_user.dart';
import 'package:acikliyorum/pages/main_pages/search/all_categories.dart';
import 'package:acikliyorum/pages/main_pages/search/search_page.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:acikliyorum/pages/styles/color_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainPages extends StatefulWidget {
  const MainPages({Key? key}) : super(key: key);

  @override
  State<MainPages> createState() => _MainPagesState();
}

class _MainPagesState extends State<MainPages> {
  int _currentIndex = 0;
  String? pushid;
  final tabs = [
    const HomePage(),
    const AllCategories(),
    const Profile(),
  ];

  var dbHelper = DbHelper();

  void initState(){
    super.initState();

  }

  // getBalance(){
  //   Timer.periodic(const Duration(seconds: 10), (timer) {
  //     print("bakiye yüklendi");
  //     dbHelper.getBalance("1");
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    String userLoginId = ModalRoute.of(context)!.settings.arguments.toString();
    var searchKey = GlobalObjectKey(context);
    TextEditingController search =TextEditingController();
    pushid =userLoginId;

    // getBalance();

    return FutureBuilder(
      future: dbHelper.kullaniciSorgu("1"),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var myid = snapshot.data!;
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              titleSpacing: 8,
              backgroundColor: Colors.white,
              elevation: 0,
              title: TextFormField(
                onEditingComplete: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),settings: RouteSettings(arguments: search.text)),);
                },
                key: searchKey,
                autofocus: false,
                decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    hintText: "Aramak istediğiniz ürünü girin",
                    prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                    label: Text("Ürün/Hizmet Ara"),
                    border: OutlineInputBorder()),
                controller: search,
                onSaved: (e){
                  search = e as TextEditingController;

                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState((){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(myid.toString()),
                            ));

                      });

                    },
                    icon: Icon(
                      Icons.message,
                      color: Colors.orange[700],
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(myid.toString()),
                          ));
                    },

                    icon: Icon(
                      Icons.notifications_active,
                      color: Colors.orange[700],
                    )),


              ],
            ),
            body: tabs[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              selectedLabelStyle: TextStyle(color: Colors.orange[800]),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.orange[800],
                    size: 30,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.book,
                    color: Colors.orange[800],
                    size: 25,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.orange[800],
                    size: 30,
                  ),
                  label: "",
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;

                });
              },
            ),
          );
        }

        else{
          var myid;
          return Scaffold(
            backgroundColor: Colors.grey[200],
            appBar: AppBar(
              titleSpacing: 8,
              backgroundColor: Colors.white,
              elevation: 0,
              title: TextFormField(
                onEditingComplete: (){

                  Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage(),settings: RouteSettings(arguments: search.text)),);
                },
                key: searchKey,
                autofocus: false,
                decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
                    hintText: "Aramak istediğiniz ürünü girin",
                    prefixIcon: Icon(FontAwesomeIcons.magnifyingGlass),
                    label: Text("Ürün/Hizmet Ara"),
                    border: OutlineInputBorder()),
                controller: search,
                onSaved: (e){
                  search = e as TextEditingController;

                },
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      setState((){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatPage(myid.toString()),
                            ));

                      });

                    },
                    icon: Icon(
                      Icons.message,
                      color: Colors.orange[700],
                    )),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NotificationPage(myid.toString()),
                          ));
                    },

                    icon: Icon(
                      Icons.notifications_active,
                      color: Colors.orange[700],
                    )),


              ],
            ),
            body: tabs[_currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              elevation: 0,
              backgroundColor: Colors.white,
              currentIndex: _currentIndex,
              selectedLabelStyle: TextStyle(color: Colors.orange[800]),
              showUnselectedLabels: true,
              showSelectedLabels: true,
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                    color: Colors.orange[800],
                    size: 30,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    FontAwesomeIcons.book,
                    color: Colors.orange[800],
                    size: 25,
                  ),
                  label: "",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.account_circle,
                    color: Colors.orange[800],
                    size: 30,
                  ),
                  label: "",
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;

                });
              },
            ),
          );
        }

    },);


  }
}
