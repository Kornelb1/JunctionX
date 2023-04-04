import 'package:flutter/material.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/services/search_service.dart';

class SearchState extends ChangeNotifier {
  SearchService service = SearchService();

  bool gotSearchedChallenges = false;
  bool gettingSearchedChallenges = false;
  List<Challenge> challenges = [];

  void getSearchedArticles(String query) async {
    gettingSearchedChallenges = true;
    notifyListeners();

    challenges = await service.getArticles(query);

    gettingSearchedChallenges = false;
    gotSearchedChallenges = true;
    notifyListeners();
  }

  bool gotSearchedMyChallenges = false;
  bool gettingSearchedMyChallenges = false;
  List<Challenge> myChallenges = [];

  void getMyChallenges() async {
    gettingSearchedMyChallenges = true;
    notifyListeners();

    myChallenges = await service.getMyChallenges();

    gettingSearchedMyChallenges = false;
    gotSearchedMyChallenges = true;
    notifyListeners();
  }

  bool gettingExplore = false;
  bool gotExplore = false;
  List<Challenge> exploreChallenges = [];

  void getExploreChallenges() async {
    gettingExplore = true;
    notifyListeners();

    exploreChallenges = await service.getExplore();
    print(exploreChallenges);

    gettingExplore = false;
    gotExplore = true;
    notifyListeners();
  }

  bool gotFeed = false;
  bool gettingFeed = false;
  List<FeedItem> feed = [];

  void getFeed(int id) async {
    gettingFeed = true;
    notifyListeners();

    feed = await service.getChallengeFeed(id);

    gettingFeed = false;
    gotFeed = true;
    notifyListeners();
  }
}
