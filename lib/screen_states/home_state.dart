import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/models/gamble_event.dart';
import 'package:wellcheck/providers/local_notification_provider.dart';
import 'package:wellcheck/services/local_storage.dart';
import 'package:wellcheck/shared/model/local_notification.dart';

final homeScreenState = ChangeNotifierProvider.autoDispose(
  (ref) => HomeNotifier(
    LocalStorage(),
    ref.read(localNotificationsProvider.notifier),
  ),
);

class HomeNotifier extends ChangeNotifier {
  HomeNotifier(this._localStorage, this._notificationsNotifier);

  final LocalStorage _localStorage;
  final LocalNotificationsNotifier _notificationsNotifier;

  bool _didGamleToday = false;
  String _notes = '';

  bool get didGamleToday => _didGamleToday;
  String get notes => _notes;

  set didGamleToday(bool value) {
    _didGamleToday = value;
    notifyListeners();
  }

  set notes(String notes) {
    _notes = notes;
    notifyListeners();
  }

  Future<void> submit() async {
    await _localStorage.saveGambleEvent(
      GambleEvent(time: DateTime.now(), notes: notes),
    );
    _notes = '';
    _didGamleToday = false;
    notifyListeners();
    _notificationsNotifier.showMessage(
      LocalNotification(message: 'Event Saved!', useErrorColor: false),
    );
  }
}
