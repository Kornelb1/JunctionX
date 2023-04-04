import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_nav.dart';
import 'package:frontend/state/profile_state.dart';
import 'package:frontend/widgets/base_widget.dart';
import 'package:provider/provider.dart';

import '../theme/theme_manager.dart';
import '../widgets/wavy_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final ThemeManager theme =
        Provider.of<ThemeManager>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.white,
      body: BaseWidget<ProfileState>(
        state: Provider.of<ProfileState>(context),
        builder: (context, state, child) {
          return Stack(children: [
            Container(
              color: theme.colors.green,
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
            ),
            SafeArea(
                child: Column(children: [
              WavyHeader(),
              Spacer(),
              Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                  child: TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined,
                          color: theme.colors.darkgrey),
                      filled: true,
                      fillColor: theme.colors.lightgrey,
                      border: const UnderlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 18),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon:
                        Icon(Icons.lock_outline, color: theme.colors.darkgrey),
                    filled: true,
                    fillColor: theme.colors.lightgrey,
                    border: const UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: ClipRRect(
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
                        child: Text("Log in"),
                        style: TextButton.styleFrom(
                          minimumSize:
                              Size(MediaQuery.of(context).size.width, 12),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.all(12.0),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        onPressed: () async {
                          Map<String, dynamic> loginResponse =
                              await state.login(_usernameController.value.text,
                                  _passwordController.value.text);
                          state.loading = false;
                          if (loginResponse['status']) {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return NavigationScreen();
                                },
                              ),
                              (_) => false,
                            );
                          } else {
                            SnackBar snackBar = SnackBar(
                                content: Text(loginResponse['message']));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        })
                  ])))
            ]))
          ]);
        },
      ),
    );
  }
}
