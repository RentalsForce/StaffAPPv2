import 'package:flutter/material.dart';
import '../util/short_methods.dart';
class CustomAppBar extends AppBar {
  static AppBar buildAppBar(String text,context) {
    return AppBar(
      centerTitle: false,
      titleSpacing: 20.0,
      title: Text(
        text,
        style: TextStyle(
          color: ShortMethods.giveColor(context , Colors.black , Colors.white),
          fontWeight: FontWeight.w700,
          fontSize: 22,
        ),
      ),
    );
  }
}
