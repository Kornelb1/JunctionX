import 'dart:core';

class Challenge {
  final int id;
  final String title;
  final String description;
  final String startDate;
  final String endDate;
  final int sponsor;
  final int owner;
  final String photo;

  Challenge(
      {this.id = -1,
      this.title = '',
      this.description = '',
      this.startDate = '',
      this.endDate = '',
      this.sponsor = -1,
      this.owner = -1,
      this.photo = ''});

  factory Challenge.fromJson(Map<String, dynamic> responseData) {
    return Challenge(
        id: responseData['id'],
        title: responseData['title'],
        description: responseData['description'],
        startDate: responseData['start_date'],
        endDate: responseData['end_date'],
        sponsor: responseData['sponsor'],
        owner: responseData['owner'],
        photo: responseData['photo']);
  }

  @override
  String toString() {
    return 'Challenge: $title';
  }
}
