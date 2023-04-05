import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    var url = "http://10.173.45.133:8000/api/login/";
    var map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;

    // print(username);
    // print(password);

    try {
      var response = await http
          .post(Uri.parse(url), body: map)
          .timeout(Duration(seconds: 1));

      // print(response.body);
      // print(response.statusCode);
      // print(response.headers);

      if (response.statusCode == 200) {
        var responseDecoded = jsonDecode(response.body)["user"];
        var token = jsonDecode(response.body)["token"];

        UserPreferences().saveUser(
            token,
            responseDecoded["username"],
            responseDecoded["first_name"],
            responseDecoded["last_name"],
            responseDecoded["email"]
            // responseDecoded["profile_picture"]
            );
        return {'status': true, 'message': 'Login successful'};
      } else {
        return {'status': false, 'message': 'Login unsuccessful'};
      }
    } catch (e) {
      // print(e);
      return {
        'status': false,
        'message': 'Oops something went wrong, please try again'
      };
    }
  }
}
