import 'dart:core';

class Challenge {
  final int id;
  final String title;
  final String shortDesc;
  final String startDate;
  final String endDate;
  final int sponsor;
  final int owner;
  final String photo;
  final int participants;
  final String proof;
  final String longDesc;
  final String reward;

  Challenge(
      {this.id = -1,
      this.title = '',
      this.shortDesc = '',
      this.longDesc = '',
      this.proof = '',
      this.reward = '',
      this.startDate = '',
      this.endDate = '',
      this.sponsor = -1,
      this.owner = -1,
      this.photo = '',
      this.participants = -1});

  factory Challenge.fromJson(Map<String, dynamic> responseData) {
    return Challenge(
        id: responseData['id'],
        title: responseData['title'],
        shortDesc: responseData['short_description'],
        longDesc: responseData['long_description'],
        startDate: responseData['start_date'],
        endDate: responseData['end_date'],
        reward: responseData['reward'],
        proof: responseData['proof'],
        sponsor: responseData['sponsor'],
        owner: responseData['owner'],
        photo: responseData['photo'],
        participants: responseData['participants']);
  }

  @override
  String toString() {
    return 'Challenge: $title';
  }
}
