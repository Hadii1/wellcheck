import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/providers/user_provider.dart';
import 'package:wellcheck/screens/home.dart';
import 'package:wellcheck/screens/login.dart';
import 'package:wellcheck/utils/enums.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  void navigate(Widget screen, BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userProvider,
      (_, v) async {
        if (v.status == NetworkCallStatus.success) {
          navigate(
            v.data == null ? const LoginScreen() : const HomeScreen(),
            context,
          );
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
                color: Colors.blue,
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
