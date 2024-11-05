import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
