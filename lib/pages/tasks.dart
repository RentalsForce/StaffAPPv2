import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/model/user.dart';
import 'package:bn_staff/pages/rooms_to_clean.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/widgets/no_task.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'all_rooms.dart';
import 'dart:io' show Platform;

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int _sliding = 0;

  bool showingAll = true;

  bool foundError = false;

  Hotel list;
  List<Room> roomToClean = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    EasyLoading.show(
      status: 'loading...',
    );

    getData();
  }

  void getData() {
    RoomApiProvider().getRooms(
        successCallBack: (result) {
          setState(() {
            list = result;
            roomToClean = list.meetingFloor.rooms
                .where((i) => i.roomStatus != RoomStatus.cleaned)
                .toList();
          });
          setState(() {

            this.foundError = false;
          });

          EasyLoading.dismiss();

          return;
        },
        failedCallBack: () {
          EasyLoading.dismiss();

          EasyLoading.showToast('Error while loading data');


          setState(() {

            this.foundError = true;
          });


        });
  }

  AppBar makeAppBar() {
//    if (Platform.isAndroid || 1 == 1) {
    if (Platform.isAndroid) {
      return AppBar(
        leading: Container(),
        backgroundColor: PColors.blue,
        title: Text('Tasks'),
        bottom: TabBar(
          tabs: [
            Tab(
              text: 'Room to Clean',
            ),
            Tab(
              text: 'All Rooms',
            ),
          ],
        ),
      );
    }
    return AppBar(
      leading: Container(),
      backgroundColor: PColors.blue,
      title: Text('Tasks'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: makeAppBar(),
        body: SafeArea(
          child: buildBody(),
        ),
      ),
    );
  }

  Widget buildBody() {
   // if (Platform.isAndroid || 1 == 1) {
      if (Platform.isAndroid ) {
      return TabBarView(
        children: [
          showToCleanView() ,
          showAllRooms()
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
          child: CupertinoSlidingSegmentedControl(
              children: {
                0: Text('Rooms To Clean'),
                1: Text('All Rooms'),
              },
              groupValue: _sliding,
              onValueChanged: (newValue) {
                setState(() {
                  _sliding = newValue;
                  showingAll = !showingAll;
                });
              }),
        ),
        Expanded(
          child: showingAll ? showToCleanView() : showAllRooms(),
        ),
        //
      ],
    );
  }

  Widget showAllRooms() {
    if (this.foundError) {
      return ErrorTaskView(
        onTap: (){
          EasyLoading.show(
            status: 'loading...',
          );

          this.getData();

        },
      );
    }
    if (list == null) {
      return nullCheckView();
    }
    if (list.meetingFloor.rooms.length == 0) {
      if (roomToClean.length == 0) {
        return NoTask();
      }
    }
    return AllRooms(
      roomList: this.list,
      tapped: () {
        this.getData();
      },
    );
  }

  Widget nullCheckView() {
    return Container();
  }

  Widget showToCleanView() {
    if (this.foundError) {
      return ErrorTaskView(
        onTap: (){
          EasyLoading.show(
            status: 'loading...',
          );

          this.getData();

        },
      );
    }
    if (list == null) {
      return nullCheckView();
    }
    if (roomToClean.length == 0) {
      return NoTask();
    }
    return RoomsToClean(
      roomList: this.roomToClean,
      onTap: () {
        this.getData();
      },
    );
  }
}
