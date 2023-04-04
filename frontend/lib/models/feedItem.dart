import 'dart:core';

import 'package:frontend/models/user.dart';

class FeedItem {
  final String media;
  final int likes;
  final String caption;
  final String title;
  final int id;
  final bool isSaved;
  final User user; //change to user object

  FeedItem(
      {this.media = '',
      this.likes = 0,
      this.caption = '',
      required this.user,
      this.title = '',
      this.id = -1,
      this.isSaved = false});

  factory FeedItem.fromJson(Map<String, dynamic> responseData) {
    return FeedItem(
      media: responseData['media'],
      likes: responseData['likes'],
      caption: responseData['caption'],
      user: User(),
    );
  }
}
