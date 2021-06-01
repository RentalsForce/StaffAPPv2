import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/model/room.dart';
import 'package:flutter/material.dart';

class StatusView extends StatelessWidget {
  final RoomStatus status;

  StatusView({this.status = RoomStatus.dirty});

  @override
  Widget build(BuildContext context) {
    if (this.status == RoomStatus.cleaned) {
      return CleanView();
    } else if (this.status == RoomStatus.reported) {
      return ReportedView();
    }
    return DirtyView();
  }
}

class ReportedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 15,
          color: PColors.redColor,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          'Reported',
          style: TextStyle(
            color: PColors.redColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class CleanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 15,
          color: PColors.blue,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          'Clean',
          style: TextStyle(
            color: PColors.blue,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

class DirtyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 15,
          color: PColors.orange,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          'Needs Cleaning',
          style: TextStyle(
            color: PColors.orange,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
