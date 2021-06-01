import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/pages/room_detail.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:io' show Platform;
import '../core/constants.dart';

class AllRoomsItem extends StatefulWidget {
  final Room room;
  final VoidCallback tapped;

  AllRoomsItem({this.room, this.tapped});

  @override
  _AllRoomsItemState createState() => _AllRoomsItemState();
}

class _AllRoomsItemState extends State<AllRoomsItem> {
  var cleanColor = Color.fromRGBO(38, 192, 198, 1);
  var reportedColor = Colors.red;
  var ratioForStatus = 24;

  void onTap() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RoomDetail(
          selectedRoom: this.widget.room,
        ),
      ),
    );

    if (result != null) {
      if (result == true) {
        this.widget.tapped.call();
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //|| 1 == 1
    return (Platform.isAndroid)
        ? Container(
            child: buildGestureDetector(),
          )
        : Slidable(
            actionPane: SlidableDrawerActionPane(),
            child: buildGestureDetector(),
            actions: actions(),
          );
  }

  List<Widget> actions() {
    return [
      if (this.widget.room.roomStatus != RoomStatus.cleaned) ...[
        IconSlideAction(
          caption: 'Clean',
          color: Colors.blue,
          icon: Icons.archive,
          onTap: () {
            EasyLoading.show(
              status: 'loading...',
            );

            RoomApiProvider()
                .changeRoomStatus(this.widget.room.id, RoomStatus.cleaned,
                    successCallBack: (result) {
              this.widget.tapped.call();
            }, failedCallBack: () {
              EasyLoading.dismiss();
              EasyLoading.showToast(Config.error_updating_status);
            });

            // RoomApiProvider().;
          },
        ),
      ],

      if (this.widget.room.roomStatus != RoomStatus.dirty) ...[
        IconSlideAction(
          caption: 'To-Do',
          color: Colors.indigo,
          icon: Icons.clean_hands_rounded,
          onTap: () {
            this.widget.tapped();

            EasyLoading.show(
              status: 'loading...',
            );

            RoomApiProvider()
                .changeRoomStatus(this.widget.room.id, RoomStatus.dirty,
                    successCallBack: (result) {
              this.widget.tapped();
            }, failedCallBack: () {
              EasyLoading.dismiss();
              EasyLoading.showToast(Config.error_updating_status);
            });
          },
        ),
      ],

      //Checked Input
    ];
  }

  GestureDetector buildGestureDetector() {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          height: 60,
          child: Row(
            children: [
              SizedBox(
                width: 3,
                child: Container(
                  color: cleanColor,
                ),
              ),
              Expanded(
                flex: ratioForStatus,
                child: Center(
                  child: Container(
                    child: Text(
                      //
                      Room.roomStringToShow(widget.room.roomStatus),
                      style: TextStyle(
                          color: widget.room.roomStatucColor(),
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
                width: 1,
                child: Container(
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 100 - ratioForStatus,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.widget.room.name),
                        SizedBox(
                          height: 4,
                        ),
                        Text(this.widget.room.roomType),
                      ],
                    ),
                  ),
                ),
              ),
              Icon(Icons.navigate_next),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// || 1 == 1
