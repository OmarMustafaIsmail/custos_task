import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheManager {
  static late SharedPreferences sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Locale? get locale {
    final value = sharedPreferences.getString('locale');

    if (value == null) {
      return null;
    }

    return Locale(value);
  }

  static void changeLocale(String locale) {
    sharedPreferences.setString('locale', locale);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);

    return await sharedPreferences.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
