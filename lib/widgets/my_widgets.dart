import 'package:flutter/material.dart';


AppBar acikliyorumAppBar() {
  return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: const Image(
        image: AssetImage("assets/logo.png"),
        alignment: Alignment.centerLeft,
        height: 40,
      ));
}