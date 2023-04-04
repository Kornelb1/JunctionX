import 'package:flutter/material.dart';
import 'package:frontend/state/home_state.dart';
import 'package:provider/provider.dart';

class HomeProvider extends StatelessWidget {
  final Widget child;

  HomeProvider({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeState>(
      create: (_) => HomeState(),
      child: child,
    );
  }
}
