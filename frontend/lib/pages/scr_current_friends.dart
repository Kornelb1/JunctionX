import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_acheivements.dart';
import 'package:frontend/providers/profile_provider.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class CurrentFriendsScreen extends StatefulWidget {
  const CurrentFriendsScreen({super.key});

  @override
  State<CurrentFriendsScreen> createState() => _CurrentFriendsState();
}

class _CurrentFriendsState extends State<CurrentFriendsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<ProfileState>(
          state: Provider.of<ProfileState>(context),
          onStateReady: (state) {
            state.getFriends();
          },
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Current Friends",
                    style: theme.themeData.textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.friends.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: theme.colors.backgroundColor,
                          child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return ProfileProvider(
                                      child: AchievementScreen(
                                    user: state.friends[index],
                                    me: false,
                                  ));
                                }));
                              },
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.account_circle,
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
                                        Text(
                                            "${state.friends[index].fname} ${state.friends[index].lname}"),
                                      ],
                                    )
                                  ],
                                ),
                              )));
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
