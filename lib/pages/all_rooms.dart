import 'dart:math';

import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/widgets/all_room_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';


class AllRooms extends StatefulWidget {
  final Hotel roomList;

  final Function() tapped;

  AllRooms({this.roomList,this.tapped});

  @override
  _AllRoomsState createState() => _AllRoomsState();
}

class _AllRoomsState extends State<AllRooms> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: this.widget.roomList.meetingFloor.rooms.length,
        itemBuilder: (BuildContext context, int index) {
          return AllRoomsItem(
            room: this.widget.roomList.meetingFloor.rooms[index],
            tapped: (){
              this.widget.tapped();

            },
          );
        }
    );
  }
}





