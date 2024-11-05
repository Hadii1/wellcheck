import 'package:equatable/equatable.dart';

sealed class HistoryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class FetchHistory extends HistoryEvent {}
