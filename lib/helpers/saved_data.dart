import 'package:shared_preferences/shared_preferences.dart';
import 'package:sport_lottery/core/constants/app_text_constants.dart';

class SavedData {
  static Future<void> setName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.name, name);
  }

  static Future<String> getName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedKeys.name) ?? '';
  }

  static Future<void> setEmail(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.authEmail, email);
  }

  static Future<String> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedKeys.authEmail) ?? '';
  }

  static Future<void> setImage(String image) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.image, image);
  }

  static Future<String> getImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedKeys.image) ?? '';
  }

  static Future<void> setUid(String uid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(SharedKeys.uid, uid);
  }

  static Future<String> getUid() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(SharedKeys.uid) ?? '';
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
