import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/firebase_options.dart';
import 'package:wellcheck/screens/splash.dart';
import 'package:wellcheck/shared/widgets/notification_banner.dart';
import 'package:wellcheck/utils/styles.dart';

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
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
        primaryColor: Styles.mainPurple,
        switchTheme: SwitchThemeData(
          thumbColor: WidgetStateProperty.resolveWith(
            (state) => state.contains(WidgetState.selected)
                ? Styles.mainPurple
                : Styles.mainGrey,
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (state) => state.contains(WidgetState.selected)
                ? Styles.lightGrey2
                : Styles.lightGrey2,
          ),
          trackOutlineColor: WidgetStateProperty.resolveWith(
            (_) => Colors.transparent,
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Styles.mainPurple,
          foregroundColor: Colors.white,
        ),
      ),
      builder: (context, child) {
        return Stack(
          children: [
            child!,
            const LocalNotificationsBanner(),
          ],
        );
      },
    );
  }
}
