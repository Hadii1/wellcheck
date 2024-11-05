import 'package:flutter/widgets.dart';

class Spacings {
  static const double horizontalPadding = 16;

  static Widget verticalElementsSpacing({int factor = 3}) =>
      SizedBox(height: 8.0 * factor);
}
