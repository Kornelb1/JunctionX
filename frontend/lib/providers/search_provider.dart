import 'package:flutter/material.dart';
import 'package:frontend/state/search_state.dart';
import 'package:provider/provider.dart';

class SearchProvider extends StatelessWidget {
  final Widget child;

  SearchProvider({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchState>(
      create: (_) => SearchState(),
      child: child,
    );
  }
}
