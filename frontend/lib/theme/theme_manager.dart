import 'package:flutter/material.dart';
import 'theme.dart';
import 'package:frontend/theme/colors.dart';

class ThemeManager extends ChangeNotifier {
  ThemeManager();

  // The ThemeData object which the app uses
  ThemeData? _themeData;
  ThemeData get themeData {
    _themeData ??= appThemeData[AppTheme.LIGHT];
    return _themeData!;
  }

  switchTheme() async {
    if (_themeData == appThemeData[AppTheme.LIGHT]) {
      _themeData = appThemeData[AppTheme.DARK];
    } else {
      _themeData = appThemeData[AppTheme.LIGHT];
    }

    notifyListeners();
  }

  AppColors get colors {
    return AppColors(
      backgroundColor: const Color(0xffFFFFFF),
      green: const Color(0xff69B578),
      darkgrey: const Color(0xff383F51),
      lightgrey: const Color.fromARGB(255, 211, 211, 211),
    );
  }
}
