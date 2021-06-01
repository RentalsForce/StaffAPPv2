import 'package:flutter/material.dart';

class ListingCard extends StatelessWidget {
  final String floorName;
  final int roomsLeft;
  final VoidCallback onTap;

  const ListingCard({this.floorName, this.roomsLeft, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: new BorderSide(color: Colors.grey, width: 1.0),
      ),
      elevation: 2,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
        child: Row(
          children: [
            Expanded(
              child: Text(
                this.floorName,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Container(
              child: Text(
                this.roomsLeft.toString(),
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
    );
  }
}
