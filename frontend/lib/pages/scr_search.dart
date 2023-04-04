import 'package:flutter/material.dart';
import 'package:frontend/models/challenge.dart';
import 'package:frontend/pages/scr_challenge_details.dart';
import 'package:frontend/providers/search_provider.dart';
import 'package:frontend/state/search_state.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool searching = false;

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);

    TextEditingController _controller = TextEditingController();

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
          onStateReady: (state) {
            state.gettingSearchedChallenges = false;
            state.gotSearchedChallenges = false;
            state.getMyChallenges();
            state.getExploreChallenges();
          },
          builder: (context, state, child) {
            return SafeArea(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                  child: TextFormField(
                    onTap: () {
                      setState(() {
                        searching = true;
                      });
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon: IconButton(
                          onPressed: () => setState(() {
                                searching = false;
                              }),
                          icon: (!searching)
                              ? Icon(Icons.search, color: theme.colors.darkgrey)
                              : Icon(Icons.cancel_outlined,
                                  color: theme.colors.darkgrey)),
                      suffixIcon: IconButton(
                          onPressed: () =>
                              state.getSearchedArticles(_controller.value.text),
                          icon: Icon(Icons.arrow_forward_ios,
                              color: theme.colors.darkgrey)),
                      filled: true,
                      fillColor: theme.colors.lightgrey,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                ),
                (searching)
                    ? searchingResults(theme, state)
                    : getSearchPage(theme, state)
              ],
            ));
          }),
    );
  }

  Widget searchingResults(ThemeManager theme, SearchState state) {
    if (!state.gettingSearchedChallenges && !state.gotSearchedChallenges) {
      //if gotsearch + getting searched == false then just display search bar
      return Container();
    } else if (!state.gotSearchedChallenges &&
        state.gettingSearchedChallenges) {
      //if getting searched == true then display the progress indicator
      return Center(
          child: CircularProgressIndicator(
        color: theme.colors.green,
      ));
    } else {
      if (state.gotSearchedChallenges == true && state.challenges.isNotEmpty) {
        return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
                height: MediaQuery.of(context).size.height - 205,
                child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(state.challenges.length, (index) {
                      return whiteCard(theme, state.challenges[index]);
                    }))));
      } else {
        return Center(child: Text("No results found"));
      }
    }
  }

  Widget getSearchPage(ThemeManager theme, SearchState state) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "My Challenges",
              style: theme.themeData.textTheme.titleLarge,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 4,
              child: ListView.builder(
                itemCount: state.myChallenges.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return greenCard(theme, state.myChallenges[index]);
                },
              ),
            ),
            Text(
              "Explore",
              style: theme.themeData.textTheme.titleLarge,
            ),
            SizedBox(
                height: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height / 4) -
                    277,
                child: GridView.count(
                    crossAxisCount: 2,
                    children:
                        List.generate(state.exploreChallenges.length, (index) {
                      return whiteCardExplore(
                          theme, state.exploreChallenges[index]);
                    })))
          ],
        )));
  }

  Widget greenCard(ThemeManager theme, Challenge c) {
    return Card(
      color: theme.colors.green,
      child: InkWell(
          onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchProvider(
                      child: ChallengeDetailsScreen(
                    challenge: c,
                  ));
                }))
              },
          child: SizedBox(
            width: (MediaQuery.of(context).size.width - 40) / 2,
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.title,
                      style: theme.themeData.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        (c.photo != '')
                            ? Center(
                                child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(24)),
                                    child: SizedBox(
                                      height: 140,
                                      width: 200,
                                      child: AspectRatio(
                                          aspectRatio: 1,
                                          child: Image.network(
                                            c.photo,
                                            fit: BoxFit.cover,
                                          )),
                                    )))
                            : Container(),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Container(
                              decoration: BoxDecoration(
                                color: theme.colors.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 3),
                                child: Text("${c.participants} participants"),
                              )),
                        )
                      ],
                    )
                  ],
                )),
          )),
    );
  }

  Widget whiteCard(ThemeManager theme, Challenge c) {
    return Card(
        color: theme.colors.backgroundColor,
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchProvider(
                    child: ChallengeDetailsScreen(challenge: c));
              }));
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: theme.themeData.textTheme.titleSmall,
                      ),
                      const Spacer(),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          (c.photo != '')
                              ? Center(
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      child: SizedBox(
                                        height: 110,
                                        width: 200,
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                              c.photo,
                                              fit: BoxFit.cover,
                                            )),
                                      )))
                              : Container(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colors.backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: Text("${c.participants} participants"),
                                )),
                          )
                        ],
                      )
                    ]))));
  }

  Widget whiteCardExplore(ThemeManager theme, Challenge c) {
    return Card(
        color: theme.colors.backgroundColor,
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return SearchProvider(
                    child: ChallengeDetailsScreen(challenge: c));
              }));
            },
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.title,
                        style: theme.themeData.textTheme.titleSmall,
                      ),
                      const Spacer(),
                      Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          (c.photo != '')
                              ? Center(
                                  child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(24)),
                                      child: SizedBox(
                                        height: 90,
                                        width: 200,
                                        child: AspectRatio(
                                            aspectRatio: 1,
                                            child: Image.network(
                                              c.photo,
                                              fit: BoxFit.cover,
                                            )),
                                      )))
                              : Container(),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                                decoration: BoxDecoration(
                                  color: theme.colors.backgroundColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  child: Text("${c.participants} participants"),
                                )),
                          )
                        ],
                      )
                    ]))));
  }
}
