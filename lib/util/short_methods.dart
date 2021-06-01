import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ShortMethods {

  static Color giveColor(context , light, dart){

    if (MediaQuery.of(context).platformBrightness == Brightness.dark) {
      return dart;
    }
    return light;
  }
}