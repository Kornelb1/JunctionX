import 'package:flutter/material.dart';
import 'package:frontend/models/notification.dart';
import 'package:frontend/services/notification_service.dart';

class NotificationState extends ChangeNotifier {
  NotificationService service = NotificationService();
  bool gotNots = false;
  bool gettingNots = false;
  List<Notifications> nots = [];

  void getNotifications() async {
    gettingNots = true;
    notifyListeners();

    nots = await service.getNotifications();

    gettingNots = false;
    gotNots = true;
    notifyListeners();
  }

  bool friendRequestAccepted = false;

  void acceptRequest(var id) async {
    friendRequestAccepted = await service.acceptRequest(id);
    notifyListeners();
  }
}
