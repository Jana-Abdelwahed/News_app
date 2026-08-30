import 'package:shared_preferences/shared_preferences.dart';


class ThemePrefs {
  static String themKey = 'theme';
 static void saveTheme(bool isDark) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(themKey,isDark );
  }
  static Future<bool?> getTheme() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(themKey);
  }
}