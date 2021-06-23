import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/model/room_detail.dart';
import 'package:bn_staff/util/dialog_utils.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/image_control.dart';
import 'package:bn_staff/widgets/ink_well.dart';
import 'package:bn_staff/widgets/status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'mini/add_maintenance_request.dart';
import 'mini/change_room_status.dart';
import 'mini/replace_broken_item.dart';

class CustomRoomDetail extends StatefulWidget {
  Room room;

  CustomRoomDetail({this.room});

  @override
  _CustomRoomDetailState createState() => _CustomRoomDetailState();
}

class _CustomRoomDetailState extends State<CustomRoomDetail> {
  RoomDetailModel model;

  bool somethingChanged = false;

  Widget getStatus() {
    if (this.widget.room.roomStatus == RoomStatus.cleaned) {
      return CleanView();
    } else if (this.widget.room.roomStatus == RoomStatus.reported) {
      return ReportedView();
    }
    return DirtyView();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //getRoomReportDetails
    RoomApiProvider().getRoomReportDetails(this.widget.room.id,
        successCallBack: (result) {
      setState(
        () {
          model = result;
        },
      );
      return;
    }, failedCallBack: () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.room.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ShortMethods.giveColor(context, Colors.black, Colors.white),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(color: Colors.grey, spreadRadius: 1),
                      ],
                    ),
                    child: WCImageAsset('room_pic.png')),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    TopLabelsControl(
                      'Status',
                      subwidget: StatusView(
                        status: this.widget.room.roomStatus,
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TopLabelsControl(
                        'Floor',
                        mainText: this.widget.room.floorName,
                      ),
                    ),
                    Expanded(
                      child: TopLabelsControl(
                        'Location',
                        mainText: this.widget.room.wingName,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              if (model == null) ...[
                SizedBox(
                  height: 50,
                  width: 50,
                  child: Row(
                    children: [
                      CircularProgressIndicator(),
                      Expanded(
                        child: Container(),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                TopLabelsControl(
                  'Maintainance Requests',
                  mainText:
                      model == null ? '' : this.model.maintainanceLabelString,
                ),
              ],
              SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  ListItem(
                    title: 'Change Room Status',
                    onTap: () async {
                      RoomStatus status =
                          await showBottomSheit(context, ChangeRoomStatus());

                      if (status != null) {
                        if (status != this.widget.room.roomStatus) {
                          //Call change room status service
                          EasyLoading.show(
                            status: 'loading...',
                          );
                          //here
                          RoomApiProvider()
                              .changeRoomStatus(this.widget.room.id, status,
                                  successCallBack: (result) {
                            EasyLoading.dismiss();

                            this.somethingChanged = true;

                            Navigator.pop(context, true);

                            return;
                          }, failedCallBack: () {
                            EasyLoading.dismiss();
                            EasyLoading.showError(
                                'Error while changing Status');
                          });
                        }
                      }
                      //EditBulk
                    },
                  ),
                  ListItem(
                    title: 'Replace Broken Item',
                    onTap: () {
                      showBottomSheit(
                        context,
                        ReplaceBrokenItem(
                          model: this.model,
                        ),
                      );
                    },
                  ),
                  ListItem(
                    title: 'Add Maintenance Request ',
                    onTap: () {
                      showBottomSheit(
                        context,
                        AddMaintenanceRequest(
                          model : this.model
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  ListItem({@required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: PInkWell(
        onTap: this.onTap,
        child: ListTile(
          title: Text(
            this.title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 17,
                color: ShortMethods.giveColor(
                    context, Colors.black, Colors.white)),
          ),
          trailing: Icon(
            Icons.navigate_next,
            color: ShortMethods.giveColor(context, Colors.black, Colors.white),
          ),
        ),
      ),
    );
  }
}

class TopLabelsControl extends StatelessWidget {
  final String labelText;
  final Widget subwidget;
  final String mainText;

  TopLabelsControl(this.labelText, {this.subwidget, this.mainText});

  Widget buildSubHeadingText(String text) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        color: PColors.lightGray2,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSubHeadingText(this.labelText),
        SizedBox(
          height: 8,
        ),
        if (this.mainText == null) ...[
          subwidget,
        ] else ...[
          Text(
            this.mainText,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ],
    );
  }
}

//
