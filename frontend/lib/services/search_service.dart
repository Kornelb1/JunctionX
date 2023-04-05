import 'package:frontend/models/challenge.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/profile_state.dart';
import 'dart:convert';
import 'package:http/http.dart';

class SearchService {
  Future<List<Challenge>> getArticles(String query) async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/challenges/?search=$query';

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

  Future<List<Challenge>> getExplore() async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/challenges/?popular=true';

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

  Future<List<FeedItem>> getChallengeFeed(int id) async {
    Client client = Client();
    User user = await UserPreferences().getUser();

    String url = '';

    url = 'http://10.173.45.133:8000/api/v1/feeds/?challenge=$id';

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
