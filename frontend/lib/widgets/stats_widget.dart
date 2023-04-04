import 'package:flutter/material.dart';

import '../theme/theme_manager.dart';
import 'package:provider/provider.dart';

class StatsBottomFilter extends StatefulWidget {
  Function(int) naviagtionCall;

  StatsBottomFilter(
      {super.key, required this.naviagtionCall, required this.widgetObj});

  final widgetObj;
  bool filter1 = true;
  bool filter2 = false;

  @override
  State<StatsBottomFilter> createState() => _StatsBottomFilter();
}

class _StatsBottomFilter extends State<StatsBottomFilter> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);
    return Container(
        height: 55,
        child: Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5),
            child:
                ListView(scrollDirection: Axis.horizontal, children: <Widget>[
              Container(
                width: 60,
                child: GestureDetector(
                  onTap: () {
                    widget.naviagtionCall(0);
                  },
                  child: Container(
                    width: 60,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "CO2",
                        style: theme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2.0,
                            color: widget.widgetObj.currentPage == 0
                                ? theme.colors.green
                                : theme.colors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                child: GestureDetector(
                  onTap: () => {widget.naviagtionCall(1)},
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Water",
                        style: theme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2.0,
                            color: widget.widgetObj.currentPage == 1
                                ? theme.colors.green
                                : theme.colors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 70,
                child: GestureDetector(
                  onTap: () => {widget.naviagtionCall(2)},
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Energy",
                        style: theme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2.0,
                            color: widget.widgetObj.currentPage == 2
                                ? theme.colors.green
                                : theme.colors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 70,
                child: GestureDetector(
                  onTap: () => {widget.naviagtionCall(3)},
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Plastic",
                        style: theme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2.0,
                            color: widget.widgetObj.currentPage == 3
                                ? theme.colors.green
                                : theme.colors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: 60,
                child: GestureDetector(
                  onTap: () => {widget.naviagtionCall(4)},
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Trees",
                        style: theme.themeData.textTheme.bodyMedium,
                      ),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            width: 2.0,
                            color: widget.widgetObj.currentPage == 4
                                ? theme.colors.green
                                : theme.colors.backgroundColor),
                      ),
                    ),
                  ),
                ),
              )
            ])));
  }
}
