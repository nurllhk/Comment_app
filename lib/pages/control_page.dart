import 'package:acikliyorum/main.dart';
import 'package:acikliyorum/pages/login_page_second.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:acikliyorum/utils/database_helper.dart';
import 'package:flutter/material.dart';


class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> with TickerProviderStateMixin{
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));



  var dbHelper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: dbHelper.kullaniciSorgu("1"),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          var data = snapshot.data!;
          if(int.parse(data.toString())>=1){
            return MainPages();
          }
          else{
            return SecondLogin();
          }
        }else if(snapshot.hasError){
          return SecondLogin();
        }

        else{
          return Scaffold(
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/background.jpeg"),fit: BoxFit.cover)
              ),
              child: const Center(child: CircularProgressIndicator(),),
            ),
          );
        }


    },);
  }
}
