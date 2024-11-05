import 'package:flutter/material.dart';
import 'package:wellcheck/utils/spacings.dart';

class HorizontalScreenPadder extends StatelessWidget {
  const HorizontalScreenPadder({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
      child: child,
    );
  }
}
