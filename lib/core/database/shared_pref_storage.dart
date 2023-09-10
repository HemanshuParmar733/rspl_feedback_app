import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefStorage {
  SharedPrefStorage._();

  static final SharedPrefStorage instance = SharedPrefStorage._();
  late final SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  bool? getBoolData({required String key}) {
    return _preferences.getBool(key);
  }

  Future<bool> setBoolData({required String key, required bool data}) async {
    return await _preferences.setBool(key, data);
  }

  Future<bool> deleteData({required String key}) async {
    return await _preferences.remove(key);
  }
}
