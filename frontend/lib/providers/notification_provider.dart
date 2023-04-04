import 'package:flutter/material.dart';
import 'package:frontend/state/notification_state.dart';
import 'package:provider/provider.dart';

class NotificationProvider extends StatelessWidget {
  final Widget child;

  NotificationProvider({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationState>(
      create: (_) => NotificationState(),
      child: child,
    );
  }
}
