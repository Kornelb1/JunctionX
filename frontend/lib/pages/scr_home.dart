import 'package:flutter/material.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/providers/home_provider.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/feed_item_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<HomeState>(
          state: Provider.of<HomeState>(context),
          onStateReady: (state) => {state.getFeed()},
          builder: (context, state, child) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Home",
                                  style: theme.themeData.textTheme.titleLarge,
                                ),
                              ]),
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
