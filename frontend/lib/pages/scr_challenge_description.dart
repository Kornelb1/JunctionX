import 'package:flutter/material.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/feed_item_widget.dart';
import 'package:provider/provider.dart';

class ChallengeDescScreen extends StatefulWidget {
  const ChallengeDescScreen({super.key});

  @override
  State<ChallengeDescScreen> createState() => _ChallengeDescScreenState();
}

class _ChallengeDescScreenState extends State<ChallengeDescScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
          builder: (context, state, child) {
            return SafeArea(
                // child: Padding(
                // padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 30),
                  Container(
                      child: Center(child: Text("Short Description")),
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: theme.colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      )),
                  SizedBox(height: 30),
                  Container(
                      child: Center(child: Text("Reward")),
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: theme.colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      )),
                  SizedBox(height: 30),
                  Container(
                      child: Center(child: Text("Proof")),
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: theme.colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      )),
                  SizedBox(height: 30),
                  Container(
                      child: Center(child: Text("Description")),
                      height: MediaQuery.of(context).size.width / 3,
                      width: MediaQuery.of(context).size.width - 50,
                      decoration: BoxDecoration(
                        color: theme.colors.green,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomRight: Radius.circular(30)),
                      ))
                ],
              ),
            ));
          }),
    );
  }
}
