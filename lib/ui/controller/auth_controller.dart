import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_pro/data/models/user_model.dart';

class AuthController {
  static String? token;
  static UserModel? user;

  static Future<void> saveUserInformation(String t, UserModel model) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("token", t);
    await preferences.setString("user", jsonEncode(model.toJson()));
    token = t;
    user = model;
  }

  static Future<void> initializedUserCache() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString("token");
    user = UserModel.fromJson(jsonDecode(preferences.getString("user") ?? " {}"));
  }

  static Future<bool> checkAuthState() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    String? token = preferences.getString("token");

    if (token != null) {
      await initializedUserCache();
      return true;
    }
    return false;
  }

  static Future<void> clearAuthData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    token = null;
  }
}
