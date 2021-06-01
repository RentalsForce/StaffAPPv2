import 'dart:convert';

import 'package:bn_staff/core/colors.dart';
import 'package:bn_staff/core/constants.dart';
import 'package:bn_staff/model/room.dart';
import 'package:bn_staff/model/user.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

export 'package:dio/dio.dart';

final Dio _dio = Dio();

final String _endpoint = Config.BASE_URL;

class LoginApiProvider {
  Future<void> getSalesForceSession(
      String username, String password, bool isTest,
      {Function successCallBack, Function failedCallBack}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      var url = Config.SALES_LOGIN_URL;

      Response response = await _dio.get(url, queryParameters: {
        'username': username,
        'password': password,
        'is_test': isTest
      });

      if (int.parse(response.data['status'].toString()) == 1) {
        var c = response.data['session_id'];

        await prefs.setString(Config.SESSION_ID_KEY, c);
        await prefs.setString(Config.SESSION_USERNAME_KEY, username);
        await prefs.setString(Config.SESSION_PASSWORD_KEY, password);
        await prefs.setBool(Config.SESSION_IS_TEST_KEY, isTest);

        //SESSION_IS_TEST_KEY
        successCallBack();
      } else {
        failedCallBack.call();
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      failedCallBack.call();

      //return UserResponse.withError("$error");
    }
  }
}

class RoomApiProvider {
  Future<void> getRooms(
      {Function successCallBack(result), Function failedCallBack}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var url =
          'https://bntso2--teguh.my.salesforce.com/services/data/v51.0/query/?q=select+id,name,status__c,housekeeping_notes__c+from+unit__c';

      var tmp = prefs.getString(Config.SESSION_ID_KEY);

      _dio.options.headers['Authorization'] = 'Bearer ' + tmp;

      Response response = await _dio.get(
        url,
      );

      print(response.data);

      var rooms = RoomList.fromJson(response.data['records']);

      successCallBack(rooms);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      failedCallBack.call();

      //return UserResponse.withError("$error");
    }
  }

  Future<void> changeRoomStatus(String recordId, RoomStatus newStautus,
      {Function successCallBack, Function failedCallBack}) async {
    try {
      var url =
          'https://bntso2--teguh.my.salesforce.com/services/data/v51.0/sobjects/Unit__c/' +
              recordId;

      ResponseWrapper statusChange = ResponseWrapper(
        status: Room.roomString(newStautus),
      );

      print(statusChange.toJson());
      Response response = await _dio.patch(url, data: statusChange.toJson());

      print(response.data);
      successCallBack([]);

      return;

      // return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      failedCallBack.call();

      //return UserResponse.withError("$error");
    }
  }

  Future<void> martAsReported(String recordId, String notes,
      {Function successCallBack, Function failedCallBack}) async {
    try {
      var url =
          'https://bntso2--teguh.my.salesforce.com/services/data/v51.0/sobjects/Unit__c/' +
              recordId;

      ResponseWrapper statusChange =
          ResponseWrapper(status: 'Reported', housekeepingNotes: notes);

      print(statusChange.toJson());

      Response response = await _dio.patch(url, data: statusChange.toJson());

      print(response.data);
      successCallBack([]);

      return;

      // return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      failedCallBack.call();

      //return UserResponse.withError("$error");
    }
  }
}
