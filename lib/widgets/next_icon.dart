import 'package:bn_staff/util/short_methods.dart';
import 'package:flutter/material.dart';

class NextIcon extends StatelessWidget {
  NextIcon({this.showPrimaryColor = false});

  bool showPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Icon(
      //here
      Icons.navigate_next,
      color: ShortMethods.giveColor(context, Colors.black, Colors.white),
      /*    color: showPrimaryColor ? PColors.primary_color : MediaQuery.of(context).platformBrightness ==
          Brightness.dark ? PColors.text_colorDart : PColors.text_color,
  */
    );
  }
}
