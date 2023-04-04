import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_login.dart';
import 'package:frontend/pages/scr_nav.dart';
import 'package:frontend/providers/profile_provider.dart';
import 'package:frontend/state/profile_state.dart';

import 'package:provider/provider.dart';

import '../widgets/base_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BaseWidget<ProfileState>(
            state: Provider.of<ProfileState>(context),
            onStateReady: (state) async {
              await state.isUserLoggedIn().then((v) async {
                if (!v) {
                  //not logged in
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ProfileProvider(child: LoginScreen())));
                } else {
                  //logged in
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => NavigationScreen()));
                }
              });
            },
            builder: (context, state, child) {
              return Center(child: Container());
            }));
  }
}
