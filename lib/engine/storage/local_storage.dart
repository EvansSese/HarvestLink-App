import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String? userParam;
  bool _isLoggedIn = false;

  Future<String?> getUserParam(String param) async {
    final SharedPreferences prefs = await _prefs;
    userParam = prefs.getString(param);
    return userParam;
  }

  Future<void> setUserParam(String key, String value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(key, value);
  }

  Future<void> setIsLoggedIn(bool value) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setBool('isLoggedIn', value);
  }

  Future<bool> getIsLoggedIn() async {
    final SharedPreferences prefs = await _prefs;
    _isLoggedIn = prefs.getBool('isLoggedIn')!;
    return _isLoggedIn;
  }

  Future<void> removeUserParam(List<String> userParams) async {
    final SharedPreferences prefs = await _prefs;
    userParams.forEach((element) async {
      await prefs.remove(element);
    });
  }
}