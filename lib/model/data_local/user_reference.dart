import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static const String KEY_USER_ID = 'user_id';
  static const String KEY_ACCESS_TOKEN = 'access_token';
  static const String KEY_USER = 'user';

  // Lấy User ID từ SharedPreferences
  static Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_USER_ID);
  }

  // Lấy Access Token từ SharedPreferences
  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(KEY_ACCESS_TOKEN);
  }

  // Lấy thông tin người dùng từ SharedPreferences
  static Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString(KEY_USER);
    if (userJson != null) {
      return json.decode(userJson);
    }
    return null;
  }

  // Lưu User ID vào SharedPreferences
  static Future<void> setUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_USER_ID, userId);
  }

  // Lưu Access Token vào SharedPreferences
  static Future<void> setAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(KEY_ACCESS_TOKEN, accessToken);
  }

  // Lưu thông tin người dùng vào SharedPreferences
  static Future<void> setUser(Map<String, dynamic> user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userJson = json.encode(user); // Chuyển đổi đối tượng user thành JSON
    await prefs.setString(KEY_USER, userJson);
  }

  // Xóa thông tin đăng nhập khi người dùng đăng xuất
  static Future<void> clearUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(KEY_USER_ID);
    await prefs.remove(KEY_ACCESS_TOKEN);
    await prefs.remove(KEY_USER); // Xóa thông tin người dùng
  }
}
