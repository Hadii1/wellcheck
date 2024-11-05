import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wellcheck/blocs/history/history_event.dart';
import 'package:wellcheck/blocs/history/history_state.dart';
import 'package:wellcheck/services/local_storage.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc()
      : super(
          const InitialHistoryState(),
        ) {
    on<FetchHistory>(_onFetchHistory);
    add(FetchHistory());
  }

  final _localStorage = LocalStorage();

  void _onFetchHistory(HistoryEvent event, Emitter<HistoryState> emit) async {
    try {
      emit(const InitialHistoryState());
      // Adding delay to show the loading screen only
      // Remove in real scenario
      await Future.delayed(const Duration(seconds: 1));
      final events = await _localStorage.getGambleEvents();
      emit(HistoryFetchSuccessful(events: events));
    } on Exception catch (e, s) {
      emit(HistoryFetchFailed(e, s));
    }
  }

  Future<void> refresh() async => add(FetchHistory());
}
