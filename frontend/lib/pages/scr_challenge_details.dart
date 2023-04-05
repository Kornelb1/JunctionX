import 'package:flutter/material.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/pages/scr_acheivements.dart';
import 'package:frontend/pages/scr_challenge_description.dart';
import 'package:frontend/pages/scr_challenge_feed.dart';
import 'package:frontend/pages/scr_challenges.dart';
import 'package:frontend/pages/scr_profile.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/challenge_filter.dart';
import 'package:frontend/widgets/filter_widget.dart';
import 'package:provider/provider.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  ChallengeDetailsScreen({super.key, required this.challenge});

  Challenge challenge;

  PageController _goalsController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
          builder: (context, state, child) {
            void navigationCall(int value) {
              setState(() {
                widget.currentPage = value;
                widget._goalsController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }

            return SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(children: [
                      Row(children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: theme.colors.darkgrey,
                            )),
                        Text(
                          widget.challenge.title,
                          style: theme.themeData.textTheme.titleLarge,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () => print("add post"),
                            icon: Icon(
                              Icons.add,
                              color: theme.colors.green,
                              size: 30,
                            ))
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                    ])),
                ChallengeFilter(
                    naviagtionCall: navigationCall, widgetObj: widget),
                Expanded(
                    child: PageView(
                        controller: widget._goalsController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      ChallengeDescScreen(challenge: widget.challenge),
                      ChallengeFeedScreen(challenge: widget.challenge)
                    ]))
              ],
            ));
          }),
    );
  }
}
