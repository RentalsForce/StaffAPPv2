import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/core/constants.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/pages/report_add_info.dart';
import 'package:bn_staff/util/dio.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/p_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RoomDetail extends StatefulWidget {
  Room selectedRoom;

  RoomDetail({this.selectedRoom});

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  RoomStatus firstState;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstState = widget.selectedRoom.roomStatus;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.widget.selectedRoom.name),
        backgroundColor: PColors.blue,
        actions: [
          IconButton(
            icon: Icon(
              Icons.check,
            ),
            onPressed: () {
              onUpdateTapped(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    'Change room status:', //background: rgba(79, 85, 102, 1);
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: PColors.lightBlack,
                        fontSize: 16),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                LinkedLabelRadio(
                  label: 'To-Do',
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: true,
                  groupValue:
                      this.widget.selectedRoom.roomStatus == RoomStatus.dirty,
                  onChanged: (bool newValue) {
                    setState(() {
                      this.widget.selectedRoom.roomStatus = RoomStatus.dirty;
                    });
                  },
                ),
                LinkedLabelRadio(
                  label: 'Clean',
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: true,
                  groupValue:
                      this.widget.selectedRoom.roomStatus == RoomStatus.cleaned,
                  onChanged: (bool newValue) {
                    setState(() {
                      this.widget.selectedRoom.roomStatus = RoomStatus.cleaned;
                    });
                  },
                ),
                LinkedLabelRadio(
                  label: 'Report',
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  value: true,
                  groupValue: this.widget.selectedRoom.roomStatus ==
                      RoomStatus.reported,
                  onChanged: (bool newValue) {
                    setState(
                      () {
                        this.widget.selectedRoom.roomStatus =
                            RoomStatus.reported;
                      },
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Divider(
                    color: Color.fromRGBO(229, 229, 229, 1),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    'If there are any problems or issues with the room, please, let us know.',
                    style: TextStyle(fontSize: 14, color: PColors.lightBlack),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                PButton(
                  title: 'UPDATE',
                  action: () {
                    onUpdateTapped(context);
                  },
                ),
                //border: 1px solid rgba(229, 229, 229, 1)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onUpdateTapped(BuildContext context) {
    if (this.firstState != this.widget.selectedRoom.roomStatus) {
      print('State was changed');
      if (this.widget.selectedRoom.roomStatus == RoomStatus.reported) {
        goToReport(context);
      } else {
        //change status

        EasyLoading.show(
          status: 'loading...',
        );

        RoomApiProvider().changeRoomStatus(
            this.widget.selectedRoom.id, this.widget.selectedRoom.roomStatus,
            successCallBack: (result) {
          Navigator.pop(context, true);
        }, failedCallBack: () {
          EasyLoading.dismiss();
          EasyLoading.showToast('Error while updating data');
        });
      }
    } else {
      print('State remaining same');
      Navigator.pop(context);
    }
  }

  void goToReport(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReportAddInfo(
          selectedRoom: this.widget.selectedRoom,
        ),
      ),
    );
    if (result != null) {
      RoomApiProvider().martAsReported(this.widget.selectedRoom.id, result,
          successCallBack: (result) {
        Navigator.pop(context, true);
      }, failedCallBack: () {
        EasyLoading.dismiss();
        EasyLoading.showToast(Config.error_updating_status);
      });
    }
  }
}

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    this.label,
    this.padding,
    this.groupValue,
    this.value = false,
    this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              fillColor: MaterialStateColor.resolveWith((states) => PColors.blue),
                groupValue: groupValue,
                value: value,
                onChanged: (bool newValue) {
                  onChanged(newValue);
                },),
            RichText(
              text: TextSpan(
                text: label,
                style:  TextStyle(
                  color: ShortMethods.giveColor(context, PColors.gray, PColors.grayColorForDark) ,
                  fontSize: 16, //background: rgba(79, 85, 102, 1);
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    this.onChanged(!value);
                  },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
