import 'package:flutter/material.dart';

import '../theme/theme_manager.dart';
import 'package:provider/provider.dart';

class StatsTopFilter extends StatefulWidget {
  Function(int) naviagtionCall;

  StatsTopFilter(
      {super.key, required this.naviagtionCall, required this.widgetObj});

  final widgetObj;
  bool filter1 = true;
  bool filter2 = false;

  @override
  State<StatsTopFilter> createState() => _StatsTopFilter();
}

class _StatsTopFilter extends State<StatsTopFilter> {
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
                width: 150,
                child: GestureDetector(
                  onTap: () {
                    widget.naviagtionCall(0);
                  },
                  child: Container(
                    width: 150,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Challenges",
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
                width: 150,
                child: GestureDetector(
                  onTap: () => {widget.naviagtionCall(1)},
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 2, 5, 4),
                      child: Text(
                        "Statistics",
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
              )
            ])));
  }
}
