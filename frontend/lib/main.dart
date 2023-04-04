import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_nav.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ThemeManager(),
        builder: (context, _) {
          return Consumer<ThemeManager>(
              builder: (context, themeManager, child) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Kyne',
                theme: themeManager.themeData,
                home: NavigationScreen());
          });
        });
  }
}
