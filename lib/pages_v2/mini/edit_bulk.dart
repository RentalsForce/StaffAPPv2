import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/widgets/edit_bulk_item.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:bn_staff/widgets/mini_card.dart';
import 'package:bn_staff/widgets/mini_header_text.dart';
import 'package:bn_staff/widgets/room_floor.dart';
import 'package:flutter/material.dart';

class EditBulk extends StatefulWidget {
  @override
  _EditBulkState createState() => _EditBulkState();
}

class _EditBulkState extends State<EditBulk> {
  @override
  Widget build(BuildContext context) {
    return MiniCard(
      child: Column(
        children: [
          SizedBox(
            height: 8,
          ),
          MiniHeaderText(
            text: 'Change Status to  Clean',
          ),
          SizedBox(
            height: 24,
          ),
          Expanded(
            child: Container(
              child: ListView.separated(
                itemCount: 10,
                separatorBuilder: (BuildContext context, int index) =>
                    Container(
                  height: 20,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return EditBulkItem();
                },
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          PElevatedButton(
            text: 'Save Changes',
            onPressed: () {
              // this.widget.onSave(selectedItem);
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 16,
          ),
          PElevatedButton(
            text: 'Cancel',
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.grey,
          ),
          SizedBox(
            height: 16,
          )
        ],
      ),
    );
  }
}
