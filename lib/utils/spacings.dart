import 'package:flutter/widgets.dart';

class Spacings {
  static Widget topScreenPadding(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.top + 12,
      );

  static double topPadding(BuildContext context) =>
      MediaQuery.of(context).padding.top + 12;

  static Widget bottomScreenPadding(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.bottom + 12,
      );

  static double bottomPadding(BuildContext context) =>
      MediaQuery.of(context).padding.bottom + 12;

  static const double horizontalPadding = 16;

  static Widget verticalElementsSpacing({int factor = 3}) =>
      SizedBox(height: 8.0 * factor);
}
