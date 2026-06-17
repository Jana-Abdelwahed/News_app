import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../prefs/theme_prefs.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;
  ThemeProvider({required this.themeMode});
  void changeTheme(ThemeMode newThemeMode) {
    if (newThemeMode == themeMode) {
      return;
    }
    themeMode = newThemeMode;
    ThemePrefs.saveTheme(newThemeMode == ThemeMode.dark);
    notifyListeners();
  }
  bool isLight(){
    return themeMode==ThemeMode.light?true:false;
  }
  String returnText(){
    return themeMode==ThemeMode.light?'light'.tr():'dark'.tr();
  }
}