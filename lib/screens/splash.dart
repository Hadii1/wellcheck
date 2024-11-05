import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/providers/user_provider.dart';
import 'package:wellcheck/screens/home.dart';
import 'package:wellcheck/screens/login.dart';
import 'package:wellcheck/utils/enums.dart';
import 'package:wellcheck/utils/styles.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  late final Stopwatch stopwatch;

  @override
  void initState() {
    stopwatch = Stopwatch()..start();

    super.initState();
  }

  @override
  void dispose() {
    stopwatch.stop();
    super.dispose();
  }

  void navigate(Widget screen) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(
      userProvider,
      (_, v) async {
        if (v.status == NetworkCallStatus.success) {
          if (stopwatch.elapsed.inSeconds > 2) {
            navigate(
              v.data == null ? const LoginScreen() : const HomeScreen(),
            );
          } else {
            await Future.delayed(
                Duration(seconds: 2 - stopwatch.elapsed.inSeconds));
            navigate(
              v.data == null ? const LoginScreen() : const HomeScreen(),
            );
          }
        }
      },
    );

    return Scaffold(
      body: Column(
        children: [
          const Spacer(),
          const Center(
            child: Text(
              'WellCheck',
              style: TextStyle(
                fontSize: 28,
                letterSpacing: 3,
                fontWeight: FontWeight.w900,
                color: Styles.mainPurple,
              ),
            ),
          ),
          const Spacer(),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          SizedBox(
            height: MediaQuery.of(context).padding.bottom + 24,
          )
        ],
      ),
    );
  }
}
