import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/liked_button.dart';
import 'package:provider/provider.dart';

class ItemFeed extends StatefulWidget {
  final FeedItem item;

  const ItemFeed({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemFeedState();
}

class ItemFeedState extends State<ItemFeed> {
  // bool isMenuOpen = false;
  //bool verified = false;

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return BaseWidget<SearchState>(
        state: Provider.of<SearchState>(context),
        builder: (context, state, child) {
          return Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0))),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        if (widget.item.media != '')
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(24)),
                            child: AspectRatio(
                                aspectRatio: 1,
                                child: Image.network(
                                  widget.item.media,
                                  fit: BoxFit.cover,
                                )),
                          ), // Picture of product
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              height: 48,
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: (widget.item.profilePic != '')
                                    ? ClipOval(
                                        child: Image.network(
                                        widget.item.profilePic,
                                        fit: BoxFit.cover,
                                      ))
                                    : ClipOval(
                                        child: Container(
                                          color: Color.fromARGB(
                                              255, 230, 223, 223),
                                          child: Center(
                                            child: Icon(
                                              Icons.person,
                                              size: 100,
                                              color: Color.fromARGB(
                                                  255, 244, 239, 239),
                                            ),
                                          ),
                                        ),
                                      ),
                              )),
                          SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.item.title,
                                    style:
                                        theme.themeData.textTheme.titleSmall),
                                Text(
                                  widget.item.name,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  (widget.item.isVerified || state.isVerified)
                                      ? Icon(Icons.check,
                                          color: theme.colors.green, size: 30)
                                      : InkWell(
                                          onTap: () async {
                                            state.verifyImage(
                                                widget.item.media,
                                                widget.item.word,
                                                widget.item.challenge);
                                          },
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: theme.colors.green,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              30.0))),
                                              child: Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 3, 10, 3),
                                                  child: Text(
                                                    "Verify Image",
                                                    style: TextStyle(
                                                        color: theme.colors
                                                            .backgroundColor),
                                                  ))),
                                        ),
                                  SizedBox(
                                    width: 4,
                                  ),
                                  LikeButton(
                                    liked: widget.item.isSaved,
                                    onLike: () => print("liked"),
                                    onUnlike: () => print("unliked"),
                                    likes: widget.item.likes,
                                    id: widget.item.likes,
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ));
        });
  }
}
