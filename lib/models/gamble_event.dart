import 'dart:convert';

import 'package:equatable/equatable.dart';

class GambleEvent extends Equatable {
  final DateTime time;
  final String? notes;

  const GambleEvent({
    required this.time,
    required this.notes,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'time': time.millisecondsSinceEpoch});
    if (notes != null) {
      result.addAll({'notes': notes});
    }

    return result;
  }

  factory GambleEvent.fromMap(Map<String, dynamic> map) {
    return GambleEvent(
      time: DateTime.fromMillisecondsSinceEpoch(map['time']),
      notes: map['notes'],
    );
  }

  String toJson() => json.encode(toMap());

  factory GambleEvent.fromJson(String source) =>
      GambleEvent.fromMap(json.decode(source));

  @override
  List<Object?> get props => [time, notes];
}
