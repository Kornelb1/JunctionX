import 'package:flutter/material.dart';
import 'package:frontend/pages/scr_login.dart';
import 'package:frontend/pages/scr_nav.dart';
import 'package:frontend/pages/scr_splash.dart';
import 'package:frontend/providers/profile_provider.dart';
import 'package:frontend/theme/theme_manager.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
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
                title: 'JunctionX',
                theme: themeManager.themeData,
                home: ProfileProvider(child: SplashScreen()));
          });
        });
  }
}
