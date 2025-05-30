import 'dart:convert';
import 'package:get/get.dart';
import 'package:post_app/controller/c_user.dart';
import 'package:post_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionsUser {
  static Future<void> saveUser(UserDetails user) async {
    final cUser = Get.put(CUser());
    cUser.setData(user);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> userMap = user.toJson();
    prefs.setString('user', jsonEncode(userMap));
  }

  static Future<UserDetails?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    UserDetails? user;
    String? userString = prefs.getString('user');
    if (userString != null) {
      Map<String, dynamic> userMap = jsonDecode(userString);
      user = UserDetails.fromJson(userMap);
      final cUser = Get.put(CUser());
      cUser.setData(user);
    }
    return user;
  }

  static Future<void> clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  static const String _isOnDutyKey = 'isOnDuty';

  /// Simpan nilai isOnDuty (true/false)
  static Future<void> setIsOnDuty(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isOnDutyKey, value);
    print("✅ Saved isOnDuty = $value");
  }

  /// Ambil nilai isOnDuty (default: false)
  static Future<bool> getIsOnDuty() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getBool(_isOnDutyKey) ?? false;
    print("📦 Loaded isOnDuty = $value");
    return value;
  }
}
