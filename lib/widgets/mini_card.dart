import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';

class MiniCard extends StatelessWidget {
  final Widget child;


  MiniCard({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(

      height: MediaQuery.of(context).size.height / 1.4,
      color: MediaQuery.of(context).platformBrightness ==
          Brightness.dark
          ? Colors.white
          : Color(0xff757575).withOpacity(0.5),

      child: Container(
        padding: EdgeInsets.all(24.0),
        decoration: BoxDecoration(
          color: MediaQuery.of(context).platformBrightness == Brightness.dark ? Colors.blue : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: this.child,
      ),
    );
  }
}
