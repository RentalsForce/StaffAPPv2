import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/core/constants.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/util/custom_app_bar.dart';
import 'package:bn_staff/util/dialog_utils.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/ink_well.dart';

import 'package:bn_staff/widgets/next_icon.dart';
import 'package:bn_staff/widgets/room_floor.dart';
import 'package:bn_staff/widgets/status.dart';
import 'package:bn_staff/widgets/top_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:expandable/expandable.dart';
import 'custom_room_detail.dart';
import 'mini/edit_bulk.dart';

class TasksHome extends StatefulWidget {
  @override
  _TasksHomeState createState() => _TasksHomeState();
}

class _TasksHomeState extends State<TasksHome>
    with SingleTickerProviderStateMixin {
  ScrollController scrollController = new ScrollController();
  bool isVisible = true;

  Hotel hotel;

  bool roomsToClean = false;
  bool allRooms = true;

  int totalReportedHomes = 0;

  void getData() {
    EasyLoading.show(
      status: 'loading...',
    );
    //getTotalReported

    RoomApiProvider().getTotalReported(successCallBack: (result) {
      setState(() {
        this.totalReportedHomes = result;
      });

      return;
    });

    RoomApiProvider().getRooms(
      successCallBack: (result) {
        setState(() {});

        this.hotel = result;

        EasyLoading.dismiss();

        return;
      },
      failedCallBack: () {
        EasyLoading.dismiss();
      },
    );
  }

  @override
  initState() {
    super.initState();

    this.getData();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (isVisible)
          setState(() {
            isVisible = false;
          });
      }
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!isVisible)
          setState(() {
            isVisible = true;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar.buildAppBar('Tasks', context),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Config.COMMON_PADDING),
          child: this.hotel == null
              ? Container()
              : Column(
                  children: [
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      width: MediaQuery.of(context).size.width /
                          Config.HOME_CARD_WIDTH_RATIO,
                      height: isVisible
                          ? MediaQuery.of(context).size.width /
                              Config.HOME_CARD_HEIGHT_RATIO
                          : 0,
                      child: Container(
                        child: Card(
                          elevation: 8,
                          color: PColors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 14,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 11,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 16, left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Text(
                                              'Rooms Left To Clean',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              this
                                                  .hotel
                                                  .roomToBeCleaned
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 40,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Stack(
                                        children: [
                                          SfRadialGauge(
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                minimum: 0,
                                                maximum: 100,
                                                startAngle: 270,
                                                endAngle: 270,
                                                showLabels: false,
                                                showTicks: false,
                                                radiusFactor: 0.8,
                                                axisLineStyle: AxisLineStyle(
                                                    cornerStyle:
                                                        CornerStyle.bothFlat,
                                                    color: Colors.black12,
                                                    thickness: 6),
                                                pointers: <GaugePointer>[
                                                  RangePointer(
                                                    value: this
                                                        .hotel
                                                        .roomCleanedPercent,
                                                    cornerStyle:
                                                        CornerStyle.bothFlat,
                                                    width: 6,
                                                    sizeUnit: GaugeSizeUnit
                                                        .logicalPixel,
                                                    color:
                                                        PColors.backgroundColor,
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          Center(
                                            child: Text(
                                              this.hotel.roomCleanPercent,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 9,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: Container(
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: MiniCardInfo(
                                            label: 'Rooms Cleaned',
                                            count: this.hotel.roomCleaned,
                                          ),
                                        ),
                                        Expanded(
                                          child: MiniCardInfo(
                                            label: 'Total Rooms',
                                            count: this.hotel.totalRooms,
                                          ),
                                        ),
                                        Expanded(
                                          child: this.totalReportedHomes == 0
                                              ? Container()
                                              : MiniCardInfo(
                                                  label: 'Reported',
                                                  count:
                                                      this.totalReportedHomes,
                                                ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isVisible,
                      child: SizedBox(
                        height: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TopButton(
                            text:
                                'Rooms to Clean(${this.hotel.roomToBeCleaned})',
                            isSelected: roomsToClean,
                            onTap: () {
                              setState(() {
                                if (roomsToClean == false) {
                                  this.roomsToClean = true;
                                  this.allRooms = false;
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: TopButton(
                            text: 'All Rooms(${this.hotel.totalRooms})',
                            isSelected: allRooms,
                            onTap: () {
                              setState(() {
                                if (allRooms == false) {
                                  this.roomsToClean = false;
                                  this.allRooms = true;
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Expanded(
                      child: ListView.separated(
                        controller: scrollController,
                        itemCount: this.hotel.floors.length + 1,
                        separatorBuilder: (BuildContext context, int index) =>
                            Container(
                          height: 20,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if (roomsToClean) {
                            if (this.hotel.floors.length == index) {
                              if (this
                                      .hotel
                                      .meetingFloor
                                      .rooms
                                      .where((e) =>
                                          e.roomStatus != RoomStatus.cleaned)
                                      .length ==
                                  0) {
                                return Container();
                              }

                              return Card1(
                                currentFloor: hotel.meetingFloor,
                                isMeetingRoom: true,
                                isCleanFilter: true,
                                reloadData: getData,
                              );
                            }

                            if (this
                                    .hotel
                                    .floors[index]
                                    .rooms
                                    .where((e) =>
                                        e.roomStatus != RoomStatus.cleaned)
                                    .toList()
                                    .length ==
                                0) {
                              return Container();
                            }
                            return Card1(
                              currentFloor: this.hotel.floors[index],
                              isCleanFilter: true,
                              reloadData: getData,
                            );
                          }

                          if (this.hotel.floors.length == index) {
                            return Card1(
                              currentFloor: this.hotel.meetingFloor,
                              isMeetingRoom: true,
                              reloadData: getData,
                            );
                          }
                          return Card1(
                            currentFloor: this.hotel.floors[index],
                            reloadData: getData,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class MiniCardInfo extends StatelessWidget {
  final String label;
  final int count;

  const MiniCardInfo({
    Key key,
    this.label,
    this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          this.label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          this.count.toString(),
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class Card1 extends StatelessWidget {
  bool isMeetingRoom;
  Floor currentFloor;
  bool isCleanFilter;
  VoidCallback reloadData;

  Card1(
      {this.currentFloor,
      this.isMeetingRoom = false,
      this.isCleanFilter = false,
      this.reloadData});

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: new BorderSide(color: Colors.grey, width: 1.0),
      ),
      elevation: 2,
      child: Column(
        children: <Widget>[
          ScrollOnExpand(
            scrollOnExpand: true,
            scrollOnCollapse: false,
            child: ExpandablePanel(
              theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor:
                    ShortMethods.giveColor(context, Colors.black, Colors.white),
                tapBodyToCollapse: true,
              ),
              header: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        this.currentFloor.floorName,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        this.currentFloor.roomsToCleans.toString(),
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 26,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Rooms\nLeft',
                    ),
                    SizedBox(
                      width: 4,
                    ),
                  ],
                ),
              ),
              expanded: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    height: 1,
                  ),
                  Container(
                    height: 40,
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, top: 8),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: PInkWell(
                          onTap: () {
                            print('Bulk Tappedl');
                            showBottomSheit(context, EditBulk());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(32, 150, 243, 0.3),
                              borderRadius: BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            //background: rgba(32, 150, 243, 0.15);
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Clean Bulk Edit',
                                style: TextStyle(
                                  color: Color.fromRGBO(32, 150, 243, 1),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  for (Room room in this.isCleanFilter
                      ? this
                          .currentFloor
                          .rooms
                          .where((e) => e.roomStatus != RoomStatus.cleaned)
                          .toList()
                      : this.currentFloor.rooms)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: PInkWell(
                        onTap: () async {
                          var tmpRoom = room;

                          var somethingChanged = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CustomRoomDetail(room: tmpRoom),
                                fullscreenDialog: true),
                          );
                          if (somethingChanged != null) {
                            if (somethingChanged == true) {
                              this.reloadData();

                            }
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: RoomFloor(
                                  room: room.name,
                                  wing: room.wingName,
                                ),
                              ),
                              StatusView(
                                status: room.roomStatus,
                              ),
                              NextIcon(),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
