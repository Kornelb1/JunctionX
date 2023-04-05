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
          onStateReady: (state) => {state.getNotifications()},
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
                            itemCount: state.nots.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  color: theme.colors.backgroundColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child:
                                        // Row(
                                        //   mainAxisAlignment:
                                        //       MainAxisAlignment.start,
                                        //   children: [
                                        //     Icon(
                                        //       Icons.notifications,
                                        //       color: theme.colors.green,
                                        //       size: 30,
                                        //     ),
                                        //     SizedBox(
                                        //       width: 5,
                                        //     ),
                                        Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 50,
                                          child: Text(
                                            state.nots[index].title,
                                          ),
                                        ),
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                state.nots[index].date,
                                                style: theme.themeData.textTheme
                                                    .bodySmall,
                                              ),
                                              Icon(
                                                Icons.notifications,
                                                color: theme.colors.green,
                                                size: 30,
                                              ),
                                            ])
                                      ],
                                      // )
                                      // ],
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
