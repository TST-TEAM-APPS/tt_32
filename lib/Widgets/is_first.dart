import 'package:shared_preferences/shared_preferences.dart';

class IsFirstRun {
  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    bool? isFirstRun = prefs.getBool('isFirstRun');

    if (isFirstRun == null || isFirstRun) {
      await prefs.setBool('isFirstRun', false);
      return true;
    }
    return false;
  }
}