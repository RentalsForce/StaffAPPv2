import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/widgets/room_floor.dart';
import 'package:flutter/material.dart';

class EditBulkItem extends StatefulWidget {
  @override
  _EditBulkItemState createState() => _EditBulkItemState();
}

class _EditBulkItemState extends State<EditBulkItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: RoomFloor(
            room: 'Room #22',
            wing: 'Right Wing',
          ),
        ),
        Checkbox(
          hoverColor: PColors.blue,

          value: isChecked,
          onChanged: (bool value) {
            setState(() {
              this.isChecked = value;
            });
          },
        ),
      ],
    );
  }
}
