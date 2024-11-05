import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/providers/local_notification_provider.dart';
import 'package:wellcheck/shared/model/local_notification.dart';
import 'package:wellcheck/shared/widgets/slide_animation.dart';
import 'package:wellcheck/utils/styles.dart';

class LocalNotificationsBanner extends StatelessWidget {
  const LocalNotificationsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Consumer(
        builder: (_, ref, __) {
          LocalNotification? notification =
              ref.watch(localNotificationsProvider);
          // Null state refers to initial state with no notification to show/hide
          return notification == null
              ? const SizedBox.shrink()
              : AnimatedOpacity(
                  opacity: notification.hide ? 0 : 1,
                  duration: const Duration(milliseconds: 250),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 400),
                    hide: notification.hide,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) {
                        if (details.delta.dy.isNegative) {
                          ref
                              .read(localNotificationsProvider.notifier)
                              .hideCurrentMessage();
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 24,
                          right: 24,
                          top: 48,
                        ),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: notification.useErrorColor
                                ? Styles.mainRed
                                : Colors.green,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0.5, 2.5),
                                color: Colors.black.withOpacity(0.2),
                              )
                            ],
                          ),
                          child: Row(
                            children: [
                              notification.icon == null
                                  ? const SizedBox.shrink()
                                  : Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        notification.icon!,
                                        color: Colors.white,
                                        size: 23,
                                      ),
                                    ),
                              Expanded(
                                child: Text(
                                  notification.message,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white,
                                    height: 1.25,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
