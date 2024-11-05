import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/providers/local_notification_provider.dart';
import 'package:wellcheck/providers/user_provider.dart';

final loginScreenState = ChangeNotifierProvider.autoDispose(
  (ref) => LoginNotifier(
    userNotifier: ref.read(userProvider.notifier),
    notificationsNotifier: ref.read(localNotificationsProvider.notifier),
  ),
);

class LoginNotifier extends ChangeNotifier {
  LoginNotifier({
    required this.userNotifier,
    required this.notificationsNotifier,
  });

  final UserNotifier userNotifier;
  final LocalNotificationsNotifier notificationsNotifier;

  String _email = '';
  String _password = '';

  String get email => _email;
  String get password => _password;

  set password(String pass) {
    _password = pass;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  // Returns true if successful
  Future<bool> login() async {
    try {
      await userNotifier.login(
        email: email,
        password: password,
      );
      return true;
    } on Exception catch (e, s) {
      notificationsNotifier.showErrorMessage(e, s: s);
      return false;
    }
  }

  // Returns true if successful
  Future<bool> register() async {
    try {
      await userNotifier.register(
        email: email,
        password: password,
      );
      return true;
    } on Exception catch (e, s) {
      notificationsNotifier.showErrorMessage(e, s: s);
      return false;
    }
  }
}
