import 'package:bn_staff/model/room.dart';
import 'package:flutter/material.dart';

class RoomToCleanItem extends StatefulWidget {
  final bool isClean;

  final room;

  RoomToCleanItem({this.room,this.isClean = true});

  @override
  _RoomToCleanItemState createState() => _RoomToCleanItemState();
}

class _RoomToCleanItemState extends State<RoomToCleanItem> {
  var ratioForStatus = 24;
  var checkTapped = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 60,
        child: Row(
          children: [
            Expanded(
              flex: ratioForStatus,
              child: Center(
                child: Icon(Icons.lock),
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
                      Text('Room 22'),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'First Floor Right Wing',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(this.checkTapped ? Icons.check_box : Icons.check_box_outline_blank),
              onPressed: () {
                setState(
                  () {
                    this.checkTapped = !this.checkTapped;
                  },
                );
              },
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}

//
