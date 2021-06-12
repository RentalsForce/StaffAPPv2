import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/util/dialog_utils.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/image_control.dart';
import 'package:bn_staff/widgets/ink_well.dart';
import 'package:bn_staff/widgets/status.dart';
import 'package:flutter/material.dart';

import 'mini/add_maintenance_request.dart';
import 'mini/change_room_status.dart';
import 'mini/replace_broken_item.dart';

class CustomRoomDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Room #22',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: ShortMethods.giveColor(context , Colors.black , Colors.white),
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
                      subwidget: StatusView(),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TopLabelsControl(
                        'Floor',
                        mainText: '99th Floor',
                      ),
                    ),
                    Expanded(
                      child: TopLabelsControl(
                        'Location',
                        mainText: 'Right Wing',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TopLabelsControl(
                'Maintainance Requests',
                mainText: 'None',
              ),
              SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  ListItem(
                    title: 'Change Room Status',
                    onTap: () {
                      //
                      showBottomSheit(context, ChangeRoomStatus());

                      //EditBulk
                    },
                  ),
                  ListItem(
                    title: 'Replace Broken Item',
                    onTap: () {
                      showBottomSheit(context, ReplaceBrokenItem());
                    },
                  ),

                  ListItem(
                    title: 'Add Maintenance Request ',
                    onTap: () {
                      showBottomSheit(context, AddMaintenanceRequest());
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
            style: TextStyle(fontSize: 17, color: ShortMethods.giveColor(context , Colors.black , Colors.white)),
          ),
          trailing: Icon(Icons.navigate_next ,
          color: ShortMethods.giveColor(context , Colors.black , Colors.white),
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
          StatusView(),
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
