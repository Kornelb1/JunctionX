import 'dart:core';

class User {
  final String token;
  final String username;
  final String name;
  final String profilePicture;

  User(
      {this.token = '',
      this.username = '',
      this.name = '',
      this.profilePicture = ''});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
      token: responseData['token'],
      username: responseData['username'],
      name: responseData['name'],
    );
  }

  @override
  String toString() {
    return 'User token: $token, username: $username, name: $name';
  }
}
