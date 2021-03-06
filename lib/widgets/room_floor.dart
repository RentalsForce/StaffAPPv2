import 'package:bn_staff/core/colors.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class RoomFloor extends StatelessWidget {

  RoomFloor({this.room,this.wing});

  final String room;
  final String wing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.room,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          wing,
          style: TextStyle(
            fontSize: 15,
          ),
        ),
      ],
    );
  }
}
