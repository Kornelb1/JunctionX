import 'dart:async';
import 'dart:ffi';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ProfileService {
  Future<List<Challenge>> getMyChallenges() async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/challenges/?my_challenges=true';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    List<Challenge> challenges = [];

    Uri uri = Uri.parse(url);

    try {
      Response response = await client.get(uri, headers: headers);

      Map<String, dynamic> responseDecoded = jsonDecode(response.body);

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        for (var result in responseDecoded['results']) {
          challenges.add(Challenge.fromJson(result));
        }
      }
      return challenges;
    } catch (e) {
      // print(e);
      return challenges;
    }
  }

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
            responseDecoded["email"],
            responseDecoded["id"]
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

  Future<List<User>> getUsers(List<int> user_ids) async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url;

    url = 'http://10.173.45.133:8000/api/v1/users/';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    Uri uri = Uri.parse(url);

    List<User> users = [];

    try {
      Response response = await client.get(uri, headers: headers);

      Map<String, dynamic> responseDecoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var result in responseDecoded['results']) {
          users.add(User.fromJson(result));
        }
      }

      users = users.where((user) => user_ids.contains(user.id)).toList();

      // print(users);

      return users;
    } catch (e) {
      return users;
    }
  }

  Future<List<User>> getFriends() async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url;
    List<User> users = [];

    url = 'http://10.173.45.133:8000/api/v1/users/me/';

    Uri uri = Uri.parse(url);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    List<int> ids = [];
    try {
      Response response = await client.get(uri, headers: headers);

      // print(response.body);
      // print(response.statusCode);

      Map<String, dynamic> responseDecoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        ids = responseDecoded['friends'].cast<int>();
        // print(ids);
      }

      users = await getUsers(ids);

      return users;
    } catch (e) {
      return users;
    }
  }
}
