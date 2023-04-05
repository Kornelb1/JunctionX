import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/stats_widget.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/percent_indicator.dart';

class AchievementScreen extends StatefulWidget {
  AchievementScreen({super.key, required this.user, required this.me});

  User user;
  bool me;

  PageController _goalsController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
        body: SafeArea(
      child: BaseWidget<ProfileState>(
        state: Provider.of<ProfileState>(context),
        onStateReady: (state) {
          if (widget.me) {
            state.getMyStats();
          } else {
            state.getFriendsStats(widget.user.id);
          }
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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StatsBottomFilter(
                  naviagtionCall: navigationCall, widgetObj: widget),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: PageView(
                      controller: widget._goalsController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                    CO2(
                        theme,
                        (widget.me)
                            ? state.myStats.co2
                            : state.friend_stats.co2),
                    water(
                        theme,
                        (widget.me)
                            ? state.myStats.water
                            : state.friend_stats.water),
                    energy(
                        theme,
                        (widget.me)
                            ? state.myStats.energy
                            : state.friend_stats.energy),
                    plastic(
                        theme,
                        (widget.me)
                            ? state.myStats.plastic
                            : state.friend_stats.plastic),
                    trees(
                        theme,
                        (widget.me)
                            ? state.myStats.trees
                            : state.friend_stats.trees),
                  ]))
            ],
          );
        },
      ),
    ));
  }

  Widget CO2(ThemeManager theme, double data) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "$data Kg CO2-e",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: data / 30,
        center: Center(
            child: Icon(
          Icons.co2_outlined,
          color: theme.colors.green,
          size: 100,
        )),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget water(ThemeManager theme, double data) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "$data Litres",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: data / 30,
        center: Center(
          child: Icon(
            Icons.water_drop,
            color: theme.colors.green,
            size: 100,
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget energy(ThemeManager theme, double data) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "$data Watts",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: data / 30,
        center: Center(
            child: Icon(
          Icons.electric_bolt,
          color: theme.colors.green,
          size: 100,
        )),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget trees(ThemeManager theme, double data) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "$data Trees",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: data / 30,
        center: Center(
            child: Icon(
          Icons.forest,
          size: 100,
          color: theme.colors.green,
        )),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget plastic(ThemeManager theme, double data) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "$data Bottles",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: data / 30,
        center: Center(
          child: Icon(
            Icons.local_cafe,
            color: theme.colors.green,
            size: 100,
          ),
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }
}
