import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class RecommendedFriendsScreen extends StatefulWidget {
  const RecommendedFriendsScreen({super.key});

  @override
  State<RecommendedFriendsScreen> createState() => _RecommendedFriendsState();
}

class _RecommendedFriendsState extends State<RecommendedFriendsScreen> {
  User user = User();
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<ProfileState>(
          state: Provider.of<ProfileState>(context),
          onStateReady: (state) async {
            state.getRecommended();
            user = await UserPreferences().getUser();
          },
          builder: (context, state, child) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      "Recommended Friends",
                      style: theme.themeData.textTheme.titleSmall,
                    ),
                  ),
                  Expanded(
                      child: ListView.builder(
                          itemCount: state.recommended.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              color: theme.colors.backgroundColor,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(children: [
                                    Icon(
                                      Icons.account_circle_outlined,
                                      color: theme.colors.green,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                        "${state.recommended[index].fname} ${state.recommended[index].lname}"),
                                    Spacer(),
                                    IconButton(
                                        onPressed: () =>
                                            state.sendRequest(user),
                                        icon: Icon(Icons.person_add,
                                            color: theme.colors.green,
                                            size: 30))
                                  ])),
                            );
                          }))
                ]);
          }),
    );
  }
}
