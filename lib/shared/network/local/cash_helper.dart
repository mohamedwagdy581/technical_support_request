import 'package:shared_preferences/shared_preferences.dart';

class CashHelper
{
  static SharedPreferences? sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  // Function to get data from sharedPreferences
  static dynamic getData({required String key,})
  {
    return sharedPreferences?.get(key);
  }


  // Function to save data in SharedPreferences
  static Future<bool> saveData({required String key, required dynamic value,}) async
  {
    if(value is String) return await sharedPreferences!.setString(key, value);
    if(value is bool) return await sharedPreferences!.setBool(key, value);
    if(value is int) return await sharedPreferences!.setInt(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }


  // Function to Remove data from SharedPreferences

  static Future<bool> removeData({required String key,}) async
  {
    return await sharedPreferences!.remove(key);
  }
}