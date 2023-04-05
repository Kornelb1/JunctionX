import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/services/profile_service.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class UserPreferences {
  final storage = const FlutterSecureStorage();

  Future<bool> saveUser(
    String token,
    String username,
    String fname,
    String lname,
    String email,
    int id,
    // Uint8List profilePic
  ) async {
    try {
      await storage.write(key: "token", value: token);

      //save user to Hive
      var userBox = await Hive.openBox('user');
      userBox.putAll({
        "username": username,
        "fname": fname,
        "lname": lname,
        "email": email,
        "id": id
        // "profilePic": profilePic
      });

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> getUser() async {
    String token;
    String username;
    String fname;
    String lname;
    String email;
    int id;
    // String profilePic;

    try {
      token = await storage.read(key: "token") ?? '';

      //get user details from Hive
      var userBox = await Hive.openBox('user');
      username = userBox.get("username") ?? '';
      fname = userBox.get("fname") ?? '';
      lname = userBox.get("lname") ?? '';
      email = userBox.get("email") ?? '';
      id = userBox.get('id');
      // profilePic = userBox.get("profilePic") ?? '';
    } catch (e) {
      return User(
          token: '', username: '', fname: '', lname: '', email: '', id: -1
          // profilePicture: ''
          );
    }

    User user = User(
        token: token,
        username: username,
        fname: fname,
        lname: lname,
        email: email,
        id: id
        // profilePicture: profilePic
        );

    return user;
  }

  Future<Uint8List> getProfile() async {
    var userBox = await Hive.openBox('user');
    Uint8List image = userBox.get("profilePic");
    return image;
  }

  void updateProfile(Uint8List image) async {
    var userBox = await Hive.openBox('user');
    userBox.put('profilePic', image);
  }

  void removeUser() async {
    await storage.deleteAll();
  }
}

class ProfileState extends ChangeNotifier {
  User user = User();

  ProfileService service = ProfileService();

  bool loading = false;

  Future<Map<String, dynamic>> login(String username, String password) async {
    loading = false;
    setWaiting();
    print(username);
    print(password);
    Map<String, dynamic> value = await service.login(username, password);
    // await Future.delayed(const Duration(seconds: 1));
    setWaiting();
    return value;
  }

  void setWaiting() {
    if (loading == false) {
      loading = true;
      notifyListeners();
    } else {
      loading = false;
      notifyListeners();
    }
  }

  void getUserDetails() async {
    user = await UserPreferences().getUser();
    notifyListeners();
  }

  XFile? _xImage;

  Future selectOrTakePhoto(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: imageSource);

    if (pickedFile != null) {
      _xImage = pickedFile;
      getNewImage();
    } else {
      print('No photo was selected or taken');
    }
  }

  Future<bool> isUserLoggedIn() async {
    User user = await UserPreferences().getUser();
    return (user.fname != '' &&
        user.token != '' &&
        user.email != '' &&
        user.lname != '' &&
        user.username != '');
  }

  ImageProvider<Object> image = const NetworkImage(
      'https://www.publicdomainpictures.net/pictures/30000/nahled/plain-white-background.jpg');

  void getNewImage() async {
    final path = _xImage!.path;
    final bytes = await File(path).readAsBytes();
    UserPreferences().updateProfile(bytes);
    image = Image.memory(bytes).image;
    notifyListeners();
  }

  void getUserProfile() async {
    Uint8List imageb = await UserPreferences().getProfile();
    image = Image.memory(imageb).image;
  }
}
