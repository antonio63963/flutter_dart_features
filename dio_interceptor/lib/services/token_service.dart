import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String _tokenKey = 'TOKEN';

  static Future<void> setToken(String token) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString(_tokenKey);
  }

  static Future<void> clear(String token) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}
