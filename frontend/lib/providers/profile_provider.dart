import 'package:flutter/material.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:provider/provider.dart';

class ProfileProvider extends StatelessWidget {
  final Widget child;

  ProfileProvider({Key? key, required this.child});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProfileState>(
      create: (_) => ProfileState(),
      child: child,
    );
  }
}
