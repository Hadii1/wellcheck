import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  TextTheme textTheme() => Theme.of(this).textTheme;

  Size screenSize() => MediaQuery.of(this).size;
}
