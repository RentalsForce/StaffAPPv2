import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/pages/room_detail.dart';
import 'package:bn_staff/util/short_methods.dart';
import 'package:bn_staff/widgets/elevated_button.dart';
import 'package:bn_staff/widgets/mini_card.dart';
import 'package:bn_staff/widgets/mini_header_text.dart';
import 'package:flutter/material.dart';

class ChangeRoomStatus extends StatefulWidget {
  @override
  _ChangeRoomStatusState createState() => _ChangeRoomStatusState();
}

class _ChangeRoomStatusState extends State<ChangeRoomStatus> {
  int indexSelected = 0;

  RoomStatus selectedStatus = RoomStatus.none;

  @override
  Widget build(BuildContext context) {
    return MiniCard(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 8,
            ),
            Align(
              child: MiniHeaderText(
                text: 'Change Room Status',
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              'Select New Status - Room #22',
              style: TextStyle(
                color: ShortMethods.giveColor(context, PColors.gray, PColors.grayColorForDark),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            LinkedLabelRadio(
              label: 'Clean',
              padding: EdgeInsets.all(8.0),
              value: true,
              groupValue: indexSelected == 1,
              onChanged: (value) {
                if (value == true) {
                  setState(
                    () {
                      selectedStatus = RoomStatus.cleaned;
                      indexSelected = 1;

                      print(selectedStatus);
                    },
                  );
                } else {
                  setState(
                    () {
                      indexSelected = 1;

                      selectedStatus = RoomStatus.none;
                      print(selectedStatus);
                    },
                  );
                }
              },
            ),
            LinkedLabelRadio(

              label: 'Dirty',
              padding: EdgeInsets.all(8.0),
              value: true,
              groupValue: indexSelected == 2,
              onChanged: (value) {
                if (value == true) {
                  setState(
                    () {
                      selectedStatus = RoomStatus.reported;
                      indexSelected = 2;

                      print(selectedStatus);
                    },
                  );
                } else {
                  setState(
                    () {
                      indexSelected = 2;

                      selectedStatus = RoomStatus.none;
                      print(selectedStatus);
                    },
                  );
                }
              },
            ),
            LinkedLabelRadio(

              label: 'Report',
              padding: EdgeInsets.all(8.0),
              value: true,
              groupValue: indexSelected == 3,
              onChanged: (value) {
                if (value == true) {
                  setState(
                    () {
                      selectedStatus = RoomStatus.dirty;
                      indexSelected = 3;

                      print(selectedStatus);
                    },
                  );
                } else {
                  setState(
                    () {
                      indexSelected = 3;

                      selectedStatus = RoomStatus.none;
                      print(selectedStatus);
                    },
                  );
                }
              },
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
      ),
    );
  }
}
