import 'package:flutter/material.dart';

class Config {
  Config._();

  static const BASE_URL = 'https://bntso2--tsodev5.my.salesforce.com';
  static const LANGUAGE_CODE = 'en';
  static const Grant_type = 'password';
  static const Client_Id =
      '3MVG99E3Ry5mh4zqUIFQhDiKTDEq81eTSckxCqJT.W4gBquUIDoagUdi6b38dcXEec.EEUylVyiFvwmwCLdiF';
  static const Client_Secret =
      '3541ECD3151E5E871A858D1EC99FF2996B50A3BC1956E43A2A23278134E45867';

  static const error_updating_status = 'Error while updating status';

//username = bookingninjas.tso2@isvedition.org.tsodev5
//password = Targetman9988$ypqrLXFM3io3ozghvWaCq980

  static const LOGIN_ENDPOINT = '/services/oauth2/token';

  static const SALES_LOGIN_URL = 'https://bn-sfauth.herokuapp.com/api/session';
//https://bn-sfauth.herokuapp.com/api/session?username=bookingninjas.tso2@isvedition.org.syafiq&password=Amikom2010&is_test=true
//
  //?username=bookingninjas.tso2@isvedition.org.teguh&password=Amikom2010&is_test=true

  static const SESSION_ID_KEY = 'session_id';
  static const SESSION_USERNAME_KEY = 'username';
  static const SESSION_PASSWORD_KEY = 'password';
  static const SESSION_IS_TEST_KEY = 'isText';

  static const COMMON_PADDING = 16.0;

  static const HOME_CARD_WIDTH_RATIO = 1.1;

  static const HOME_CARD_HEIGHT_RATIO = 2.45;



}

class MutualActions {
  /*
  static openLink(String url) async {



    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }


  }*/

  static void goToView(var newView, BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => newView),
    );
  }

//side_menu

}
