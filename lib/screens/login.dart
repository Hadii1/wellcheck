import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/screen_states/login_state.dart';
import 'package:wellcheck/screens/home.dart';
import 'package:wellcheck/shared/widgets/horizontal_screen_padder.dart';
import 'package:wellcheck/utils/spacings.dart';
import 'package:wellcheck/shared/widgets/custom_button.dart';
import 'package:wellcheck/shared/widgets/custom_text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(loginScreenState);
    final notifier = ref.read(loginScreenState.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: HorizontalScreenPadder(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacings.verticalElementsSpacing(),
            CustomTextField(
              hint: 'Email',
              initialText: notifier.email,
              prefixIcon: const Icon(Icons.email),
              onChanged: (email) {
                notifier.email = email;
              },
            ),
            Spacings.verticalElementsSpacing(),
            CustomTextField(
              hint: 'Password',
              obsecure: true,
              initialText: notifier.password,
              prefixIcon: const Icon(Icons.password),
              onChanged: (password) {
                notifier.password = password;
              },
            ),
            Spacings.verticalElementsSpacing(factor: 8),
            RoundedButton(
              animateLoadingState: true,
              enabled:
                  notifier.email.isNotEmpty && notifier.password.isNotEmpty,
              onTap: () async {
                bool result = await notifier.login();
                if (context.mounted && result) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                }
              },
              label: 'Sign in',
            ),
            Spacings.verticalElementsSpacing(),
            RoundedButton(
              animateLoadingState: true,
              enabled:
                  notifier.email.isNotEmpty && notifier.password.isNotEmpty,
              onTap: () async {
                bool result = await notifier.register();
                if (context.mounted && result) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const HomeScreen(),
                    ),
                  );
                }
              },
              label: 'Register',
            ),
          ],
        ),
      ),
    );
  }
}
