import 'package:equatable/equatable.dart';
import 'package:wellcheck/models/gamble_event.dart';

abstract class HistoryState extends Equatable {
  final List<GambleEvent> events;

  const HistoryState({
    required this.events,
  });

  @override
  List<Object?> get props => [events];
}

final class InitialHistoryState extends HistoryState {
  const InitialHistoryState()
      : super(
          events: const [],
        );
}

final class HistoryFetchSuccessful extends HistoryState {
  const HistoryFetchSuccessful({
    required super.events,
  });
}

final class HistoryFetchFailed extends HistoryState {
  const HistoryFetchFailed(
    this.error,
    this.stackTrace,
  ) : super(
          events: const [],
        );

  final Exception error;
  final StackTrace stackTrace;
}
