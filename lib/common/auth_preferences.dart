import 'package:shared_preferences/shared_preferences.dart';

class AuthPreferences {
  static Future<void>  setTeacher(bool value) async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.setBool("key", value);
  }

  static Future<bool?> getTeacher() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool('key');
  }

  static Future<void> clear() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.remove('key');
  }
}
