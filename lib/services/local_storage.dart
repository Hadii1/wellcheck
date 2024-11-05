import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wellcheck/models/gamble_event.dart';
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

  Future<void> saveGambleEvent(GambleEvent event) async {
    final existingEvents = await getGambleEvents();
    existingEvents.add(event);

    await _prefs!.setString('gamble_events',
        json.encode(existingEvents.map((e) => e.toJson()).toList()));
  }

  Future<List<GambleEvent>> getGambleEvents() async {
    final String? eventsString = _prefs!.getString('gamble_events');
    if (eventsString == null) {
      return [];
    }

    final List<dynamic> jsonList = json.decode(eventsString);
    return jsonList.map((json) => GambleEvent.fromJson(json)).toList();
  }
}
