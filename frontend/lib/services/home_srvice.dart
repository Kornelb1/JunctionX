import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../models/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeService {
  Future<List<FeedItem>> getFeed() async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/feeds/?my_challenges=true';

    Uri uri = Uri.parse(url);

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': "Token ${user.token}"
    };

    List<FeedItem> feed = [];
    try {
      Response response = await client.get(uri, headers: headers);

      Map<String, dynamic> responseDecoded = jsonDecode(response.body);
      if (response.statusCode == 200) {
        for (var result in responseDecoded['results']) {
          feed.add(FeedItem.fromJson(result));
        }
      }
      return feed;
    } catch (e) {
      return feed;
    }
  }
}
