import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';

class MiniCard extends StatelessWidget {
  final Widget child;


  MiniCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height / 1.4,
      color:  Colors.transparent,

      child: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Color.fromRGBO(30, 30, 30, 1) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Container(
            child: this.child),
      ),
    );
  }
}
