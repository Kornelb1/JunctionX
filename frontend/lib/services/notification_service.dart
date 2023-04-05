import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/notification.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NotificationService {
  Future<List<Notifications>> getNotifications() async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/notifications/';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    List<Notifications> nots = [];

    Uri uri = Uri.parse(url);

    try {
      Response response = await client.get(uri, headers: headers);

      Map<String, dynamic> responseDecoded = jsonDecode(response.body);

      // print(response.statusCode);
      // print(response.body);

      if (response.statusCode == 200) {
        for (var result in responseDecoded['results']) {
          nots.add(Notifications.fromJson(result));
        }
      }
      return nots;
    } catch (e) {
      // print(e);
      return nots;
    }
  }

  Future<bool> acceptRequest(var id) async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url;

    url =
        'http://10.173.45.133:8000/api/v1/users/accept_friend_request/?requestID=${id}';

    Uri uri = Uri.parse(url);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    try {
      Response response = await client.post(uri, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
