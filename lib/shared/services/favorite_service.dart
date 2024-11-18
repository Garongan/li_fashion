import 'package:shared_preferences/shared_preferences.dart';

class FavoriteService {
  Future<void> saveLoved(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFavourite_$key', value);
  }

  Future<bool> getLoved(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isFavourite_$key') ?? false;
  }

  Future<void> deleteLoved(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isFavourite_$key');
  }
}