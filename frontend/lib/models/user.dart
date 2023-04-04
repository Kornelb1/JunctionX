import 'dart:core';

class User {
  final String token;
  final String username;
  final String fname;
  final String lname;
  final String email;
  final String profilePicture;

  User(
      {this.token = '',
      this.username = '',
      this.fname = '',
      this.lname = '',
      this.email = '',
      this.profilePicture = ''});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        // token: responseData['token'],
        username: responseData['username'],
        fname: responseData['first_name'],
        lname: responseData['last_name'],
        email: responseData['email']);
  }

  @override
  String toString() {
    return 'User token: $token, username: $username, name: $fname';
  }
}
