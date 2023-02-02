import 'dart:async';
import 'package:acikliyorum/pages/control_page.dart';
import 'package:acikliyorum/pages/login_page_second.dart';
import 'package:acikliyorum/pages/main_pages/main_pages.dart';
import 'package:flutter/material.dart';
import '../utils/database_helper.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin{
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  var dbHelper = DbHelper();

  String? user;
  bool control=true;




  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      await dbHelper.initializeDb();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ControlPage()));

    });
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
          body: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/background.jpeg"))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SlideTransition(
                    position: _offsetAnimation,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(image: AssetImage("assets/logo.png"),width: 300,),
                    ),
                  ),
                  const SizedBox(height: 90,),
                  CircularProgressIndicator(color: Colors.orange[700],),
                ],
              ),
            ),
          ),
    );

  }

}
