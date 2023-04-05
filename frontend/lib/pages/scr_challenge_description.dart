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

class ChallengeDescScreen extends StatefulWidget {
  ChallengeDescScreen({super.key, required this.challenge});

  Challenge challenge;

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
                child: SingleChildScrollView(
                    child: Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Padding(
                          padding: EdgeInsets.all(8),
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            Stack(
                              children: [
                                if (widget.challenge.photo != '')
                                  ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                    child: AspectRatio(
                                        aspectRatio: 1,
                                        child: Image.network(
                                          widget.challenge.photo,
                                          fit: BoxFit.cover,
                                        )),
                                  ), // Picture of product
                              ],
                            )
                          ]))),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Challenge",
                                style: theme.themeData.textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.challenge.shortDesc)
                            ])),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "You Earn",
                                style: theme.themeData.textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.challenge.reward),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: getIcons(widget.challenge, theme),
                              )
                            ])),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Criteria",
                                style: theme.themeData.textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.challenge.proof)
                            ])),
                  ),
                  SizedBox(height: 10),
                  Card(
                    child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "More Information",
                                style: theme.themeData.textTheme.titleSmall,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(widget.challenge.longDesc)
                            ])),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ClipRRect(
                      //borderRadius: BorderRadius.circular(12),
                      child: Stack(children: <Widget>[
                    Positioned.fill(
                        child: Container(
                            decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: theme.colors.green,
                      border: Border.all(width: 1, color: theme.colors.green),
                    ))),
                    TextButton(
                        child: Text("Join Challenge"),
                        style: TextButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 12),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(12.0),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          bool joined =
                              await state.joinChallenge(widget.challenge.id);

                          if (joined) {
                            SnackBar snackBar =
                                SnackBar(content: Text("Joined"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        })
                  ])),
                  SizedBox(
                    height: 50,
                  )
                ],
              ),
            )));
          }),
    );
  }

  List<Widget> getIcons(Challenge c, ThemeManager theme) {
    List<Widget> icons = [];
    if (c.emissions > 0) {
      icons.add(Icon(
        Icons.co2_outlined,
        color: theme.colors.green,
        size: 30,
      ));
    }
    if (c.energy > 0) {
      icons.add(Icon(
        Icons.electric_bolt,
        color: theme.colors.green,
        size: 30,
      ));
    }
    if (c.water > 0) {
      icons.add(Icon(
        Icons.water_drop,
        color: theme.colors.green,
        size: 30,
      ));
    }
    if (c.trees > 0) {
      icons.add(Icon(
        Icons.forest,
        color: theme.colors.green,
        size: 30,
      ));
    }
    if (c.plastic > 0) {
      icons.add(Icon(
        Icons.local_cafe,
        color: theme.colors.green,
        size: 30,
      ));
    }

    return icons;
  }
}
