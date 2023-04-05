import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/services/home_service.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class HomeState extends ChangeNotifier {
  HomeService service = HomeService();

  bool gotFeed = false;
  bool gettingFeed = false;
  List<FeedItem> feed = [];

  void getFeed() async {
    gettingFeed = true;
    notifyListeners();

    feed = await service.getFeed();

    gettingFeed = false;
    gotFeed = true;
    notifyListeners();
  }
}
