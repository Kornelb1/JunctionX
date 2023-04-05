import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/pages/scr_acheivements.dart';
import 'package:frontend/pages/scr_challenges.dart';
import 'package:frontend/pages/scr_profile.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/filter_widget.dart';
import 'package:provider/provider.dart';

class StatisticsScreen extends StatefulWidget {
  StatisticsScreen({super.key});

  PageController _goalsController = PageController(initialPage: 0);
  int currentPage = 0;
  User user = User();

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<ProfileState>(
          state: Provider.of<ProfileState>(context),
          onStateReady: (p0) async {
            widget.user = await UserPreferences().getUser();
          },
          builder: (context, state, child) {
            void navigationCall(int value) {
              setState(() {
                widget.currentPage = value;
                // widget._goalsController.jumpToPage(value);
                widget._goalsController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }

            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Statistics",
                          style: theme.themeData.textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        StatsTopFilter(
                            naviagtionCall: navigationCall, widgetObj: widget),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                            child: PageView(
                                controller: widget._goalsController,
                                physics: const NeverScrollableScrollPhysics(),
                                children: [
                              ChallengeScreen(),
                              AchievementScreen(
                                user: widget.user,
                                me: true,
                              )
                            ]))
                      ],
                    )));
          }),
    );
  }
}
