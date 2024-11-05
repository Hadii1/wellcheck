// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/shared/model/local_notification.dart';

final localNotificationsProvider =
    StateNotifierProvider<LocalNotificationsNotifier, LocalNotification?>(
  (ref) => LocalNotificationsNotifier(),
);

// Null state refers to initial state with no notification to show/hide
class LocalNotificationsNotifier extends StateNotifier<LocalNotification?> {
  LocalNotificationsNotifier() : super(null);

  Timer? timer;

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void showMessage(LocalNotification message) {
    state = message;

    // Wait for the duration of the
    // notification then hide it.
    timer = Timer(message.duration, () {
      state = message.hideMessage();
    });
  }

  void hideCurrentMessage() {
    if (state != null && state!.hide == false) {
      if (timer != null && timer!.isActive) {
        timer!.cancel();
      }
      LocalNotification message = state!.hideMessage();
      state = message;
    }
  }

  /// This method handles showing custom error messages for different exceptions.
  void showErrorMessage(
    Exception e, {
    StackTrace? s,
    bool shouldRecordError = true,
  }) async {
    log(e.toString());

    if (s != null) log(s.toString());

    String message = getErrorMessageFromException(e);

    LocalNotification notification = LocalNotification(
      message: message,
      duration: const Duration(seconds: 3),
      useErrorColor: true,
    );

    state = notification;

    // Wait for the duration of the message then hide it.
    timer = Timer(notification.duration, () {
      state = notification.hideMessage();
    });
  }

  String getErrorMessageFromException(Exception e) {
    if (e is FirebaseAuthException) {
      return e.message ?? 'Something went wrong';
    }
    return 'Something went wrong';
  }
}
