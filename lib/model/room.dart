import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Floor {
  List<Room> rooms;
  int numberOfRooms;
  int roomsToCleans;

  bool isMeetingFloor;

  String get floorName {
    if (this.isMeetingFloor) {
      return 'Meeting Rooms';
    }

    return this.ordinalAge(this.rooms[0].floorNo) + ' Floor';
  }

  String ordinalAge(int number) {
    if (number == 11 || number == 12 || number == 13) {
      return '${number}th';
    }
    if (number % 10 == 1) {
      return '${number}st';
    }
    if (number % 10 == 2) {
      return '${number}nd';
    }
    if (number % 10 == 3) {
      return '${number}rd';
    }
    return '${number}th';
  }
}

class Hotel {
  int totalRooms;
  int roomToBeCleaned;
  int roomCleaned;
  int numberOfReportedRooms;

  List<Floor> floors;
  Floor meetingFloor;

  double get roomCleanedPercent {
    return this.roomCleaned / totalRooms * 100.0;
  }

  String get roomCleanPercent {
    return roomCleanedPercent.round().toString() + '%';
  }

  Hotel.fromJson(List<dynamic> orderList) {
    var hotelList = (orderList as List)
        .map((e) => Room.fromJson(e))
        .toList()
        .where((e) => e.roomType == RoomType.hotelRoom)
        .toList();
    meetingFloor = Floor();
    meetingFloor.rooms = (orderList as List)
        .map((e) => Room.fromJson(e))
        .toList()
        .where((e) => e.roomType == RoomType.meetingRoom)
        .toList();
    meetingFloor.numberOfRooms = meetingFloor.rooms.length;

    meetingFloor.roomsToCleans = meetingFloor.rooms
        .where((element) => element.roomStatus != RoomStatus.cleaned)
        .length;

    meetingFloor.isMeetingFloor = true;

    int numberOfRooms = meetingFloor.numberOfRooms;
    int numberOfRoomsToBeCleaned = meetingFloor.roomsToCleans;

    var distinct = <int>[];

    var idSet = <String>{};

    for (var d in hotelList) {
      if (idSet.add(d.floorNo.toString())) {
        distinct.add(d.floorNo);
      }
    }
    floors = [];

    for (int number in distinct) {
      Floor current = Floor();
      current.rooms =
          hotelList.where((element) => element.floorNo == number).toList();
      current.numberOfRooms = current.rooms.length;

      current.roomsToCleans = current.rooms
          .where((element) => element.roomStatus != RoomStatus.cleaned)
          .length;

      current.isMeetingFloor = false;

      floors.add(current);
      numberOfRooms += current.numberOfRooms;

      numberOfRoomsToBeCleaned += current.roomsToCleans;
    }

    this.totalRooms = numberOfRooms;
    this.roomToBeCleaned = numberOfRoomsToBeCleaned;
    this.roomCleaned = numberOfRooms - numberOfRoomsToBeCleaned;

    print('Check');
  }


  /*
  Floor get filteredMeetingFloor {
    var tmp = this.meetingFloor;

    var c = meetingFloor.rooms
        .where((e) => e.roomStatus != RoomStatus.cleaned)
        .toList();
    tmp.rooms = c;

    return tmp;
  }
*/
  /*
  List<Floor> get filteredCleanFloor {
    var copyList = floors.map((v) => v).toList();

    copyList = [];

    for (Floor currentFloor in this.floors) {
      var tmp = currentFloor;

      var c = currentFloor.rooms
          .where((e) => e.roomStatus != RoomStatus.cleaned)
          .toList();
      tmp.rooms = c;

      copyList.add(tmp);
    }

    return copyList;
  }
  */


//  print('');

}

class Room {
  String id;
  String name;
  RoomStatus roomStatus;
  int floorNo;

  RoomType roomType;

  String wingName;

  String ordinalAge(int number) {
    if (number == 11 || number == 12 || number == 13) {
      return '${number}th';
    }
    if (number % 10 == 1) {
      return '${number}st';
    }
    if (number % 10 == 2) {
      return '${number}nd';
    }
    if (number % 10 == 3) {
      return '${number}rd';
    }
    return '${number}th';
  }

  String get floorName {

    return this.ordinalAge(this.floorNo) + ' Floor';
  }


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
    } else if (roomStatus == RoomStatus.reported) {
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
    } else if (roomStatus == RoomStatus.reported) {
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
      return Color.fromRGBO(8, 131, 237, 1); //background: rgba(8, 131, 237, 1);
    } else if (roomStatus == RoomStatus.reported) {
      return Colors.red;
    }
    return Colors.red;
  }

  Room.fromJson(Map<String, dynamic> json) {
    print(json);

    id = json['Id'];
    name = json['Name'];
    if (json['Status__c'] == 'Clean') {
      roomStatus = RoomStatus.cleaned;
    } else if (json['Status__c'] == 'Dirty') {
      roomStatus = RoomStatus.dirty;
    } else {
      roomStatus = RoomStatus.reported;
    }
    var c = json['attributes'];
//    roomType = json['attributes']['type'];
    this.wingName = json['Unit_Location__c'];

    this.floorNo = double.parse(json['Apartment_Floor__c'].toString()).round();

    var roomType = json['Room_Type_Lookup__r']['Room_Class__c'];
    if (roomType != 'Hotel Room') {
      this.roomType = RoomType.meetingRoom;
    } else {
      this.roomType = RoomType.hotelRoom;
    }
  }
}

enum RoomStatus { none, cleaned, dirty, reported }
enum RoomType { none, hotelRoom, meetingRoom }

class ResponseWrapper {
  String status;
  String housekeepingNotes;

  ResponseWrapper({this.status, this.housekeepingNotes = ''});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status__c'] = this.status;
    //data['Housekeeping_Notes__c'] = housekeepingNotes;

    return data;
  }
}
