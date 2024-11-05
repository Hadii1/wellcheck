import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/providers/user_provider.dart';
import 'package:wellcheck/screen_states/home_state.dart';
import 'package:wellcheck/screens/history.dart';
import 'package:wellcheck/screens/login.dart';
import 'package:wellcheck/shared/widgets/custom_button.dart';
import 'package:wellcheck/shared/widgets/custom_text_field.dart';
import 'package:wellcheck/shared/widgets/horizontal_screen_padder.dart';
import 'package:wellcheck/utils/extensions.dart';
import 'package:wellcheck/utils/general_functions.dart';
import 'package:wellcheck/utils/spacings.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  Future<void> onLogoutPressed(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirm = await showConfirmationDialog(
      context,
      body:
          'If you logout you will lose your gamble history, even after signing in again',
      title: 'Confirmation',
    );

    if (confirm == true) {
      await ref.read(userProvider.notifier).logOut();

      if (!context.mounted) return;

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeScreenState);
    final notifier = ref.read(homeScreenState.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WellCheck'),
        leading: InkWell(
          onTap: () => onLogoutPressed(context, ref),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.logout),
          ),
        ),
        actions: [
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const HistoryScreen(),
                ),
              );
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.list),
            ),
          ),
        ],
      ),
      body: HorizontalScreenPadder(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Spacings.verticalElementsSpacing(),
            Row(
              children: [
                Text(
                  'Have you gambled today?',
                  style: context.textTheme().titleLarge,
                ),
                const SizedBox(width: 12),
                Switch(
                  value: notifier.didGamleToday,
                  onChanged: (value) => notifier.didGamleToday = value,
                ),
              ],
            ),
            Spacings.verticalElementsSpacing(),
            AnimatedSizeAndFade(
              child: notifier.didGamleToday
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomTextField(
                          prefixIcon: const Icon(Icons.note),
                          hint: 'Notes',
                          onChanged: (notes) => notifier.notes = notes,
                        ),
                        Spacings.verticalElementsSpacing(),
                        RoundedButton(
                          onTap: () => notifier.submit(),
                          label: 'Submit Event',
                        )
                      ],
                    )
                  : SizedBox(
                      key: UniqueKey(),
                      height: 0,
                      width: context.screenSize().width,
                    ),
            )
          ],
        ),
      ),
    );
  }
}
