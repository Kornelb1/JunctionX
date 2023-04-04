import 'package:flutter/material.dart';
import 'package:frontend/state/notification_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<NotificationState>(
          state: Provider.of<NotificationState>(context),
          builder: (context, state, child) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Notifications",
                          style: theme.themeData.textTheme.titleLarge,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: 100,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  color: theme.colors.backgroundColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.notifications,
                                          color: theme.colors.green,
                                          size: 30,
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("Notification $index"),
                                            Text(
                                              "Date",
                                              style: theme.themeData.textTheme
                                                  .bodySmall,
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ));
                            },
                          ),
                        )
                      ],
                    )));
          }),
    );
  }
}
