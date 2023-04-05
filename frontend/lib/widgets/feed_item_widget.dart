import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/models/feedItem.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/liked_button.dart';
import 'package:provider/provider.dart';

class ItemFeed extends StatefulWidget {
  final FeedItem item;

  const ItemFeed({Key? key, required this.item}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ItemFeedState();
}

class ItemFeedState extends State<ItemFeed> {
  bool isMenuOpen = false;

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

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
                          child: (widget.item.profilePic != null)
                              ? ClipOval(
                                  child: Image.network(
                                  widget.item.profilePic,
                                  fit: BoxFit.cover,
                                ))
                              : ClipOval(
                                  child: Container(
                                    color: Color.fromARGB(255, 230, 223, 223),
                                    child: Center(
                                      child: Icon(
                                        Icons.person,
                                        size: 100,
                                        color:
                                            Color.fromARGB(255, 244, 239, 239),
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
                              style: theme.themeData.textTheme.titleSmall),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            LikeButton(
                              liked: widget.item.isSaved,
                              onLike: () => print("liked"),
                              onUnlike: () => print("unliked"),
                              likes: widget.item.likes,
                              id: widget.item.likes,
                              // giveawayState: GiveawayState(),
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
  }
}
