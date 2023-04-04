import 'package:flutter/material.dart';
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

    return Scaffold(
      body: BaseWidget<SearchState>(
          state: Provider.of<SearchState>(context),
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
                    decoration: InputDecoration(
                      hintText: 'Search',
                      prefixIcon:
                          Icon(Icons.search, color: theme.colors.darkgrey),
                      suffixIcon: Icon(Icons.arrow_forward_ios,
                          color: theme.colors.darkgrey),
                      filled: true,
                      fillColor: theme.colors.lightgrey,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  ),
                ),
                (searching) ? searchingResults(theme) : getSearchPage(theme)
              ],
            ));
          }),
    );
  }

  Widget searchingResults(ThemeManager theme) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
            height: MediaQuery.of(context).size.height - 205,
            child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(100, (index) {
                  return whiteCard(theme);
                }))));
  }

  Widget getSearchPage(ThemeManager theme) {
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
                itemCount: 12,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return greenCard(theme);
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
                    children: List.generate(100, (index) {
                      return whiteCard(theme);
                    })))
          ],
        )));
  }

  Widget greenCard(ThemeManager theme) {
    return Card(
      color: theme.colors.green,
      child: InkWell(
          onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SearchProvider(child: ChallengeDetailsScreen());
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
                      "Title",
                      style: theme.themeData.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text("12 participants")
                  ],
                )),
          )),
    );
  }

  Widget whiteCard(ThemeManager theme) {
    return Card(
        color: theme.colors.backgroundColor,
        child: InkWell(
            onTap: () => print("go to details page"),
            child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Title",
                      style: theme.themeData.textTheme.titleSmall,
                    ),
                    const Spacer(),
                    Text("12 participants")
                  ],
                ))));
  }
}
