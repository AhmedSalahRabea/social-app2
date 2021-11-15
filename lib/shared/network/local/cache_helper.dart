import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences sharedPreferences;

  static Future<SharedPreferences> init() async {
    return sharedPreferences = await SharedPreferences.getInstance();
  }

  // static Future<bool> putBooleanDataInSharedPrefrences({
  //   required String key,
  //   required bool value,
  // }) async {
  //   return await sharedPreferences.setBool(key, value);
  // }

  // static bool? getBooleanDataFromSharedPrefrences({
  //   required String key,
  // }) {
  //   return sharedPreferences.getBool(key);
  // }

  static dynamic getDataFromSharedPrefrences({
    required String key,
  }) {
    return sharedPreferences.get(key);
  }

  static Future<bool> saveDataInSharedPrefrences({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

 static Future<bool> removeDataFromSharedPrefrence({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
