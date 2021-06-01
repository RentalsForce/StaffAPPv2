import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class User {
  String username;
  String password;
  String accessToken;
  String instanceUrl;
  String id;
  String tokenType;
  String issuedAt;
  String signature;

  static Future<User> getCurrentUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var user = prefs.getString('user');

    if (user == null) {
      return null;
    }
    return User.fromJson(json.decode(user), null, null);
  }

  User.fromJson(Map<String, dynamic> json, String username, String password) {
    accessToken = json['access_token'];
    instanceUrl = json['instance_url'];
    id = json['id'];
    tokenType = json['token_type'];
    issuedAt = json['issued_at'];
    signature = json['signature'];
    if (username == null) {
      this.username = json['username'];
      ;
      this.password = json['password'];
      ;
    } else {
      this.username = username;
      this.password = password;
    }
  }

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'access_token': accessToken,
        'instance_url': instanceUrl,
        'id': id,
        'token_type': tokenType,
        'issued_at': issuedAt,
        'signature': signature,
      };

/*


  {
    "access_token": "00D0n0000004jZf!ARgAQDdyJgfPTpxDSQfQX_.1UhISayWNUe63VxJP6ENhCI2b4jmOtIMAKN1W0eQBIRZm5SBG8cOelY5jN6wUDI2Fyx9J993K",
    "instance_url": "https://bntso2--tsodev5.my.salesforce.com",
    "id": "https://test.salesforce.com/id/00D0n0000004jZfEAI/0056A000000pWk0QAE",
    "token_type": "Bearer",
    "issued_at": "1619629753570",
    "signature": "XzWpUwQmmPVM+Rgv4+vU44sEspt2Sjoesfa/C2g6PpQ="
}

  * */
}
