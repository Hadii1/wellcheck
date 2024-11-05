import 'package:flutter/material.dart';
import 'package:wellcheck/screens/splash.dart';

void main() {
  runApp(const WellCheckApp());
}

class WellCheckApp extends StatelessWidget {
  const WellCheckApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
