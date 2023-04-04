import 'package:flutter/material.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/models/user.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/feed_item_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<HomeState>(
          state: Provider.of<HomeState>(context),
          builder: (context, state, child) {
            return SafeArea(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Home",
                            style: theme.themeData.textTheme.titleLarge,
                          ),
                          Expanded(
                              child: ListView.builder(
                                  itemCount: 100,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ItemFeed(
                                      item: FeedItem(
                                          user: User(
                                              username: "Amy",
                                              profilePicture:
                                                  "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png"),
                                          caption: "Caption",
                                          title: "Title",
                                          likes: 10,
                                          isSaved: false,
                                          media:
                                              "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/800px-Image_created_with_a_mobile_phone.png"),
                                    );
                                  }))
                        ])));
          }),
    );
  }
}