import 'package:flutter/material.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class ChallengeScreen extends StatefulWidget {
  const ChallengeScreen({super.key});

  @override
  State<ChallengeScreen> createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<ProfileState>(
          state: Provider.of<ProfileState>(context),
          onStateReady: (state) {
            state.getMyChallenges();
          },
          builder: (context, state, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Challenges",
                    style: theme.themeData.textTheme.titleSmall,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: state.myChallenges.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                          color: theme.colors.backgroundColor,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.workspace_premium,
                                  color: theme.colors.green,
                                  size: 30,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(state.myChallenges[index].title),
                                    Text(
                                      state.myChallenges[index].startDate,
                                      style:
                                          theme.themeData.textTheme.bodySmall,
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
            );
          }),
    );
  }
}
