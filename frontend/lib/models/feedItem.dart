import 'dart:core';

import 'package:frontend/models/user.dart';

class FeedItem {
  final String media;
  final int likes;
  final String title;
  final int owner;
  final String name;
  final String profilePic;
  final bool isSaved;

  FeedItem(
      {this.media = '',
      this.likes = 0,
      this.title = '',
      this.name = '',
      this.profilePic = '',
      this.owner = -1,
      this.isSaved = false});

  factory FeedItem.fromJson(Map<String, dynamic> responseData) {
    return FeedItem(
      media: responseData['photo'],
      likes: responseData['likes'],
      title: responseData['title'],
      owner: responseData["owner"],
      name: responseData["name"],
    );
  }
}
