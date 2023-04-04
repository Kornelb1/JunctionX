import 'package:flutter/material.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/stats_widget.dart';
import 'package:provider/provider.dart';

import 'package:percent_indicator/percent_indicator.dart';

class AchievementScreen extends StatefulWidget {
  AchievementScreen({super.key});

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
      body: BaseWidget<ProfileState>(
        state: Provider.of<ProfileState>(context),
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
                    CO2(theme),
                    water(theme),
                    energy(theme),
                    plastic(theme),
                    trees(theme)
                  ]))
            ],
          );
        },
      ),
    );
  }

  Widget CO2(ThemeManager theme) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "20 CO2-e",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: 0.5,
        center: Text(
          "CO2-e",
          style: theme.themeData.textTheme.bodyMedium,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget water(ThemeManager theme) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "20 Litres",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: 0.2,
        center: Text(
          "Litres",
          style: theme.themeData.textTheme.bodyMedium,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget energy(ThemeManager theme) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "200 Watts",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: 0.8,
        center: Text(
          "Watts",
          style: theme.themeData.textTheme.bodyMedium,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget trees(ThemeManager theme) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "20 Trees",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: 0.7,
        center: Text(
          "Trees",
          style: theme.themeData.textTheme.bodyMedium,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }

  Widget plastic(ThemeManager theme) {
    return Center(
        child: Container(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "So far this month you have saved:",
        style: theme.themeData.textTheme.titleSmall,
      ),
      Text(
        "200 Bottles",
      ),
      SizedBox(
        height: 20,
      ),
      CircularPercentIndicator(
        radius: 120.0,
        lineWidth: 20.0,
        animation: true,
        percent: 0.1,
        center: Text(
          "Bottles",
          style: theme.themeData.textTheme.bodyMedium,
        ),
        circularStrokeCap: CircularStrokeCap.round,
        progressColor: theme.colors.green,
      ),
    ])));
  }
}
