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
      backgroundColor: const Color(0xffFFF2D7),
      blue_button: const Color(0xff5098EE),
      purple_text: const Color(0xff925FBA),
      black_border: const Color(0xff000000),
      white_text: const Color(0xffFFFFFF),
      draw_colour: const Color(0xff1266C8),
      whiteBoard_boarder: const Color(0xffFFCC4A),
      text_field_border: const Color(0xffFFD260),
      text_field_background: const Color(0xffFFECC5),
      check_box_background: const Color(0xffFFECC5),
      check_box_border: const Color(0xffFFD260),
      id_box_background: const Color(0xffB1D0F4),
      id_box_border: const Color(0xff4F98EE),
    );
  }
}
