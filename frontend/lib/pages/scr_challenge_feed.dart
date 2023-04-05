import 'package:flutter/material.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/feed_item_widget.dart';
import 'package:provider/provider.dart';

class ChallengeFeedScreen extends StatefulWidget {
  ChallengeFeedScreen({super.key, required this.challenge});

  Challenge challenge;

  @override
  State<ChallengeFeedScreen> createState() => _ChallengeFeedScreenState();
}

class _ChallengeFeedScreenState extends State<ChallengeFeedScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
          onStateReady: (state) {
            state.getFeed(widget.challenge.id);
          },
          builder: (context, state, child) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: ListView.builder(
                                  itemCount: state.feed.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemFeed(item: state.feed[index]);
                                  }))
                        ])));
          }),
    );
  }
}
