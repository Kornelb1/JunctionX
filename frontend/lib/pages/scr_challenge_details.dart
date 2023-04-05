import 'package:flutter/material.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/pages/scr_acheivements.dart';
import 'package:frontend/pages/scr_challenge_description.dart';
import 'package:frontend/pages/scr_challenge_feed.dart';
import 'package:frontend/pages/scr_challenges.dart';
import 'package:frontend/pages/scr_profile.dart';
import 'package:frontend/providers/search_provider.dart';
import 'package:frontend/state/home_state.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:frontend/widgets/challenge_filter.dart';
import 'package:frontend/widgets/filter_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ChallengeDetailsScreen extends StatefulWidget {
  ChallengeDetailsScreen({super.key, required this.challenge});

  Challenge challenge;

  PageController _goalsController = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  State<ChallengeDetailsScreen> createState() => _ChallengeDetailsScreenState();
}

class _ChallengeDetailsScreenState extends State<ChallengeDetailsScreen> {
  TextEditingController _titleController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
          builder: (context, state, child) {
            void navigationCall(int value) {
              setState(() {
                widget.currentPage = value;
                widget._goalsController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              });
            }

            return SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Column(children: [
                      Row(children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: theme.colors.darkgrey,
                            )),
                        Text(
                          widget.challenge.title,
                          style: theme.themeData.textTheme.titleLarge,
                        ),
                        Spacer(),
                        IconButton(
                            onPressed: () => {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SearchProvider(
                                        child: uploadForm(theme, state));
                                  }))
                                },
                            icon: Icon(
                              Icons.add,
                              color: theme.colors.green,
                              size: 30,
                            ))
                      ]),
                      const SizedBox(
                        height: 5,
                      ),
                    ])),
                ChallengeFilter(
                    naviagtionCall: navigationCall, widgetObj: widget),
                Expanded(
                    child: PageView(
                        controller: widget._goalsController,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                      ChallengeDescScreen(challenge: widget.challenge),
                      ChallengeFeedScreen(challenge: widget.challenge)
                    ]))
              ],
            ));
          }),
    );
  }

  Widget uploadForm(ThemeManager theme, SearchState state) {
    return Scaffold(
        body: BaseWidget<SearchState>(
            state: Provider.of<SearchState>(context),
            onStateReady: (state) {},
            builder: (context, state, child) {
              return SafeArea(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: Icon(
                                    Icons.arrow_back_ios,
                                    color: theme.colors.darkgrey,
                                  )),
                              Text(
                                "New Post",
                                style: theme.themeData.textTheme.titleLarge,
                              ),
                            ]),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Title",
                              style: theme.themeData.textTheme.titleSmall,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                              child: TextFormField(
                                controller: _titleController,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                  filled: true,
                                  fillColor: theme.colors.lightgrey,
                                  border: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0))),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Choose Photo",
                              style: theme.themeData.textTheme.titleSmall,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                                child: Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: state.image)),
                                ),
                                Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        height:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                9,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color:
                                                theme.themeData.highlightColor),
                                        child: IconButton(
                                          icon: const Icon(Icons.camera_alt),
                                          color: Colors.white,
                                          onPressed: () {
                                            imageSelection(theme, state);
                                          },
                                        ))),
                              ],
                            )),
                            SizedBox(
                              height: 30,
                            ),
                            Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                child: ClipRRect(
                                    //borderRadius: BorderRadius.circular(12),
                                    child: Stack(children: <Widget>[
                                  Positioned.fill(
                                      child: Container(
                                          decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: theme.colors.green,
                                    border: Border.all(
                                        width: 1, color: theme.colors.green),
                                  ))),
                                  TextButton(
                                    onPressed: () async {
                                      Map<String, dynamic> loginResponse =
                                          await state.uploadPost(
                                              widget.challenge.id,
                                              _titleController.value.text);
                                      state.loading = false;
                                      if (loginResponse['status']) {
                                        Navigator.pop(context);
                                      } else {
                                        SnackBar snackBar = SnackBar(
                                            content:
                                                Text(loginResponse['message']));
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                      }
                                    },
                                    child: Text("Upload"),
                                    style: TextButton.styleFrom(
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.width,
                                          12),
                                      foregroundColor: Colors.white,
                                      padding: const EdgeInsets.all(12.0),
                                      textStyle: const TextStyle(fontSize: 16),
                                    ),
                                  )
                                ])))
                          ])));
            }));
  }

  Future imageSelection(ThemeManager theme, SearchState state) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("Choose photo",
                style: theme.themeData.textTheme.titleSmall),
            children: <Widget>[
              SimpleDialogOption(
                child: Text("From Camera",
                    style: theme.themeData.textTheme.labelSmall),
                onPressed: () {
                  state.selectOrTakePhoto(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
              SimpleDialogOption(
                child: Text("From Gallery",
                    style: theme.themeData.textTheme.labelSmall),
                onPressed: () {
                  state.selectOrTakePhoto(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }
}
