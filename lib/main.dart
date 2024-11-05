import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/firebase_options.dart';
import 'package:wellcheck/screens/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: WellCheckApp(),
    ),
  );
}

class WellCheckApp extends StatefulWidget {
  const WellCheckApp({super.key});

  @override
  State<WellCheckApp> createState() => _WellCheckAppState();
}

class _WellCheckAppState extends State<WellCheckApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
    );
  }
}
