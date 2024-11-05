import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wellcheck/screen_states/home_state.dart';
import 'package:wellcheck/screens/history.dart';
import 'package:wellcheck/shared/widgets/custom_button.dart';
import 'package:wellcheck/shared/widgets/custom_text_field.dart';
import 'package:wellcheck/utils/extensions.dart';
import 'package:wellcheck/utils/spacings.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeScreenState);
    final notifier = ref.read(homeScreenState.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WellCheck'),
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
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
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
