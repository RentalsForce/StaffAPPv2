
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoomList {

  List<Room> list;

  RoomList.fromJson(List<dynamic> orderList) {

    list =
        (orderList as List).map((e) => Room.fromJson(e)).toList();

  }

}


class Room {
  String id;
  String name;
  RoomStatus roomStatus;

  String roomType;


  static String roomString(roomStatus) {

    if (roomStatus == RoomStatus.cleaned) {
      return 'Clean';
    }
    /*
    else if (roomStatus == RoomStatus.checkIn) {
      return 'Check In';
    }
    else if (roomStatus == RoomStatus.checkIn) {
      return 'Check Out';
    }*/
    else if (roomStatus == RoomStatus.dirty) {
      return 'Dirty';
    }
    else if (roomStatus == RoomStatus.reported) {
      return 'Reported';
    }
    return '';
  }
  static String roomStringToShow(roomStatus) {

    if (roomStatus == RoomStatus.cleaned) {
      return 'Clean';
    }

/*    else if (roomStatus == RoomStatus.checkIn) {
      return 'Check In';
    }
    else if (roomStatus == RoomStatus.checkIn) {
      return 'Check Out';
    }*/


    else if (roomStatus == RoomStatus.dirty) {
      return 'To-Do';
    }
    else if (roomStatus == RoomStatus.reported) {
      return 'Reported';
    }
    return '';
  }


  Color roomStatucColor() {

    if (roomStatus == RoomStatus.cleaned) {
      return Color.fromRGBO(38, 192, 198, 1);
    }

/*    else if (roomStatus == RoomStatus.checkIn) {
      return Colors.blueGrey;
    }
    else if (roomStatus == RoomStatus.checkOut) {
      return Colors.black;
    }*/

    else if (roomStatus == RoomStatus.dirty) {
      return Color.fromRGBO(8, 131, 237, 1);//background: rgba(8, 131, 237, 1);
    }
    else if (roomStatus == RoomStatus.reported) {
      return Colors.red;
    }
    return Colors.red;
  }

  Room.fromJson(Map<String, dynamic> json) {

    id = json['Id'];
    name = json['Name'];
    if (json['Status__c'] == 'Clean') {
      roomStatus = RoomStatus.cleaned;
    }
    else if (json['Status__c'] == 'Dirty') {
      roomStatus = RoomStatus.dirty;
    }
    else {

      roomStatus = RoomStatus.reported;
    }
    var c = json['attributes'];
    roomType = json['attributes']['type'];
    print(roomType);

  }
}

enum RoomStatus {  none , cleaned, dirty ,reported }






class ResponseWrapper {
  String status;
  String housekeepingNotes;

  ResponseWrapper({ this.status,this.housekeepingNotes = ''});



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status__c'] = this.status;
    data['Housekeeping_Notes__c'] = housekeepingNotes;

    return data;
  }
}
