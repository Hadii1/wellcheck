import 'package:flutter/material.dart';

class LocalNotification {
  final String? link;
  final IconData? icon;
  final bool useErrorColor;
  final String message;
  // How long to show the notifications
  final Duration duration;
  // To hide the notification without losing it's content
  final bool hide;

  LocalNotification({
    this.link,
    this.icon,
    this.useErrorColor = false,
    this.hide = false,
    this.duration = const Duration(seconds: 3),
    required this.message,
  });

  static const checkMarkIcon = Icons.check_circle;

  factory LocalNotification.error(String message) => LocalNotification(
        message: message,
        useErrorColor: true,
      );

  LocalNotification hideMessage() {
    return LocalNotification(
      link: link,
      icon: icon,
      useErrorColor: useErrorColor,
      message: message,
      duration: duration,
      hide: true,
    );
  }
}
