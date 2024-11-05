import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellcheck/models/user.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  LocalStorage._internal();

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static SharedPreferences? _prefs;

  Future<void> deleteUser() async {
    await _prefs!.remove('user_v1');
  }

  Future<void> saveUser(User user) async {
    await _prefs!.setString('user_v1', user.toJson());
  }
}
