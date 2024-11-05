import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:wellcheck/blocs/history/history_bloc.dart';
import 'package:wellcheck/blocs/history/history_state.dart';
import 'package:wellcheck/utils/extensions.dart';
import 'package:wellcheck/utils/spacings.dart';
import 'package:wellcheck/utils/styles.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = HistoryBloc();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'History',
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: Spacings.horizontalPadding),
        child: BlocConsumer<HistoryBloc, HistoryState>(
          bloc: bloc,
          listener: (context, state) {},
          builder: (context, state) {
            return AnimatedSizeAndFade(
              child: state is InitialHistoryState
                  ? const SpinKitThreeBounce(
                      color: Styles.mainPurple,
                      size: 20,
                    )
                  : state is HistoryFetchFailed
                      ? Center(
                          child: InkWell(
                            onTap: () {
                              bloc.refresh();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Error loading history',
                                style:
                                    context.textTheme().titleMedium!.copyWith(
                                          decoration: TextDecoration.underline,
                                          color: Styles.mainPurple,
                                          decorationColor: Styles.mainPurple,
                                        ),
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: () async => await bloc.refresh(),
                          child: ListView.builder(
                            itemCount: (state as HistoryFetchSuccessful)
                                .events
                                .length,
                            itemBuilder: (context, index) {
                              final event = state.events[index];
                              return Column(
                                children: [
                                  Spacings.verticalElementsSpacing(),
                                  Row(
                                    children: [
                                      Text(
                                        'Date: ',
                                        style: context.textTheme().titleMedium,
                                      ),
                                      Text(
                                        DateFormat('dd-MM-yyyy hh:mm a')
                                            .format(event.time),
                                      ),
                                    ],
                                  ),
                                  if (event.notes != null &&
                                      event.notes!.isNotEmpty)
                                    Column(
                                      children: [
                                        Spacings.verticalElementsSpacing(
                                            factor: 1),
                                        Row(
                                          children: [
                                            Text(
                                              'Notes: ',
                                              style: context
                                                  .textTheme()
                                                  .titleMedium,
                                            ),
                                            Text(
                                              event.notes!,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  const Divider(),
                                ],
                              );
                            },
                          ),
                        ),
            );
          },
        ),
      ),
    );
  }
}
