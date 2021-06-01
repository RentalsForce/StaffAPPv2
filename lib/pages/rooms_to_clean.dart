import 'dart:math';

import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/widgets/all_room_item.dart';
import 'package:bn_staff/widgets/rooms_to_clean_item.dart';
import 'package:flutter/material.dart';

class RoomsToClean extends StatefulWidget {
  final List<Room> roomList;

  final VoidCallback onTap;

  RoomsToClean({this.roomList,this.onTap});

  @override
  _RoomsToCleanState createState() => _RoomsToCleanState();
}

class _RoomsToCleanState extends State<RoomsToClean> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: this.widget.roomList.length,
        itemBuilder: (BuildContext context, int index) {
          return AllRoomsItem(
            room: this.widget.roomList[index],
            tapped: (){
              this.widget.onTap();
            },
          );
        }
    );
  }
}
